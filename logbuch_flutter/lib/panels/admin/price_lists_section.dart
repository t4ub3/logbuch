import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/admin/fees_section.dart';
import 'package:logbuch_flutter/providers/age_groups_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/fees_provider.dart';
import 'package:logbuch_flutter/providers/meal_plans_provider.dart';
import 'package:logbuch_flutter/providers/price_list_prices_provider.dart';
import 'package:logbuch_flutter/providers/price_lists_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:logbuch_flutter/providers/unit_types_provider.dart';
import 'package:yaru/yaru.dart';

/// What a price of a price list is for.
enum PriceKind {
  /// A guest of an age group in a unit of a type, per night.
  guest,

  /// A unit of a type as a whole, per night.
  unitNight,

  /// A unit of a type for a booking that comes for the day only.
  unitDay,

  /// A guest of an age group with a meal plan, per night.
  meal,

  /// A surcharge or fee.
  fee,
}

/// Names a price of a list: its kind, what it is for (a unit type, a meal
/// plan or a fee) and its age group, which is 0 where ages do not matter.
typedef PriceKey = (PriceKind kind, int id, int ageGroupId);

/// The prices of a list in cents.
typedef Prices = Map<PriceKey, int>;

/// The list that prices today, or else the first one. [lists] must be
/// sorted by their first day and not be empty.
PriceList currentPriceList(List<PriceList> lists, DateTime today) =>
    lists.lastWhere(
      (list) => !list.validFrom.isAfter(today),
      orElse: () => lists.first,
    );

Prices _toPrices(PriceListPrices prices) => {
  for (final rate in prices.roomRates)
    (PriceKind.guest, rate.unitTypeId, rate.ageGroupId): rate.pricePerNight,
  for (final price in prices.unitPrices) ...{
    (PriceKind.unitNight, price.unitTypeId, 0): ?price.pricePerNight,
    (PriceKind.unitDay, price.unitTypeId, 0): ?price.dayUsePrice,
  },
  for (final rate in prices.mealRates)
    (PriceKind.meal, rate.mealPlanId, rate.ageGroupId): rate.pricePerNight,
  for (final price in prices.feePrices)
    (PriceKind.fee, price.feeId, 0): price.amount,
};

PriceListPrices _fromPrices(int listId, Prices prices) {
  final unitTypes = {
    for (final (kind, id, _) in prices.keys)
      if (kind == PriceKind.unitNight || kind == PriceKind.unitDay) id,
  };
  return PriceListPrices(
    roomRates: [
      for (final MapEntry(key: (kind, id, ageGroup), value: price)
          in prices.entries)
        if (kind == PriceKind.guest)
          RoomRate(
            priceListId: listId,
            unitTypeId: id,
            ageGroupId: ageGroup,
            pricePerNight: price,
          ),
    ],
    unitPrices: [
      for (final id in unitTypes)
        UnitPrice(
          priceListId: listId,
          unitTypeId: id,
          pricePerNight: prices[(PriceKind.unitNight, id, 0)],
          dayUsePrice: prices[(PriceKind.unitDay, id, 0)],
        ),
    ],
    mealRates: [
      for (final MapEntry(key: (kind, id, ageGroup), value: price)
          in prices.entries)
        if (kind == PriceKind.meal)
          MealRate(
            priceListId: listId,
            mealPlanId: id,
            ageGroupId: ageGroup,
            pricePerNight: price,
          ),
    ],
    feePrices: [
      for (final MapEntry(key: (kind, id, _), value: price) in prices.entries)
        if (kind == PriceKind.fee)
          FeePrice(priceListId: listId, feeId: id, amount: price),
    ],
  );
}

/// The price lists, and all prices of the selected one: what guests pay
/// per night by unit type and age group, what a unit costs as a whole, the
/// meals, and the surcharges and fees.
class PriceListsSection extends ConsumerStatefulWidget {
  const PriceListsSection({super.key});

  @override
  ConsumerState<PriceListsSection> createState() => _PriceListsSectionState();
}

class _PriceListsSectionState extends ConsumerState<PriceListsSection> {
  int? _listId;

  /// Whether the prices have unsaved changes. The list cannot be switched
  /// meanwhile, as that would drop the changes.
  bool _dirty = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.priceLists;
    final canEdit = ref.watch(canEditProvider);

    return switch (ref.watch(priceListsProvider)) {
      AsyncError(:final error) => _Message(
        context.t.common.loadFailed(error: error),
      ),
      AsyncValue(value: final lists?) when lists.isEmpty => _Message(
        t.empty,
        action: canEdit
            ? ElevatedButton.icon(
                icon: const Icon(YaruIcons.plus),
                label: Text(t.add),
                onPressed: () => _edit(lists),
              )
            : null,
      ),
      AsyncValue(value: final lists?) => _buildLists(context, lists, canEdit),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildLists(
    BuildContext context,
    List<PriceList> lists,
    bool canEdit,
  ) {
    final t = context.t.admin.priceLists;
    final common = context.t.common;
    final list = lists.firstWhere(
      (list) => list.id == _listId,
      orElse: () => currentPriceList(lists, toUtcDate(DateTime.now())),
    );
    final listId = list.id!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final other in lists)
                ChoiceChip(
                  label: Text(other.name),
                  tooltip: t.from(date: formatDate(context, other.validFrom)),
                  selected: other.id == listId,
                  onSelected: _dirty && other.id != listId
                      ? null
                      : (_) => setState(() => _listId = other.id),
                ),
              Text(
                t.from(date: formatDate(context, list.validFrom)),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (canEdit) ...[
                IconButton(
                  tooltip: common.edit,
                  icon: const Icon(YaruIcons.pen),
                  onPressed: _dirty ? null : () => _edit(lists, list),
                ),
                IconButton(
                  tooltip: common.delete,
                  icon: const Icon(YaruIcons.trash),
                  onPressed: _dirty ? null : () => _delete(list),
                ),
                ElevatedButton.icon(
                  icon: const Icon(YaruIcons.plus),
                  label: Text(t.add),
                  onPressed: _dirty ? null : () => _edit(lists),
                ),
              ],
            ],
          ),
        ),
        Expanded(child: _buildPrices(context, listId, canEdit)),
      ],
    );
  }

  Widget _buildPrices(BuildContext context, int listId, bool canEdit) {
    final unitTypes = ref.watch(unitTypesProvider);
    final ageGroups = ref.watch(ageGroupsProvider);
    final mealPlans = ref.watch(mealPlansProvider);
    final fees = ref.watch(feesProvider);
    final prices = ref.watch(priceListPricesProvider(listId));

    for (final AsyncValue<Object> value in [
      unitTypes,
      ageGroups,
      mealPlans,
      fees,
      prices,
    ]) {
      if (value case AsyncError(:final error)) {
        return _Message(context.t.common.loadFailed(error: error));
      }
    }
    // Also while the prices are loaded again after saving, so that the
    // fields do not flicker.
    return switch ((
      unitTypes.value,
      ageGroups.value,
      mealPlans.value,
      fees.value,
      prices.value,
    )) {
      (
        final unitTypes?,
        final ageGroups?,
        final mealPlans?,
        final fees?,
        final prices?,
      ) =>
        unitTypes.isEmpty && mealPlans.isEmpty && fees.isEmpty
            ? _Message(context.t.admin.priceLists.nothingToPrice)
            : _PriceEditor(
                // New fields per list, so that nothing entered for one of
                // them shows up in another.
                key: ValueKey(listId),
                unitTypes: unitTypes,
                ageGroups: ageGroups,
                mealPlans: mealPlans,
                fees: fees,
                prices: _toPrices(prices),
                readOnly: !canEdit,
                onDirtyChanged: (dirty) => setState(() => _dirty = dirty),
                onSave: (prices) => _save(listId, prices),
              ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  /// Edits [list], or adds one if there is none, and shows it afterwards.
  Future<void> _edit(List<PriceList> lists, [PriceList? list]) async {
    PriceList? saved;
    final dialog = _PriceListDialog(
      list: list,
      onSaved: (list) => saved = list,
    );
    if (!await showAdminDialog(context, dialog) || !mounted) return;
    ref.invalidate(priceListsProvider);
    setState(() => _listId = saved?.id);
  }

  Future<void> _delete(PriceList list) async {
    final deleted = await confirmAndDelete(
      context,
      name: list.name,
      hint: context.t.admin.priceLists.deleteHint,
      delete: () =>
          ref.read(serverpodClientProvider).priceList.delete(list.id!),
    );
    if (!deleted || !mounted) return;
    ref.invalidate(priceListsProvider);
    setState(() => _listId = null);
  }

  Future<void> _save(int listId, Prices prices) async {
    await ref
        .read(serverpodClientProvider)
        .priceList
        .savePrices(listId, _fromPrices(listId, prices));
    ref.invalidate(priceListPricesProvider(listId));
    if (!mounted) return;
    setState(() => _dirty = false);
    ref.read(statusProvider.notifier).done(context.t.admin.priceLists.saved);
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text, {this.action});

  final String text;

  /// Shown below the text, e.g. a button to get started.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(text, textAlign: TextAlign.center),
            ?action,
          ],
        ),
      ),
    );
  }
}

/// The form of a price list: its name and its first day.
class _PriceListDialog extends ConsumerStatefulWidget {
  const _PriceListDialog({this.list, required this.onSaved});

  /// The list to edit, or null to create one.
  final PriceList? list;

  /// Called with the list as it was saved.
  final ValueChanged<PriceList> onSaved;

  @override
  ConsumerState<_PriceListDialog> createState() => _PriceListDialogState();
}

class _PriceListDialogState extends ConsumerState<_PriceListDialog> {
  late final _name = TextEditingController(text: widget.list?.name);

  /// The first day of the list as a local date.
  late DateTime? _validFrom = switch (widget.list) {
    final list? => toLocalDate(list.validFrom),
    null => null,
  };

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.priceLists;

    return AdminFormDialog(
      title: widget.list == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        FormField<DateTime>(
          validator: (_) =>
              _validFrom == null ? context.t.common.required : null,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateField(
                label: t.validFrom,
                date: _validFrom,
                onChanged: (date) => setState(() => _validFrom = date),
              ),
              if (field.errorText case final error?)
                Text(
                  error,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
        if (widget.list == null)
          Text(t.addHint, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).priceList;
    final list = PriceList(
      id: widget.list?.id,
      name: _name.text.trim(),
      validFrom: toUtcDate(_validFrom!),
    );
    widget.onSaved(
      await (list.id == null ? endpoint.add(list) : endpoint.update(list)),
    );
  }
}

/// One field per price of a list, saved as a whole.
class _PriceEditor extends StatefulWidget {
  const _PriceEditor({
    super.key,
    required this.unitTypes,
    required this.ageGroups,
    required this.mealPlans,
    required this.fees,
    required this.prices,
    required this.readOnly,
    required this.onDirtyChanged,
    required this.onSave,
  });

  final List<UnitType> unitTypes;
  final List<AgeGroup> ageGroups;
  final List<MealPlan> mealPlans;
  final List<Fee> fees;

  /// The stored prices the fields start with.
  final Prices prices;

  /// Whether the prices are only shown, for users who may not change
  /// data.
  final bool readOnly;

  /// Called when the fields start or stop differing from [prices].
  final ValueChanged<bool> onDirtyChanged;

  /// Stores the entered prices; one that is missing has no price.
  final Future<void> Function(Prices prices) onSave;

  @override
  State<_PriceEditor> createState() => _PriceEditorState();
}

class _PriceEditorState extends State<_PriceEditor> {
  final _cells = <PriceKey, TextEditingController>{};
  bool _dirty = false;
  bool _saving = false;
  Object? _error;

  /// Set while the fields are filled by [didUpdateWidget].
  bool _adopting = false;

  /// The prices there is a field for.
  Iterable<PriceKey> get _keys sync* {
    for (final type in widget.unitTypes) {
      for (final ageGroup in widget.ageGroups) {
        yield (PriceKind.guest, type.id!, ageGroup.id!);
      }
      yield (PriceKind.unitNight, type.id!, 0);
      yield (PriceKind.unitDay, type.id!, 0);
    }
    for (final plan in widget.mealPlans) {
      for (final ageGroup in widget.ageGroups) {
        yield (PriceKind.meal, plan.id!, ageGroup.id!);
      }
    }
    for (final fee in widget.fees) {
      yield (PriceKind.fee, fee.id!, 0);
    }
  }

  @override
  void didUpdateWidget(_PriceEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The stored prices changed, usually because they were just saved. If
    // they are what the fields say, show them the way they are formatted
    // when loaded. Anything else that was entered is kept.
    if (mapEquals(oldWidget.prices, widget.prices)) return;
    final entered = _entered();
    if (entered == null || !mapEquals(entered, _shown)) return;
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

  /// The controller of a field, created with the stored price on first
  /// use. That happens while building, as formatting needs the current
  /// language.
  TextEditingController _cell(BuildContext context, PriceKey key) {
    return _cells.putIfAbsent(
      key,
      () =>
          TextEditingController(text: _stored(context, key))
            ..addListener(_onChanged),
    );
  }

  String _stored(BuildContext context, PriceKey key) {
    final price = widget.prices[key];
    return price == null ? '' : formatHundredths(context, price);
  }

  /// The entered prices, or null while one of the fields is not an amount.
  Prices? _entered() {
    final prices = <PriceKey, int>{};
    for (final key in _keys) {
      final controller = _cells[key];
      // A field that was not built yet still says what is stored.
      if (controller == null) {
        if (widget.prices[key] case final price?) prices[key] = price;
        continue;
      }
      final text = controller.text.trim();
      if (text.isEmpty) continue;
      final price = parseHundredths(text);
      if (price == null) return null;
      prices[key] = price;
    }
    return prices;
  }

  /// What is stored for the fields there are. Prices of things that were
  /// deleted meanwhile do not count as a change.
  Prices get _shown => {for (final key in _keys) key: ?widget.prices[key]};

  void _onChanged() {
    if (_adopting) return;
    final entered = _entered();
    final dirty = entered == null || !mapEquals(entered, _shown);
    if (dirty != _dirty) widget.onDirtyChanged(dirty);
    setState(() => _dirty = dirty);
  }

  void _discard() {
    for (final MapEntry(:key, value: controller) in _cells.entries) {
      controller.text = _stored(context, key);
    }
    setState(() => _error = null);
  }

  Future<void> _save(Prices prices) async {
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
    final t = context.t.admin.priceLists;
    final theme = Theme.of(context);
    final entered = _entered();

    Widget cell(PriceKind kind, int id, [int ageGroupId = 0]) => _PriceCell(
      controller: _cell(context, (kind, id, ageGroupId)),
      enabled: !_saving && !widget.readOnly,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kYaruPagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                if (widget.unitTypes.isNotEmpty)
                  _PriceTable(
                    title: t.lodging,
                    columns: [
                      t.unitType,
                      for (final ageGroup in widget.ageGroups) ageGroup.name,
                      t.perUnit,
                      t.dayUse,
                    ],
                    rows: [
                      for (final type in widget.unitTypes)
                        (
                          type.name,
                          null,
                          [
                            for (final ageGroup in widget.ageGroups)
                              cell(PriceKind.guest, type.id!, ageGroup.id!),
                            cell(PriceKind.unitNight, type.id!),
                            cell(PriceKind.unitDay, type.id!),
                          ],
                        ),
                    ],
                  ),
                if (widget.mealPlans.isNotEmpty && widget.ageGroups.isNotEmpty)
                  _PriceTable(
                    title: t.meals,
                    columns: [
                      t.mealPlan,
                      for (final ageGroup in widget.ageGroups) ageGroup.name,
                    ],
                    rows: [
                      for (final plan in widget.mealPlans)
                        (
                          plan.name,
                          null,
                          [
                            for (final ageGroup in widget.ageGroups)
                              cell(PriceKind.meal, plan.id!, ageGroup.id!),
                          ],
                        ),
                    ],
                  ),
                if (widget.fees.isNotEmpty)
                  _PriceTable(
                    title: t.fees,
                    columns: [t.fee, t.amount],
                    rows: [
                      for (final fee in widget.fees)
                        (
                          fee.name,
                          fee.unit.label(context),
                          [cell(PriceKind.fee, fee.id!)],
                        ),
                    ],
                  ),
              ],
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
                ElevatedButton.icon(
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

/// A row of a [_PriceTable]: its name, a detail below the name if there is
/// one, and its fields.
typedef _PriceRow = (String name, String? detail, List<Widget> cells);

/// A titled grid of price fields that scrolls sideways where the window is
/// too narrow for its columns.
class _PriceTable extends StatelessWidget {
  const _PriceTable({
    required this.title,
    required this.columns,
    required this.rows,
  });

  final String title;

  /// The headings, of which the first names the rows.
  final List<String> columns;
  final List<_PriceRow> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.labelLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(title, style: theme.textTheme.titleMedium),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(136),
            columnWidths: const {0: IntrinsicColumnWidth()},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  _HeaderCell(columns.first, style: headerStyle),
                  for (final column in columns.skip(1))
                    _HeaderCell(
                      column,
                      style: headerStyle,
                      textAlign: TextAlign.end,
                    ),
                ],
              ),
              for (final (name, detail, cells) in rows)
                TableRow(
                  children: [
                    _HeaderCell(name, detail: detail),
                    ...cells,
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, {this.detail, this.style, this.textAlign});

  final String text;

  /// Said in small print below the text.
  final String? detail;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(text, style: style, textAlign: textAlign),
          if (detail case final detail?)
            Text(detail, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
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
