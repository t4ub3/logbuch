import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';
import 'package:logbuch_flutter/providers/unit_types_provider.dart';
import 'package:yaru/yaru.dart';

/// The kinds of rooms and houses that are priced the same way. What they
/// cost is entered in the price lists.
class UnitTypesSection extends ConsumerWidget {
  const UnitTypesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.unitTypes;
    final types = ref.watch(unitTypesProvider);

    return AdminListSection<UnitType>(
      value: types,
      onRetry: () => ref.refresh(unitTypesProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      // New types go to the end of the list.
      onAdd: () => _edit(
        context,
        ref,
        _UnitTypeDialog(
          sortOrder: (types.value ?? []).fold(
            0,
            (next, type) => type.sortOrder >= next ? type.sortOrder + 1 : next,
          ),
        ),
      ),
      itemBuilder: (context, type) => AdminTile(
        icon: YaruIcons.tag,
        title: type.name,
        subtitle: [
          context.t.admin.fees.tax(
            rate: formatHundredths(context, type.taxRate, trimZeros: true),
          ),
          if (type.shared) t.sharedLabel,
        ].join(' · '),
        onEdit: () => _edit(
          context,
          ref,
          _UnitTypeDialog(type: type, sortOrder: type.sortOrder),
        ),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: type.name,
            hint: t.deleteHint,
            delete: () =>
                ref.read(serverpodClientProvider).unitType.delete(type.id!),
          );
          if (deleted) ref.invalidate(unitTypesProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    _UnitTypeDialog dialog,
  ) async {
    if (await showAdminDialog(context, dialog)) {
      ref.invalidate(unitTypesProvider);
      // The rooms come with their unit type.
      ref.invalidate(roomsProvider);
    }
  }
}

class _UnitTypeDialog extends ConsumerStatefulWidget {
  const _UnitTypeDialog({this.type, required this.sortOrder});

  /// The unit type to edit, or null to create one.
  final UnitType? type;

  /// The sort order the form starts with.
  final int sortOrder;

  @override
  ConsumerState<_UnitTypeDialog> createState() => _UnitTypeDialogState();
}

class _UnitTypeDialogState extends ConsumerState<_UnitTypeDialog> {
  late final _name = TextEditingController(text: widget.type?.name);
  late final _sortOrder = TextEditingController(text: '${widget.sortOrder}');
  final _taxRate = TextEditingController();
  late bool _shared = widget.type?.shared ?? false;
  bool _filled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The rate is formatted for the current language, which is not
    // available in initState yet.
    if (_filled) return;
    _filled = true;
    _taxRate.text = formatHundredths(
      context,
      widget.type?.taxRate ?? 700,
      trimZeros: true,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _sortOrder.dispose();
    _taxRate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.unitTypes;

    return AdminFormDialog(
      title: widget.type == null ? t.add : t.edit,
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
                controller: _taxRate,
                label: t.taxRate,
                suffixText: '%',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: IntField(controller: _sortOrder, label: t.sortOrder),
            ),
          ],
        ),
        YaruSwitchListTile(
          title: Text(t.shared),
          subtitle: Text(t.sharedHint),
          value: _shared,
          onChanged: (value) => setState(() => _shared = value),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).unitType;
    final type = UnitType(
      id: widget.type?.id,
      name: _name.text.trim(),
      sortOrder: int.parse(_sortOrder.text.trim()),
      taxRate: parseHundredths(_taxRate.text)!,
      shared: _shared,
    );
    await (type.id == null ? endpoint.add(type) : endpoint.update(type));
  }
}
