import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class BuildingEndpoint extends AppEndpoint {
  Future<List<Building>> getAll(Session session) async {
    return Building.db.find(
      session,
      orderByList: (t) => [t.sortOrder.asc(), t.name.asc()],
    );
  }

  Future<Building> add(Session session, Building building) async {
    requireAdmin(session);
    return await Building.db.insertRow(session, _validated(building));
  }

  Future<Building> update(Session session, Building building) async {
    requireAdmin(session);
    return await Building.db.updateRow(session, _validated(building));
  }

  /// A building that still has rooms cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final rooms = await Room.db.count(
      session,
      where: (t) => t.buildingId.equals(id),
    );
    if (rooms > 0) throw ValidationException(reason: ValidationError.inUse);
    await Building.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  Building _validated(Building building) =>
      building.copyWith(name: requireName(building.name));
}
