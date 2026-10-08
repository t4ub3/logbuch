import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import '../../tool/demo_data.dart';
import 'roles.dart';

void main() {
  withAdmin('Given the demo data in an empty database', (
    sessionBuilder,
    endpoints,
  ) {
    final now = DateTime.now();
    final today = DateTime.utc(now.year, now.month, now.day);
    final notes = <String>[];

    Future<void> seed() => DemoData(
      sessionBuilder,
      endpoints,
      today: today,
      log: notes.add,
    ).seed();

    Future<Booking> booking(String title) async =>
        (await endpoints.booking.getAll(
          sessionBuilder,
        )).singleWhere((b) => b.title == title);

    setUp(() async {
      notes.clear();
      await seed();
    });

    test('then nothing had to be left out', () {
      expect(notes.where((note) => note.contains('!')), isEmpty);
    });

    test('then there are rooms and prices for every price category', () async {
      final rooms = await endpoints.room.getAll(sessionBuilder);
      final categories = await endpoints.priceCategory.getAll(sessionBuilder);
      final ageGroups = await endpoints.ageGroup.getAll(sessionBuilder);
      final plans = await endpoints.mealPlan.getAll(sessionBuilder);
      final seasons = await endpoints.season.getAll(sessionBuilder);

      expect(categories, hasLength(4));
      for (final category in categories) {
        expect(
          rooms.where((room) => room.priceCategoryId == category.id),
          isNotEmpty,
          reason: category.name,
        );
      }
      // Three seasons for each of three years, all of them priced in full.
      expect(seasons, hasLength(9));
      for (final season in seasons) {
        expect(
          await endpoints.roomRate.getBySeason(sessionBuilder, season.id!),
          hasLength(categories.length * ageGroups.length),
        );
        expect(
          await endpoints.mealRate.getBySeason(sessionBuilder, season.id!),
          hasLength(plans.length * ageGroups.length),
        );
      }
    });

    test('then there is a booking in every stage', () async {
      final bookings = await endpoints.booking.getAll(sessionBuilder);

      expect(
        {for (final booking in bookings) booking.status},
        BookingStatus.values.toSet(),
      );
      expect(
        {for (final booking in bookings) booking.billingMode},
        BillingMode.values.toSet(),
      );
      expect(await endpoints.household.getAll(sessionBuilder), hasLength(8));
      expect(
        await endpoints.organization.getAll(sessionBuilder),
        hasLength(8),
      );
    });

    test('then every booking has a category that comes with it', () async {
      final bookings = await endpoints.booking.getAll(sessionBuilder);
      final categories = await endpoints.bookingCategory.getAll(sessionBuilder);

      expect(categories, hasLength(5));
      for (final booking in bookings) {
        expect(booking.category, isNotNull, reason: booking.title);
      }
      expect(
        {for (final booking in bookings) booking.categoryId},
        {
          for (final category in categories) category.id,
        },
      );
    });

    test('then the families in the house can all be priced', () async {
      final retreat = await booking('Familienfreizeit St. Marien');
      final price = await endpoints.pricing.calculate(
        sessionBuilder,
        retreat.id!,
      );
      final groups = await endpoints.guest.getByBooking(
        sessionBuilder,
        retreat.id!,
      );
      final guests = [for (final group in groups) ...?group.guests];

      expect(price.problems, isEmpty);
      expect(guests, hasLength(28));
      expect(guests.where((guest) => guest.bookingRoomId == null), isEmpty);
      expect(guests.where((guest) => guest.needsCrib), hasLength(2));
      // Every family is billed on its own, and the lead for what belongs
      // to the booking as a whole.
      expect(
        await endpoints.billing.getFolios(sessionBuilder, retreat.id!),
        hasLength(groups.length + 1),
      );
    });

    test('then the class trip still has something to settle', () async {
      final trip = await booking('Klassenfahrt 8a Am Lindenpark');
      final price = await endpoints.pricing.calculate(sessionBuilder, trip.id!);

      // Three pupils have no room yet. For one of them the age is not
      // known either, which is what is reported first.
      expect(
        [for (final problem in price.problems) problem.reason]..sort(
          (a, b) => a.name.compareTo(b.name),
        ),
        [
          PricingProblemReason.ageUnknown,
          PricingProblemReason.roomMissing,
          PricingProblemReason.roomMissing,
        ],
      );
    });

    test('then invoices were written, paid in part and overpaid', () async {
      final invoiced = <Folio>[];
      for (final booking in await endpoints.booking.getAll(sessionBuilder)) {
        invoiced.addAll([
          for (final folio in await endpoints.billing.getFolios(
            sessionBuilder,
            booking.id!,
          ))
            if (folio.invoiceNumber != null) folio,
        ]);
      }
      final donated = [
        for (final folio in invoiced)
          for (final payment in folio.payments!) ...?payment.donations,
      ];

      expect(invoiced, hasLength(3));
      expect(donated, hasLength(1));
      // Two of the invoices are not paid in full.
      final dashboard = await endpoints.dashboard.load(sessionBuilder);
      expect(dashboard.openBalances, hasLength(2));
    });

    test('then the dashboard has something to show', () async {
      final dashboard = await endpoints.dashboard.load(sessionBuilder);

      expect(dashboard.arrivals, isNotEmpty);
      expect(dashboard.departures, isNotEmpty);
      expect(dashboard.roomsOccupied, greaterThan(0));
      expect(dashboard.guestsTonight, greaterThan(0));
      expect(dashboard.expiringOptions, hasLength(2));
    });

    test('then last year has receipts and this year waits for them', () async {
      final lastYear = await endpoints.donation.getReceipts(
        sessionBuilder,
        today.year - 1,
      );
      final waiting = await endpoints.donation.previewReceipts(
        sessionBuilder,
        today.year,
      );

      // Four donors, one of whom gave twice.
      expect(lastYear, hasLength(4));
      expect(waiting, isNotEmpty);
      expect(waiting.where((preview) => !preview.addressComplete), isNotEmpty);
    });

    test('when it is added again then nothing is added twice', () async {
      Future<List<int>> counts() async => [
        (await endpoints.contact.getAll(sessionBuilder)).length,
        (await endpoints.room.getAll(sessionBuilder)).length,
        (await endpoints.booking.getAll(sessionBuilder)).length,
        (await endpoints.household.getAll(sessionBuilder)).length,
        (await endpoints.organization.getAll(sessionBuilder)).length,
        (await endpoints.season.getAll(sessionBuilder)).length,
        (await endpoints.fee.getAll(sessionBuilder)).length,
        (await endpoints.donation.getByYear(sessionBuilder, today.year)).length,
      ];
      final before = await counts();

      await seed();

      expect(await counts(), before);
    });

    test(
      'when it is added again then a booking without a category gets one',
      () async {
        final trip = (await endpoints.booking.getAll(
          sessionBuilder,
        )).firstWhere((b) => b.title.contains('Klassenfahrt'));
        final categoryId = trip.categoryId;
        await endpoints.booking.update(
          sessionBuilder,
          trip.copyWith(categoryId: null),
        );
        expect((await booking(trip.title)).categoryId, isNull);

        await seed();

        expect((await booking(trip.title)).categoryId, categoryId);
      },
    );
  });
}
