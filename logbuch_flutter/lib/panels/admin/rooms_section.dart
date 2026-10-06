import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/price_categories_provider.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';
import 'package:yaru/yaru.dart';

class RoomsSection extends ConsumerWidget {
  const RoomsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return AdminListSection<Room>(
      value: ref.watch(roomsProvider),
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
          ?room.priceCategory?.name,
          if (room.cribPossible) t.admin.rooms.crib,
          ?room.building,
          ?room.floor,
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
  late final _building = TextEditingController(text: _room?.building);
  late final _floor = TextEditingController(text: _room?.floor);
  late final _notes = TextEditingController(text: _room?.notes);
  late int? _priceCategoryId = _room?.priceCategoryId;
  late bool _cribPossible = _room?.cribPossible ?? false;
  late bool _active = _room?.active ?? true;

  @override
  void dispose() {
    _number.dispose();
    _beds.dispose();
    _building.dispose();
    _floor.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.rooms;
    final categories = ref.watch(priceCategoriesProvider);

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
        switch (categories) {
          AsyncData(value: final categories) => DropdownButtonFormField<int>(
            isExpanded: true,
            initialValue: _priceCategoryId,
            decoration: InputDecoration(
              labelText: t.priceCategory,
              helperText: categories.isEmpty ? t.noPriceCategories : null,
            ),
            items: [
              for (final category in categories)
                DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                ),
            ],
            onChanged: (id) => setState(() => _priceCategoryId = id),
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
              child: TextFormField(
                controller: _building,
                decoration: InputDecoration(labelText: t.building),
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
      building: nullIfBlank(_building.text),
      floor: nullIfBlank(_floor.text),
      priceCategoryId: _priceCategoryId!,
      cribPossible: _cribPossible,
      active: _active,
      notes: nullIfBlank(_notes.text),
    );
    await (room.id == null ? endpoint.add(room) : endpoint.update(room));
  }
}
