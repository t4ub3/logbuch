import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class BookingEndpoint extends Endpoint {
  Future<List<Booking>> getAll(Session session) async {
    return Booking.db.find(session);
  }

  Future<Booking?> getById(Session session, int id) async {
    return Booking.db.findById(session, id);
  }

  Future<Booking> add(Session session, Booking booking) async {
    return await Booking.db.insertRow(session, booking);
  }

  Future<Booking> update(Session session, Booking booking) async {
    return await Booking.db.updateRow(session, booking);
  }
}
