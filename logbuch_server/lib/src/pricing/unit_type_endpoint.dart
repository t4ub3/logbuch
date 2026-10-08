import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class UnitTypeEndpoint extends AppEndpoint {
  Future<List<UnitType>> getAll(Session session) async {
    return UnitType.db.find(
      session,
      orderByList: (t) => [t.sortOrder.asc(), t.name.asc()],
    );
  }

  Future<UnitType> add(Session session, UnitType type) async {
    requireAdmin(session);
    return await UnitType.db.insertRow(session, _validated(type));
  }

  Future<UnitType> update(Session session, UnitType type) async {
    requireAdmin(session);
    return await UnitType.db.updateRow(session, _validated(type));
  }

  /// Also deletes the prices of the type. A type that still has rooms
  /// cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final rooms = await Room.db.count(
      session,
      where: (t) => t.unitTypeId.equals(id),
    );
    if (rooms > 0) throw ValidationException(reason: ValidationError.inUse);
    await UnitType.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  UnitType _validated(UnitType type) {
    requireTaxRate(type.taxRate);
    return type.copyWith(name: requireName(type.name));
  }
}
