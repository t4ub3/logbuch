import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';

void main() {
  withAdmin('Given a booking that is in the house today', (
    sessionBuilder,
    endpoints,
  ) {
    // The server takes today from the clock. A stay from yesterday until in
    // three days is in the house whatever the time zone of the test.
    final now = DateTime.now().toUtc();
    final yesterday = DateTime.utc(now.year, now.month, now.day - 1);
    final inThreeDays = DateTime.utc(now.year, now.month, now.day + 3);

    setUp(() async {
      final lead = await endpoints.contact.add(
        sessionBuilder,
        Contact(
          firstName: 'Marie',
          lastName: 'Weber',
          birthDate: DateTime.utc(1984, 5, 17),
        ),
      );
      final category = await endpoints.priceCategory.add(
        sessionBuilder,
        PriceCategory(name: 'Standard'),
      );
      final room = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '101', bedAmount: 4, priceCategoryId: category.id!),
      );
      await endpoints.room.add(
        sessionBuilder,
        Room(
          roomNumber: '102',
          bedAmount: 2,
          priceCategoryId: category.id!,
          active: false,
        ),
      );
      await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: 'Adult', minAge: 18),
      );
      final booking = await endpoints.booking.add(
        sessionBuilder,
        Booking(
          title: 'Spring days',
          arrival: yesterday,
          departure: inThreeDays,
          leadId: lead.id!,
          status: BookingStatus.confirmed,
        ),
      );
      await endpoints.booking.setRooms(sessionBuilder, booking.id!, [room.id!]);
      final group = await endpoints.guest.addGroup(
        sessionBuilder,
        GuestGroup(bookingId: booking.id!, name: 'Weber'),
      );
      await endpoints.guest.addGuest(
        sessionBuilder,
        Guest(groupId: group.id!, contactId: lead.id!),
      );
      // Cancelled bookings and bookings far away take no part.
      await endpoints.booking.add(
        sessionBuilder,
        Booking(
          title: 'Cancelled',
          arrival: yesterday,
          departure: inThreeDays,
          leadId: lead.id!,
          status: BookingStatus.cancelled,
        ),
      );
      await endpoints.booking.add(
        sessionBuilder,
        Booking(
          title: 'Next year',
          arrival: DateTime.utc(now.year + 1, now.month, 1),
          departure: DateTime.utc(now.year + 1, now.month, 3),
          leadId: lead.id!,
        ),
      );
    });

    test('when a viewer loads the dashboard '
        'then it shows the stay, the occupancy and who is to be fed', () async {
      final dashboard = await endpoints.dashboard.load(sessionBuilder.asViewer);

      expect(dashboard.arrivals, isEmpty);
      final departure = dashboard.departures.single;
      expect(departure.title, 'Spring days');
      expect(departure.date, inThreeDays);
      expect(departure.leadName, 'Marie Weber');
      expect(departure.guestCount, 1);
      expect(departure.roomCount, 1);

      expect(dashboard.roomsOccupied, 1);
      // The inactive room does not count.
      expect(dashboard.roomsTotal, 1);
      expect(dashboard.guestsTonight, 1);

      expect(dashboard.meals, hasLength(2));
      for (final day in dashboard.meals) {
        expect(day.bookings.single.title, 'Spring days');
        expect(day.guestCount, 1);
        expect(day.ageGroups.single.ageGroup.name, 'Adult');
        expect(day.ageGroups.single.count, 1);
      }
      expect(dashboard.expiringOptions, isEmpty);
      expect(dashboard.openBalances, isEmpty);
    });
  });
}
