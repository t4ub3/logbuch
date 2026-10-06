import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/providers/age_groups_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/meal_plans_provider.dart';
import 'package:logbuch_flutter/providers/meal_rates_provider.dart';
import 'package:logbuch_flutter/providers/price_categories_provider.dart';
import 'package:logbuch_flutter/providers/room_rates_provider.dart';
import 'package:logbuch_flutter/providers/seasons_provider.dart';
import 'package:yaru/yaru.dart';

/// What the prices of a [RatesSection] are for. Lodging is priced per price
/// category, meals per meal plan.
enum RateKind { lodging, meals }

/// A row of the price matrix: a price category or a meal plan.
typedef RateRow = ({int id, String name});

/// Prices in cents by the ids of their row and their age group.
typedef RatePrices = Map<(int, int), int>;

/// Edits the prices per night of one season as a matrix of price categories
/// or meal plans by age groups.
class RatesSection extends ConsumerStatefulWidget {
  const RatesSection({super.key});

  @override
  ConsumerState<RatesSection> createState() => _RatesSectionState();
}

class _RatesSectionState extends ConsumerState<RatesSection> {
  RateKind _kind = RateKind.lodging;
  int? _seasonId;

  /// Whether the matrix has unsaved changes. The kind and the season cannot
  /// be switched meanwhile, as that would drop the changes.
  bool _dirty = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.rates;
    final seasons = ref.watch(seasonsProvider);
    final ageGroups = ref.watch(ageGroupsProvider);
    final AsyncValue<List<RateRow>> rows = switch (_kind) {
      RateKind.lodging =>
        ref
            .watch(priceCategoriesProvider)
            .whenData(
              (list) => [for (final c in list) (id: c.id!, name: c.name)],
            ),
      RateKind.meals =>
        ref
            .watch(mealPlansProvider)
            .whenData(
              (list) => [for (final p in list) (id: p.id!, name: p.name)],
            ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: SegmentedButton<RateKind>(
              segments: [
                ButtonSegment(
                  value: RateKind.lodging,
                  label: Text(t.lodging),
                  icon: const Icon(Icons.bed),
                ),
                ButtonSegment(
                  value: RateKind.meals,
                  label: Text(t.meals),
                  icon: const Icon(Icons.restaurant),
                ),
              ],
              selected: {_kind},
              showSelectedIcon: false,
              onSelectionChanged: _dirty
                  ? null
                  : (selection) => setState(() => _kind = selection.single),
            ),
          ),
        ),
        Expanded(
          child: switch ((seasons, ageGroups, rows)) {
            (
              AsyncData(value: final seasons),
              AsyncData(value: final ageGroups),
              AsyncData(value: final rows),
            ) =>
              seasons.isEmpty || ageGroups.isEmpty || rows.isEmpty
                  ? _Message(
                      _kind == RateKind.lodging
                          ? t.missingLodging
                          : t.missingMeals,
                    )
                  : _buildSeasons(context, seasons, ageGroups, rows),
            (AsyncError(:final error), _, _) ||
            (_, AsyncError(:final error), _) ||
            (_, _, AsyncError(:final error)) => _Message(
              context.t.common.loadFailed(error: error),
            ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }

  Widget _buildSeasons(
    BuildContext context,
    List<Season> seasons,
    List<AgeGroup> ageGroups,
    List<RateRow> rows,
  ) {
    final season = seasons.firstWhere(
      (season) => season.id == _seasonId,
      orElse: () => _currentSeason(seasons),
    );
    final seasonId = season.id!;
    final AsyncValue<RatePrices> prices = switch (_kind) {
      RateKind.lodging =>
        ref
            .watch(roomRatesProvider(seasonId))
            .whenData(
              (rates) => {
                for (final rate in rates)
                  (rate.priceCategoryId, rate.ageGroupId): rate.pricePerNight,
              },
            ),
      RateKind.meals =>
        ref
            .watch(mealRatesProvider(seasonId))
            .whenData(
              (rates) => {
                for (final rate in rates)
                  (rate.mealPlanId, rate.ageGroupId): rate.pricePerNight,
              },
            ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in seasons)
                ChoiceChip(
                  label: Text(s.name),
                  tooltip:
                      '${formatDate(context, s.validFrom)} – '
                      '${formatDate(context, s.validTo)}',
                  selected: s.id == seasonId,
                  onSelected: _dirty && s.id != seasonId
                      ? null
                      : (_) => setState(() => _seasonId = s.id),
                ),
            ],
          ),
        ),
        Expanded(
          child: switch (prices) {
            AsyncError(:final error) => _Message(
              context.t.common.loadFailed(error: error),
            ),
            // Also while the prices are loaded again after saving, so that
            // the matrix does not flicker.
            AsyncValue(value: final prices?) => _RateMatrix(
              // A new matrix per kind and season, so that nothing entered
              // for one of them shows up in another.
              key: ValueKey((_kind, seasonId)),
              rowHeader: _kind == RateKind.lodging
                  ? context.t.admin.rates.priceCategory
                  : context.t.admin.rates.mealPlan,
              rows: rows,
              ageGroups: ageGroups,
              prices: prices,
              readOnly: !ref.watch(canEditProvider),
              onDirtyChanged: (dirty) => setState(() => _dirty = dirty),
              onSave: (prices) => _save(_kind, seasonId, prices),
            ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }

  /// The season of today, or else the first one. [seasons] is not empty.
  Season _currentSeason(List<Season> seasons) {
    final today = toUtcDate(DateTime.now());
    return seasons.firstWhere(
      (s) => !today.isBefore(s.validFrom) && !today.isAfter(s.validTo),
      orElse: () => seasons.first,
    );
  }

  Future<void> _save(RateKind kind, int seasonId, RatePrices prices) async {
    final client = ref.read(serverpodClientProvider);
    switch (kind) {
      case RateKind.lodging:
        await client.roomRate.saveForSeason(seasonId, [
          for (final MapEntry(key: (row, ageGroup), value: price)
              in prices.entries)
            RoomRate(
              seasonId: seasonId,
              priceCategoryId: row,
              ageGroupId: ageGroup,
              pricePerNight: price,
            ),
        ]);
        ref.invalidate(roomRatesProvider(seasonId));
      case RateKind.meals:
        await client.mealRate.saveForSeason(seasonId, [
          for (final MapEntry(key: (row, ageGroup), value: price)
              in prices.entries)
            MealRate(
              seasonId: seasonId,
              mealPlanId: row,
              ageGroupId: ageGroup,
              pricePerNight: price,
            ),
        ]);
        ref.invalidate(mealRatesProvider(seasonId));
    }
    if (!mounted) return;
    setState(() => _dirty = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.t.admin.rates.saved)));
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}

/// A grid with one price field per row and age group, saved as a whole.
class _RateMatrix extends StatefulWidget {
  const _RateMatrix({
    super.key,
    required this.rowHeader,
    required this.rows,
    required this.ageGroups,
    required this.prices,
    required this.readOnly,
    required this.onDirtyChanged,
    required this.onSave,
  });

  /// Heading of the first column, which names the [rows].
  final String rowHeader;
  final List<RateRow> rows;
  final List<AgeGroup> ageGroups;

  /// The stored prices the fields start with.
  final RatePrices prices;

  /// Whether the prices are only shown, for users who may not change
  /// data.
  final bool readOnly;

  /// Called when the fields start or stop differing from [prices].
  final ValueChanged<bool> onDirtyChanged;

  /// Stores the entered prices; a cell that is missing has no price.
  final Future<void> Function(RatePrices prices) onSave;

  @override
  State<_RateMatrix> createState() => _RateMatrixState();
}

class _RateMatrixState extends State<_RateMatrix> {
  final _cells = <(int, int), TextEditingController>{};
  bool _dirty = false;
  bool _saving = false;
  Object? _error;

  /// Set while the fields are filled by [didUpdateWidget].
  bool _adopting = false;

  @override
  void didUpdateWidget(_RateMatrix oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The stored prices changed, usually because they were just saved. If
    // they are what the fields say, show them the way they are formatted
    // when loaded. Anything else that was entered is kept.
    if (mapEquals(oldWidget.prices, widget.prices)) return;
    final entered = _entered();
    if (entered == null || !mapEquals(entered, widget.prices)) return;
    _adopting = true;
    for (final MapEntry(:key, value: controller) in _cells.entries) {
      controller.text = _stored(context, key);
    }
    _adopting = false;
    _dirty = false;
  }

  @override
  void dispose() {
    for (final controller in _cells.values) {
      controller.dispose();
    }
    super.dispose();
  }

  /// The controller of a cell, created with the stored price on first use.
  /// That happens while building, as formatting needs the current language.
  TextEditingController _cell(BuildContext context, (int, int) key) {
    return _cells.putIfAbsent(
      key,
      () =>
          TextEditingController(text: _stored(context, key))
            ..addListener(_onChanged),
    );
  }

  String _stored(BuildContext context, (int, int) key) {
    final price = widget.prices[key];
    return price == null ? '' : formatHundredths(context, price);
  }

  /// The entered prices, or null while one of the fields is not an amount.
  RatePrices? _entered() {
    final prices = <(int, int), int>{};
    for (final row in widget.rows) {
      for (final ageGroup in widget.ageGroups) {
        final key = (row.id, ageGroup.id!);
        final text = _cells[key]?.text.trim() ?? '';
        if (text.isEmpty) continue;
        final price = parseHundredths(text);
        if (price == null) return null;
        prices[key] = price;
      }
    }
    return prices;
  }

  void _onChanged() {
    if (_adopting) return;
    final entered = _entered();
    final dirty = entered == null || !mapEquals(entered, widget.prices);
    if (dirty != _dirty) widget.onDirtyChanged(dirty);
    setState(() => _dirty = dirty);
  }

  void _discard() {
    for (final MapEntry(:key, value: controller) in _cells.entries) {
      controller.text = _stored(context, key);
    }
    setState(() => _error = null);
  }

  Future<void> _save(RatePrices prices) async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(prices);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.rates;
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.labelLarge;
    final entered = _entered();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kYaruPagePadding),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(136),
                columnWidths: const {0: IntrinsicColumnWidth()},
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      _HeaderCell(widget.rowHeader, style: headerStyle),
                      for (final ageGroup in widget.ageGroups)
                        _HeaderCell(
                          ageGroup.name,
                          style: headerStyle,
                          textAlign: TextAlign.end,
                        ),
                    ],
                  ),
                  for (final row in widget.rows)
                    TableRow(
                      children: [
                        _HeaderCell(row.name),
                        for (final ageGroup in widget.ageGroups)
                          _PriceCell(
                            controller: _cell(context, (row.id, ageGroup.id!)),
                            enabled: !_saving && !widget.readOnly,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: switch (_error) {
                  final error? => Text(
                    validationMessage(context, error) ??
                        context.t.common.saveFailed(error: error),
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  null when entered == null => Text(
                    t.invalid,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  null => Text(t.hint, style: theme.textTheme.bodySmall),
                },
              ),
              if (!widget.readOnly) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: _dirty && !_saving ? _discard : null,
                  child: Text(context.t.common.discard),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  icon: const Icon(YaruIcons.save),
                  label: Text(context.t.common.save),
                  onPressed: _dirty && !_saving && entered != null
                      ? () => _save(entered)
                      : null,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, {this.style, this.textAlign});

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}

class _PriceCell extends StatelessWidget {
  const _PriceCell({required this.controller, required this.enabled});

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final text = controller.text.trim();
    final invalid = text.isNotEmpty && parseHundredths(text) == null;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextField(
        controller: controller,
        enabled: enabled,
        textAlign: TextAlign.end,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: invalid
            ? TextStyle(color: Theme.of(context).colorScheme.error)
            : null,
        decoration: const InputDecoration(isDense: true, suffixText: '€'),
      ),
    );
  }
}
