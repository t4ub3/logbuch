import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/buildings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/fees_provider.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';
import 'package:logbuch_flutter/providers/unit_types_provider.dart';
import 'package:yaru/yaru.dart';

/// Orders rooms by their building and then by their number. Rooms without
/// a building come last.
int compareByBuilding(Room a, Room b) {
  final aBuilding = a.building;
  final bBuilding = b.building;
  if (aBuilding?.id != bBuilding?.id) {
    if (aBuilding == null) return 1;
    if (bBuilding == null) return -1;
    final byOrder = aBuilding.sortOrder.compareTo(bBuilding.sortOrder);
    return byOrder != 0 ? byOrder : aBuilding.name.compareTo(bBuilding.name);
  }
  return a.roomNumber.compareTo(b.roomNumber);
}

extension FeeScope on Fee {
  /// Whether the fee can be the surcharge of a room: it is not charged to
  /// every booking anyway, and not per booking.
  bool get canBeSurcharge => !autoApply && unit != FeeUnit.perBooking;
}

class RoomsSection extends ConsumerWidget {
  const RoomsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return AdminListSection<Room>(
      value: ref
          .watch(roomsProvider)
          .whenData((rooms) => [...rooms]..sort(compareByBuilding)),
      onRetry: () => ref.refresh(roomsProvider.future),
      emptyText: t.rooms.empty,
      addLabel: t.admin.rooms.add,
      onAdd: () => _edit(context, ref),
      itemBuilder: (context, room) => AdminTile(
        icon: Icons.bed,
        title: t.rooms.room(number: room.roomNumber),
        subtitle: [
          if (!room.active) t.admin.rooms.inactive,
          t.rooms.beds(n: room.bedAmount),
          ?room.unitType?.name,
          if (room.cribPossible) t.admin.rooms.crib,
          ?room.building?.name,
          ?room.floor,
          for (final surcharge in room.fees ?? <RoomFee>[])
            ?surcharge.fee?.name,
        ].join(' · '),
        onEdit: () => _edit(context, ref, room),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: t.rooms.room(number: room.roomNumber),
            delete: () =>
                ref.read(serverpodClientProvider).room.delete(room.id!),
          );
          if (deleted) ref.invalidate(roomsProvider);
        },
      ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, [Room? room]) async {
    if (await showAdminDialog(context, _RoomDialog(room: room))) {
      ref.invalidate(roomsProvider);
      // The fees come with the rooms they are a surcharge of.
      ref.invalidate(feesProvider);
    }
  }
}

class _RoomDialog extends ConsumerStatefulWidget {
  const _RoomDialog({this.room});

  /// The room to edit, or null to create one.
  final Room? room;

  @override
  ConsumerState<_RoomDialog> createState() => _RoomDialogState();
}

class _RoomDialogState extends ConsumerState<_RoomDialog> {
  Room? get _room => widget.room;

  late final _number = TextEditingController(text: _room?.roomNumber);
  late final _beds = TextEditingController(text: _room?.bedAmount.toString());
  late final _floor = TextEditingController(text: _room?.floor);
  late final _notes = TextEditingController(text: _room?.notes);
  late int? _unitTypeId = _room?.unitTypeId;
  late int? _buildingId = _room?.buildingId;
  late Set<int> _feeIds = {
    for (final surcharge in _room?.fees ?? <RoomFee>[]) surcharge.feeId,
  };
  late bool _cribPossible = _room?.cribPossible ?? false;
  late bool _active = _room?.active ?? true;

  @override
  void dispose() {
    _number.dispose();
    _beds.dispose();
    _floor.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.rooms;
    final types = ref.watch(unitTypesProvider);
    final buildings = ref.watch(buildingsProvider);
    final surcharges = [
      for (final fee in ref.watch(feesProvider).value ?? <Fee>[])
        if (fee.canBeSurcharge) fee,
    ];

    return AdminFormDialog(
      title: _room == null ? t.add : t.edit,
      onSave: _save,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RequiredTextField(
                controller: _number,
                label: t.number,
                autofocus: true,
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 120,
              child: IntField(controller: _beds, label: t.beds),
            ),
          ],
        ),
        switch (types) {
          AsyncData(value: final types) => DropdownButtonFormField<int>(
            isExpanded: true,
            initialValue: _unitTypeId,
            decoration: InputDecoration(
              labelText: t.unitType,
              helperText: types.isEmpty ? t.noUnitTypes : null,
            ),
            items: [
              for (final type in types)
                DropdownMenuItem(value: type.id, child: Text(type.name)),
            ],
            onChanged: (id) => setState(() => _unitTypeId = id),
            validator: (id) => id == null ? context.t.common.required : null,
          ),
          AsyncError(:final error) => Text(
            context.t.common.loadFailed(error: error),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // "No building" is the null entry.
              child: DropdownButtonFormField<int?>(
                isExpanded: true,
                initialValue: _buildingId,
                decoration: InputDecoration(labelText: t.building),
                items: [
                  DropdownMenuItem(value: null, child: Text(t.noBuilding)),
                  for (final building in buildings.value ?? <Building>[])
                    DropdownMenuItem(
                      value: building.id,
                      child: Text(building.name),
                    ),
                ],
                onChanged: (id) => setState(() => _buildingId = id),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _floor,
                decoration: InputDecoration(labelText: t.floor),
              ),
            ),
          ],
        ),
        if (surcharges.isNotEmpty)
          InputDecorator(
            decoration: InputDecoration(labelText: t.surcharges),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final fee in surcharges)
                  FilterChip(
                    label: Text(fee.name),
                    selected: _feeIds.contains(fee.id),
                    onSelected: (selected) => setState(() {
                      _feeIds = {
                        for (final id in _feeIds)
                          if (id != fee.id) id,
                        if (selected) fee.id!,
                      };
                    }),
                  ),
              ],
            ),
          ),
        YaruSwitchListTile(
          title: Text(t.cribPossible),
          value: _cribPossible,
          onChanged: (value) => setState(() => _cribPossible = value),
        ),
        YaruSwitchListTile(
          title: Text(t.active),
          subtitle: Text(t.activeHint),
          value: _active,
          onChanged: (value) => setState(() => _active = value),
        ),
        TextFormField(
          controller: _notes,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: t.notes),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).room;
    final room = Room(
      id: _room?.id,
      roomNumber: _number.text.trim(),
      bedAmount: int.parse(_beds.text.trim()),
      buildingId: _buildingId,
      floor: nullIfBlank(_floor.text),
      unitTypeId: _unitTypeId!,
      cribPossible: _cribPossible,
      active: _active,
      notes: nullIfBlank(_notes.text),
    );
    final feeIds = _feeIds.toList();
    await (room.id == null
        ? endpoint.add(room, feeIds)
        : endpoint.update(room, feeIds));
  }
}
