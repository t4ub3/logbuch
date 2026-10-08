import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/buildings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';

/// The houses, or groups of houses, that the rooms are in.
class BuildingsSection extends ConsumerWidget {
  const BuildingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.buildings;
    final buildings = ref.watch(buildingsProvider);
    final rooms = ref.watch(roomsProvider).value ?? [];

    return AdminListSection<Building>(
      value: buildings,
      onRetry: () => ref.refresh(buildingsProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      // New buildings go to the end of the list.
      onAdd: () => _edit(
        context,
        ref,
        _BuildingDialog(
          sortOrder: (buildings.value ?? []).fold(
            0,
            (next, b) => b.sortOrder >= next ? b.sortOrder + 1 : next,
          ),
        ),
      ),
      itemBuilder: (context, building) => AdminTile(
        icon: Icons.apartment,
        title: building.name,
        subtitle: context.t.dashboard.roomCount(
          n: rooms.where((room) => room.buildingId == building.id).length,
        ),
        onEdit: () => _edit(
          context,
          ref,
          _BuildingDialog(building: building, sortOrder: building.sortOrder),
        ),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: building.name,
            delete: () =>
                ref.read(serverpodClientProvider).building.delete(building.id!),
          );
          if (deleted) ref.invalidate(buildingsProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    _BuildingDialog dialog,
  ) async {
    if (await showAdminDialog(context, dialog)) {
      ref.invalidate(buildingsProvider);
      // The rooms come with their building.
      ref.invalidate(roomsProvider);
    }
  }
}

class _BuildingDialog extends ConsumerStatefulWidget {
  const _BuildingDialog({this.building, required this.sortOrder});

  /// The building to edit, or null to create one.
  final Building? building;

  /// The sort order the form starts with.
  final int sortOrder;

  @override
  ConsumerState<_BuildingDialog> createState() => _BuildingDialogState();
}

class _BuildingDialogState extends ConsumerState<_BuildingDialog> {
  late final _name = TextEditingController(text: widget.building?.name);
  late final _sortOrder = TextEditingController(text: '${widget.sortOrder}');

  @override
  void dispose() {
    _name.dispose();
    _sortOrder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.buildings;

    return AdminFormDialog(
      title: widget.building == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        IntField(controller: _sortOrder, label: t.sortOrder),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).building;
    final building = Building(
      id: widget.building?.id,
      name: _name.text.trim(),
      sortOrder: int.parse(_sortOrder.text.trim()),
    );
    await (building.id == null
        ? endpoint.add(building)
        : endpoint.update(building));
  }
}
