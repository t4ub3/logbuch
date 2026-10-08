import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class FeeEndpoint extends AppEndpoint {
  /// The fees with the rooms they are a surcharge of.
  Future<List<Fee>> getAll(Session session) async {
    return Fee.db.find(
      session,
      orderBy: (t) => t.name,
      include: Fee.include(rooms: RoomFee.includeList()),
    );
  }

  /// Adds a fee as a surcharge of the rooms [roomIds], which is empty for a
  /// fee that every booking is charged.
  Future<Fee> add(Session session, Fee fee, List<int> roomIds) async {
    requireAdmin(session);
    final validated = _validated(fee, roomIds);
    return session.db.transaction((transaction) async {
      final added = await Fee.db.insertRow(
        session,
        validated,
        transaction: transaction,
      );
      await _setRooms(session, added.id!, roomIds, transaction);
      return added;
    });
  }

  Future<Fee> update(Session session, Fee fee, List<int> roomIds) async {
    requireAdmin(session);
    final validated = _validated(fee, roomIds);
    return session.db.transaction((transaction) async {
      final updated = await Fee.db.updateRow(
        session,
        validated,
        transaction: transaction,
      );
      await _setRooms(session, updated.id!, roomIds, transaction);
      return updated;
    });
  }

  /// Also deletes what the fee costs in the price lists.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    await Fee.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  Future<void> _setRooms(
    Session session,
    int feeId,
    List<int> roomIds,
    Transaction transaction,
  ) async {
    await RoomFee.db.deleteWhere(
      session,
      where: (t) => t.feeId.equals(feeId),
      transaction: transaction,
    );
    if (roomIds.isEmpty) return;
    await RoomFee.db.insert(
      session,
      [
        for (final roomId in roomIds.toSet())
          RoomFee(roomId: roomId, feeId: feeId),
      ],
      transaction: transaction,
    );
  }

  /// A fee is either charged to every booking or a surcharge of rooms, and
  /// a surcharge cannot be per booking.
  Fee _validated(Fee fee, List<int> roomIds) {
    final name = requireName(fee.name);
    requireTaxRate(fee.taxRate);
    if (roomIds.isNotEmpty &&
        (fee.autoApply || fee.unit == FeeUnit.perBooking)) {
      throw ValidationException(reason: ValidationError.invalidFeeScope);
    }
    return fee.copyWith(name: name);
  }
}
