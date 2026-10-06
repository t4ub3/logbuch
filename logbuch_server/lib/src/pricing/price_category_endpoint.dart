import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class PriceCategoryEndpoint extends AppEndpoint {
  Future<List<PriceCategory>> getAll(Session session) async {
    return PriceCategory.db.find(
      session,
      orderByList: (t) => [t.sortOrder.asc(), t.name.asc()],
    );
  }

  Future<PriceCategory> add(Session session, PriceCategory category) async {
    requireAdmin(session);
    return await PriceCategory.db.insertRow(session, _validated(category));
  }

  Future<PriceCategory> update(Session session, PriceCategory category) async {
    requireAdmin(session);
    return await PriceCategory.db.updateRow(session, _validated(category));
  }

  /// Also deletes the room rates of the category. A category that still has
  /// rooms cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final rooms = await Room.db.count(
      session,
      where: (t) => t.priceCategoryId.equals(id),
    );
    if (rooms > 0) throw ValidationException(reason: ValidationError.inUse);
    await PriceCategory.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  PriceCategory _validated(PriceCategory category) =>
      category.copyWith(name: requireName(category.name));
}
