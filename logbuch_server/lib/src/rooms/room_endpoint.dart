import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class RoomEndpoint extends Endpoint {
  Future<List<Room>> getAll(Session session) async {
    return Room.db.find(session);
  }

  Future<Room?> getById(Session session, int id) async {
    return Room.db.findById(session, id);
  }

  Future<Room> add(Session session, Room room) async {
    return await Room.db.insertRow(session, room);
  }
}
