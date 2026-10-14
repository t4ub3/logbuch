import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

/// The booking with [id], or null if there is none or it was deleted. A
/// deleted booking stays in the database, but is treated as if it was gone.
Future<Booking?> findBooking(
  Session session,
  int id, {
  BookingInclude? include,
  Transaction? transaction,
}) {
  return Booking.db.findFirstRow(
    session,
    where: (t) => t.id.equals(id) & notDeleted(t),
    include: include,
    transaction: transaction,
  );
}

/// Whether the booking of [t] was not deleted.
Expression notDeleted(BookingTable t) => t.deletedAt.equals(null);
