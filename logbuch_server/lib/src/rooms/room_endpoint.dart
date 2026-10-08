import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class RoomEndpoint extends AppEndpoint {
  Future<List<Room>> getAll(Session session) async {
    return Room.db.find(
      session,
      orderBy: (t) => t.roomNumber,
      include: roomDetails(),
    );
  }

  Future<Room?> getById(Session session, int id) async {
    return Room.db.findById(session, id, include: roomDetails());
  }

  /// Adds a room with the surcharges [feeIds].
  Future<Room> add(Session session, Room room, List<int> feeIds) async {
    requireAdmin(session);
    final validated = _validated(room);
    return session.db.transaction((transaction) async {
      final added = await Room.db.insertRow(
        session,
        validated,
        transaction: transaction,
      );
      await _setFees(session, added.id!, feeIds, transaction);
      return added;
    });
  }

  Future<Room> update(Session session, Room room, List<int> feeIds) async {
    requireAdmin(session);
    final validated = _validated(room);
    return session.db.transaction((transaction) async {
      final updated = await Room.db.updateRow(
        session,
        validated,
        transaction: transaction,
      );
      await _setFees(session, updated.id!, feeIds, transaction);
      return updated;
    });
  }

  /// A room that a booking holds or held cannot be deleted, only set
  /// inactive.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final bookings = await BookingRoom.db.count(
      session,
      where: (t) => t.roomId.equals(id),
    );
    if (bookings > 0) throw ValidationException(reason: ValidationError.inUse);
    await Room.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// Only a fee that is not charged to every booking anyway can be the
  /// surcharge of a room.
  Future<void> _setFees(
    Session session,
    int roomId,
    List<int> feeIds,
    Transaction transaction,
  ) async {
    await RoomFee.db.deleteWhere(
      session,
      where: (t) => t.roomId.equals(roomId),
      transaction: transaction,
    );
    final wanted = feeIds.toSet();
    if (wanted.isEmpty) return;
    final fees = await Fee.db.find(
      session,
      where: (t) => t.id.inSet(wanted),
      transaction: transaction,
    );
    if (fees.length != wanted.length) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    if (fees.any((fee) => fee.autoApply || fee.unit == FeeUnit.perBooking)) {
      throw ValidationException(reason: ValidationError.invalidFeeScope);
    }
    await RoomFee.db.insert(
      session,
      [for (final feeId in wanted) RoomFee(roomId: roomId, feeId: feeId)],
      transaction: transaction,
    );
  }

  Room _validated(Room room) {
    final roomNumber = requireName(room.roomNumber);
    if (room.bedAmount < 0) {
      throw ValidationException(reason: ValidationError.invalidBedAmount);
    }
    return room.copyWith(roomNumber: roomNumber);
  }
}

/// A room with its building, its unit type and its surcharges.
RoomInclude roomDetails() => Room.include(
  building: Building.include(),
  unitType: UnitType.include(),
  fees: RoomFee.includeList(include: RoomFee.include(fee: Fee.include())),
);
