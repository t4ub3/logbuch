import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/admin/rooms_section.dart';
import 'package:logbuch_flutter/providers/age_groups_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/fees_provider.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';
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

/// The fees that every booking is charged and the surcharges of rooms.
/// What they cost is entered in the price lists.
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
      itemBuilder: (context, fee) {
        final rooms = fee.rooms?.length ?? 0;
        return AdminTile(
          icon: Icons.receipt_long,
          title: fee.name,
          subtitle: [
            fee.unit.label(context),
            ?ageGroups.where((g) => g.id == fee.ageGroupId).firstOrNull?.name,
            if (fee.taxRate > 0)
              t.tax(
                rate: formatHundredths(context, fee.taxRate, trimZeros: true),
              ),
            if (fee.autoApply)
              t.auto
            else if (rooms > 0)
              context.t.dashboard.roomCount(n: rooms)
            else
              t.unused,
          ].join(' · '),
          onEdit: () => _edit(context, ref, fee),
          onDelete: () async {
            final deleted = await confirmAndDelete(
              context,
              name: fee.name,
              delete: () =>
                  ref.read(serverpodClientProvider).fee.delete(fee.id!),
            );
            if (deleted) {
              ref.invalidate(feesProvider);
              ref.invalidate(roomsProvider);
            }
          },
        );
      },
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, [Fee? fee]) async {
    if (await showAdminDialog(context, _FeeDialog(fee: fee))) {
      ref.invalidate(feesProvider);
      // The rooms come with their surcharges.
      ref.invalidate(roomsProvider);
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
  final _taxRate = TextEditingController();
  late FeeUnit _unit = _fee?.unit ?? FeeUnit.perPersonNight;
  late int? _ageGroupId = _fee?.ageGroupId;
  late bool _autoApply = _fee?.autoApply ?? false;
  late Set<int> _roomIds = {
    for (final room in _fee?.rooms ?? <RoomFee>[]) room.roomId,
  };
  bool _filled = false;

  /// Whether the fee, as it is entered, can be the surcharge of rooms.
  bool get _forRooms => !_autoApply && _unit != FeeUnit.perBooking;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The rate is formatted for the current language, which is not
    // available in initState yet.
    if (_filled) return;
    _filled = true;
    _taxRate.text = formatHundredths(
      context,
      _fee?.taxRate ?? 700,
      trimZeros: true,
    );
  }

  @override
  void dispose() {
    _name.dispose();
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
              flex: 2,
              child: DropdownButtonFormField<FeeUnit>(
                isExpanded: true,
                initialValue: _unit,
                decoration: InputDecoration(
                  labelText: t.unit,
                  helperText: t.priceHint,
                  helperMaxLines: 2,
                ),
                items: [
                  for (final unit in FeeUnit.values)
                    DropdownMenuItem(
                      value: unit,
                      child: Text(unit.label(context)),
                    ),
                ],
                onChanged: (unit) => setState(() => _unit = unit ?? _unit),
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
        if (_forRooms)
          _RoomPicker(
            selected: _roomIds,
            onChanged: (roomIds) => setState(() => _roomIds = roomIds),
          ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).fee;
    final fee = Fee(
      id: _fee?.id,
      name: _name.text.trim(),
      unit: _unit,
      ageGroupId: _ageGroupId,
      taxRate: parseHundredths(_taxRate.text)!,
      autoApply: _autoApply,
    );
    final roomIds = _forRooms ? _roomIds.toList() : <int>[];
    await (fee.id == null
        ? endpoint.add(fee, roomIds)
        : endpoint.update(fee, roomIds));
  }
}

/// The rooms, building by building, each as a chip that is selected while
/// the fee is its surcharge. A building is selected or cleared as a whole
/// by its name.
class _RoomPicker extends ConsumerWidget {
  const _RoomPicker({required this.selected, required this.onChanged});

  final Set<int> selected;
  final ValueChanged<Set<int>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin;
    final rooms = [...ref.watch(roomsProvider).value ?? <Room>[]]
      ..sort(compareByBuilding);
    // Rooms follow each other building by building.
    final byBuilding = <int?, List<Room>>{};
    for (final room in rooms) {
      byBuilding.putIfAbsent(room.buildingId, () => []).add(room);
    }

    void set(Iterable<Room> rooms, bool select) => onChanged({
      for (final id in selected)
        if (rooms.every((room) => room.id != id)) id,
      if (select)
        for (final room in rooms) room.id!,
    });

    return InputDecorator(
      decoration: InputDecoration(labelText: t.fees.rooms),
      child: rooms.isEmpty
          ? Text(t.fees.noRooms)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                for (final rooms in byBuilding.values) ...[
                  ActionChip(
                    avatar: const Icon(Icons.apartment, size: 18),
                    label: Text(
                      rooms.first.building?.name ?? t.rooms.noBuilding,
                    ),
                    onPressed: () => set(
                      rooms,
                      !rooms.every((room) => selected.contains(room.id)),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final room in rooms)
                        FilterChip(
                          label: Text(room.roomNumber),
                          selected: selected.contains(room.id),
                          onSelected: (select) => set([room], select),
                        ),
                    ],
                  ),
                ],
              ],
            ),
    );
  }
}
