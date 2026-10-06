import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/seasons_provider.dart';
import 'package:yaru/yaru.dart';

/// The periods between consecutive [seasons] that no season covers, each as
/// its first and last day. [seasons] must be sorted by start.
List<(DateTime, DateTime)> seasonGaps(List<Season> seasons) {
  final gaps = <(DateTime, DateTime)>[];
  for (var i = 1; i < seasons.length; i++) {
    final end = seasons[i - 1].validTo;
    final nextStart = seasons[i].validFrom;
    final expectedStart = DateTime.utc(end.year, end.month, end.day + 1);
    if (nextStart.isAfter(expectedStart)) {
      gaps.add((
        expectedStart,
        DateTime.utc(nextStart.year, nextStart.month, nextStart.day - 1),
      ));
    }
  }
  return gaps;
}

class SeasonsSection extends ConsumerWidget {
  const SeasonsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.seasons;
    final seasons = ref.watch(seasonsProvider);
    final gaps = seasonGaps(seasons.value ?? []);

    return AdminListSection<Season>(
      value: seasons,
      onRetry: () => ref.refresh(seasonsProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      onAdd: () => _edit(context, ref),
      banner: gaps.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: YaruInfoBox(
                yaruInfoType: YaruInfoType.warning,
                subtitle: Text(
                  [
                    for (final (from, to) in gaps)
                      t.gap(
                        from: formatDate(context, from),
                        to: formatDate(context, to),
                      ),
                  ].join('\n'),
                ),
              ),
            ),
      itemBuilder: (context, season) => AdminTile(
        icon: YaruIcons.sun,
        title: season.name,
        subtitle:
            '${formatDate(context, season.validFrom)} – '
            '${formatDate(context, season.validTo)}',
        onEdit: () => _edit(context, ref, season),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: season.name,
            hint: t.deleteHint,
            delete: () =>
                ref.read(serverpodClientProvider).season.delete(season.id!),
          );
          if (deleted) ref.invalidate(seasonsProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    Season? season,
  ]) async {
    if (await showAdminDialog(context, _SeasonDialog(season: season))) {
      ref.invalidate(seasonsProvider);
    }
  }
}

class _SeasonDialog extends ConsumerStatefulWidget {
  const _SeasonDialog({this.season});

  /// The season to edit, or null to create one.
  final Season? season;

  @override
  ConsumerState<_SeasonDialog> createState() => _SeasonDialogState();
}

class _SeasonDialogState extends ConsumerState<_SeasonDialog> {
  Season? get _season => widget.season;

  late final _name = TextEditingController(text: _season?.name);

  /// First and last day of the season as local dates.
  late DateTimeRange? _period = switch (_season) {
    final season? => DateTimeRange(
      start: toLocalDate(season.validFrom),
      end: toLocalDate(season.validTo),
    ),
    null => null,
  };

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.seasons;

    return AdminFormDialog(
      title: _season == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        _PeriodField(
          period: _period,
          onChanged: (period) => setState(() => _period = period),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).season;
    final season = Season(
      id: _season?.id,
      name: _name.text.trim(),
      validFrom: toUtcDate(_period!.start),
      validTo: toUtcDate(_period!.end),
    );
    await (season.id == null ? endpoint.add(season) : endpoint.update(season));
  }
}

/// A required field that picks the first and last day of a season.
class _PeriodField extends StatelessWidget {
  const _PeriodField({required this.period, required this.onChanged});

  final DateTimeRange? period;
  final ValueChanged<DateTimeRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = MaterialLocalizations.of(context);
    final period = this.period;

    return FormField<DateTimeRange>(
      validator: (_) => this.period == null ? context.t.common.required : null,
      builder: (field) => InkWell(
        onTap: () => _pick(context),
        child: InputDecorator(
          isEmpty: period == null,
          decoration: InputDecoration(
            labelText: context.t.admin.seasons.period,
            errorText: field.errorText,
            suffixIcon: const Icon(Icons.date_range),
          ),
          child: period == null
              ? null
              : Text(
                  '${l10n.formatShortDate(period.start)} – '
                  '${l10n.formatShortDate(period.end)}',
                ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: period,
      currentDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
      // The range picker is always full screen; shrink it to a dialog.
      builder: (context, child) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 528, maxHeight: 600),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: child,
          ),
        ),
      ),
    );
    if (picked != null) onChanged(picked);
  }
}
