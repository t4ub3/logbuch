import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

/// The group of the booking for the guests who were added without a group,
/// which is made if the booking has none yet.
Future<GuestGroup> individualGroup(
  Session session,
  int bookingId,
  Transaction transaction,
) async {
  return await GuestGroup.db.findFirstRow(
        session,
        where: (t) => t.bookingId.equals(bookingId) & t.individual.equals(true),
        transaction: transaction,
      ) ??
      await GuestGroup.db.insertRow(
        session,
        GuestGroup(bookingId: bookingId, name: '', individual: true),
        transaction: transaction,
      );
}

/// Deletes the group if it is the group of the guests without one and has
/// no guests left.
Future<void> deleteIfEmptyIndividual(
  Session session,
  int groupId,
  Transaction transaction,
) async {
  await GuestGroup.db.deleteWhere(
    session,
    where: (t) =>
        t.id.equals(groupId) & t.individual.equals(true) & t.guests.none(),
    transaction: transaction,
  );
}

/// The guest of the booking who is [contactId], with their group, or null
/// if the contact is not a guest of the booking.
Future<Guest?> guestOfBooking(
  Session session,
  int bookingId,
  int contactId,
  Transaction transaction,
) {
  return Guest.db.findFirstRow(
    session,
    where: (t) =>
        t.contactId.equals(contactId) & t.group.bookingId.equals(bookingId),
    include: Guest.include(group: GuestGroup.include()),
    transaction: transaction,
  );
}
