import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class RoomEndpoint extends AppEndpoint {
  Future<List<Room>> getAll(Session session) async {
    return Room.db.find(
      session,
      orderBy: (t) => t.roomNumber,
      include: Room.include(priceCategory: PriceCategory.include()),
    );
  }

  Future<Room?> getById(Session session, int id) async {
    return Room.db.findById(
      session,
      id,
      include: Room.include(priceCategory: PriceCategory.include()),
    );
  }

  Future<Room> add(Session session, Room room) async {
    requireAdmin(session);
    return await Room.db.insertRow(session, _validated(room));
  }

  Future<Room> update(Session session, Room room) async {
    requireAdmin(session);
    return await Room.db.updateRow(session, _validated(room));
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

  Room _validated(Room room) {
    final roomNumber = requireName(room.roomNumber);
    if (room.bedAmount < 0) {
      throw ValidationException(reason: ValidationError.invalidBedAmount);
    }
    return room.copyWith(roomNumber: roomNumber);
  }
}
