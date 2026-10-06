import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/today.dart';
import 'package:logbuch_server/src/dashboard/dashboard.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class DashboardEndpoint extends AppEndpoint {
  /// What the start screen shows about today and the days ahead, see
  /// [buildDashboard].
  Future<Dashboard> load(Session session) async {
    final today = await todayInGermany(session);
    final lastDay = today.add(const Duration(days: upcomingDays));
    final warnUntil = today.add(const Duration(days: optionWarningDays));

    // The bookings that touch the days ahead, and the options that are
    // about to expire whenever they take place.
    final bookings = await Booking.db.find(
      session,
      where: (t) =>
          t.status.notEquals(BookingStatus.cancelled) &
          (((t.departure >= today) & (t.arrival <= lastDay)) |
              (t.status.equals(BookingStatus.option) &
                  (t.optionExpiresAt <= warnUntil))),
      include: Booking.include(
        lead: Contact.include(),
        mealPlan: MealPlan.include(),
        rooms: BookingRoom.includeList(),
      ),
    );
    final bookingIds = {for (final booking in bookings) booking.id!};
    final groups = bookingIds.isEmpty
        ? <GuestGroup>[]
        : await GuestGroup.db.find(
            session,
            where: (t) => t.bookingId.inSet(bookingIds),
            include: GuestGroup.include(
              guests: Guest.includeList(
                include: Guest.include(contact: Contact.include()),
              ),
            ),
          );
    final guests = <int, List<Guest>>{};
    for (final group in groups) {
      guests.putIfAbsent(group.bookingId, () => []).addAll(group.guests ?? []);
    }

    return buildDashboard(
      today: today,
      bookings: bookings,
      guests: guests,
      ageGroups: await AgeGroup.db.find(session),
      activeRooms: await Room.db.count(
        session,
        where: (t) => t.active.equals(true),
      ),
      invoicedFolios: await Folio.db.find(
        session,
        where: (t) => t.status.equals(FolioStatus.invoiced),
        include: Folio.include(
          payer: Contact.include(),
          booking: Booking.include(),
          charges: Charge.includeList(),
          payments: Payment.includeList(
            include: Payment.include(donations: Donation.includeList()),
          ),
        ),
      ),
    );
  }
}
