import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/age_groups_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/fees_provider.dart';
import 'package:yaru/yaru.dart';

extension FeeUnitX on FeeUnit {
  String label(BuildContext context) {
    final t = context.t.admin.fees.units;
    return switch (this) {
      FeeUnit.perBooking => t.perBooking,
      FeeUnit.perPerson => t.perPerson,
      FeeUnit.perPersonNight => t.perPersonNight,
      FeeUnit.perRoom => t.perRoom,
      FeeUnit.perRoomNight => t.perRoomNight,
    };
  }
}

class FeesSection extends ConsumerWidget {
  const FeesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.fees;
    final ageGroups = ref.watch(ageGroupsProvider).value ?? [];

    return AdminListSection<Fee>(
      value: ref.watch(feesProvider),
      onRetry: () => ref.refresh(feesProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      onAdd: () => _edit(context, ref),
      itemBuilder: (context, fee) => AdminTile(
        icon: Icons.receipt_long,
        title: fee.name,
        subtitle: [
          '${formatMoney(context, fee.amount)} ${fee.unit.label(context)}',
          ?ageGroups.where((g) => g.id == fee.ageGroupId).firstOrNull?.name,
          if (fee.taxRate > 0)
            t.tax(
              rate: formatHundredths(context, fee.taxRate, trimZeros: true),
            ),
          if (fee.autoApply) t.auto,
        ].join(' · '),
        onEdit: () => _edit(context, ref, fee),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: fee.name,
            delete: () => ref.read(serverpodClientProvider).fee.delete(fee.id!),
          );
          if (deleted) ref.invalidate(feesProvider);
        },
      ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, [Fee? fee]) async {
    if (await showAdminDialog(context, _FeeDialog(fee: fee))) {
      ref.invalidate(feesProvider);
    }
  }
}

class _FeeDialog extends ConsumerStatefulWidget {
  const _FeeDialog({this.fee});

  /// The fee to edit, or null to create one.
  final Fee? fee;

  @override
  ConsumerState<_FeeDialog> createState() => _FeeDialogState();
}

class _FeeDialogState extends ConsumerState<_FeeDialog> {
  Fee? get _fee => widget.fee;

  late final _name = TextEditingController(text: _fee?.name);
  final _amount = TextEditingController();
  final _taxRate = TextEditingController();
  late FeeUnit _unit = _fee?.unit ?? FeeUnit.perPersonNight;
  late int? _ageGroupId = _fee?.ageGroupId;
  late bool _autoApply = _fee?.autoApply ?? false;
  bool _filled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Amounts are formatted for the current language, which is not available
    // in initState yet.
    if (_filled) return;
    _filled = true;
    if (_fee case final fee?) {
      _amount.text = formatHundredths(context, fee.amount);
    }
    _taxRate.text = formatHundredths(
      context,
      _fee?.taxRate ?? 700,
      trimZeros: true,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    _taxRate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.fees;
    final ageGroups = ref.watch(ageGroupsProvider);

    return AdminFormDialog(
      title: _fee == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AmountField(
                controller: _amount,
                label: t.amount,
                suffixText: '€',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AmountField(
                controller: _taxRate,
                label: t.taxRate,
                suffixText: '%',
              ),
            ),
          ],
        ),
        DropdownButtonFormField<FeeUnit>(
          isExpanded: true,
          initialValue: _unit,
          decoration: InputDecoration(labelText: t.unit),
          items: [
            for (final unit in FeeUnit.values)
              DropdownMenuItem(value: unit, child: Text(unit.label(context))),
          ],
          onChanged: (unit) => setState(() => _unit = unit ?? _unit),
        ),
        switch (ageGroups) {
          // "All ages" is the null entry.
          AsyncData(value: final ageGroups) => DropdownButtonFormField<int?>(
            isExpanded: true,
            initialValue: _ageGroupId,
            decoration: InputDecoration(labelText: t.ageGroup),
            items: [
              DropdownMenuItem(value: null, child: Text(t.allAges)),
              for (final group in ageGroups)
                DropdownMenuItem(value: group.id, child: Text(group.name)),
            ],
            onChanged: (id) => setState(() => _ageGroupId = id),
          ),
          AsyncError(:final error) => Text(
            context.t.common.loadFailed(error: error),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
        YaruSwitchListTile(
          title: Text(t.autoApply),
          subtitle: Text(t.autoApplyHint),
          value: _autoApply,
          onChanged: (value) => setState(() => _autoApply = value),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).fee;
    final fee = Fee(
      id: _fee?.id,
      name: _name.text.trim(),
      amount: parseHundredths(_amount.text)!,
      unit: _unit,
      ageGroupId: _ageGroupId,
      taxRate: parseHundredths(_taxRate.text)!,
      autoApply: _autoApply,
    );
    await (fee.id == null ? endpoint.add(fee) : endpoint.update(fee));
  }
}
