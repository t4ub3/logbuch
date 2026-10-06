import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'test_tools/serverpod_test_tools.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a contact and two rooms', (sessionBuilder, endpoints) {
    late Contact lead;
    late Room room101;
    late Room room102;

    Booking booking(
      String title, {
      DateTime? arrival,
      DateTime? departure,
      BookingStatus? status,
    }) => Booking(
      title: title,
      arrival: arrival,
      departure: departure,
      leadId: lead.id!,
      status: status,
    );

    /// A booking from the given days of October 2026.
    Future<Booking> addOctober(String title, int arrival, int departure) =>
        endpoints.booking.add(
          sessionBuilder,
          booking(
            title,
            arrival: DateTime.utc(2026, 10, arrival),
            departure: DateTime.utc(2026, 10, departure),
          ),
        );

    setUp(() async {
      lead = await endpoints.contact.add(
        sessionBuilder,
        Contact(firstName: 'Ada', lastName: 'Lovelace'),
      );
      final category = await endpoints.priceCategory.add(
        sessionBuilder,
        PriceCategory(name: 'Standard'),
      );
      room101 = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '101', bedAmount: 4, priceCategoryId: category.id!),
      );
      room102 = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '102', bedAmount: 2, priceCategoryId: category.id!),
      );
    });

    group('when adding a booking', () {
      test('then it is an inquiry billed to a single payer', () async {
        final added = await endpoints.booking.add(
          sessionBuilder,
          booking('Summer camp'),
        );

        expect(added.status, BookingStatus.inquiry);
        expect(added.billingMode, BillingMode.single);
      });

      test('then it comes with its lead', () async {
        final added = await addOctober('Summer camp', 12, 16);

        final fetched = await endpoints.booking.getById(
          sessionBuilder,
          added.id!,
        );
        expect(fetched?.lead?.lastName, 'Lovelace');
        expect(fetched?.rooms, isEmpty);
      });

      test('with only an arrival then it is rejected', () async {
        await expectLater(
          endpoints.booking.add(
            sessionBuilder,
            booking('Open end', arrival: DateTime.utc(2026, 10, 12)),
          ),
          throwsValidation(ValidationError.invalidDateRange),
        );
      });

      test('that departs before it arrives then it is rejected', () async {
        await expectLater(
          addOctober('Backwards', 16, 12),
          throwsValidation(ValidationError.invalidDateRange),
        );
      });

      test('with a time of day then it is rejected', () async {
        await expectLater(
          endpoints.booking.add(
            sessionBuilder,
            booking(
              'Local midnight',
              arrival: DateTime.utc(2026, 10, 11, 22),
              departure: DateTime.utc(2026, 10, 16),
            ),
          ),
          throwsValidation(ValidationError.invalidDate),
        );
      });
    });

    test('when updating a booking then the changes are stored', () async {
      final added = await addOctober('Draft', 12, 16);

      await endpoints.booking.update(
        sessionBuilder,
        added.copyWith(
          title: 'Final',
          arrival: null,
          departure: null,
          status: BookingStatus.option,
          expectedGuestCount: 24,
        ),
      );

      final fetched = await endpoints.booking.getById(
        sessionBuilder,
        added.id!,
      );
      expect(fetched?.title, 'Final');
      expect(fetched?.arrival, isNull);
      expect(fetched?.status, BookingStatus.option);
      expect(fetched?.expectedGuestCount, 24);
    });

    group('when a booking holds room 101 from the 12th to the 16th', () {
      late Booking camp;

      Future<List<String>> freeRooms(
        int arrival,
        int departure, {
        int? exceptBookingId,
      }) async {
        final rooms = await endpoints.booking.availableRooms(
          sessionBuilder,
          DateTime.utc(2026, 10, arrival),
          DateTime.utc(2026, 10, departure),
          exceptBookingId: exceptBookingId,
        );
        return [for (final room in rooms) room.roomNumber];
      }

      setUp(() async {
        camp = await addOctober('Camp', 12, 16);
        camp = await endpoints.booking.setRooms(sessionBuilder, camp.id!, [
          room101.id!,
        ]);
      });

      test('then the booking comes with the room', () async {
        expect(camp.rooms?.single.room?.roomNumber, '101');
      });

      test('then the room is taken for nights it overlaps', () async {
        expect(await freeRooms(15, 17), ['102']);
        expect(await freeRooms(10, 13), ['102']);
        expect(await freeRooms(13, 14), ['102']);
      });

      test('then the room is free from the day of departure', () async {
        expect(await freeRooms(16, 18), ['101', '102']);
      });

      test('then the room is free until the day of arrival', () async {
        expect(await freeRooms(10, 12), ['101', '102']);
      });

      test('then the room is free for the booking itself', () async {
        expect(await freeRooms(12, 16, exceptBookingId: camp.id), [
          '101',
          '102',
        ]);
      });

      test('then an inactive room is not offered', () async {
        await endpoints.room.update(
          sessionBuilder,
          room102.copyWith(active: false),
        );

        expect(await freeRooms(20, 22), ['101']);
      });

      test('then an overlapping booking cannot take the room', () async {
        final choir = await addOctober('Choir', 15, 18);

        await expectLater(
          endpoints.booking.setRooms(sessionBuilder, choir.id!, [
            room101.id!,
            room102.id!,
          ]),
          throwsValidation(ValidationError.roomUnavailable, detail: '101'),
        );
      });

      test(
        'then a booking arriving on the departure day can take the room',
        () async {
          final choir = await addOctober('Choir', 16, 18);

          final updated = await endpoints.booking.setRooms(
            sessionBuilder,
            choir.id!,
            [room101.id!],
          );

          expect(updated.rooms, hasLength(1));
        },
      );

      test(
        'then a booking cannot move onto its nights with the room',
        () async {
          var choir = await addOctober('Choir', 16, 18);
          choir = await endpoints.booking.setRooms(sessionBuilder, choir.id!, [
            room101.id!,
          ]);

          await expectLater(
            endpoints.booking.update(
              sessionBuilder,
              choir.copyWith(arrival: DateTime.utc(2026, 10, 15)),
            ),
            throwsValidation(ValidationError.roomUnavailable, detail: '101'),
          );

          final fetched = await endpoints.booking.getById(
            sessionBuilder,
            choir.id!,
          );
          expect(fetched?.arrival, DateTime.utc(2026, 10, 16));
        },
      );

      test('then cancelling it frees the room, and it cannot come back '
          'once the room is taken', () async {
        camp = await endpoints.booking.update(
          sessionBuilder,
          camp.copyWith(status: BookingStatus.cancelled),
        );
        final choir = await addOctober('Choir', 13, 15);
        await endpoints.booking.setRooms(sessionBuilder, choir.id!, [
          room101.id!,
        ]);

        await expectLater(
          endpoints.booking.update(
            sessionBuilder,
            camp.copyWith(status: BookingStatus.confirmed),
          ),
          throwsValidation(ValidationError.roomUnavailable),
        );
      });

      test('then it cannot lose its dates', () async {
        await expectLater(
          endpoints.booking.update(
            sessionBuilder,
            camp.copyWith(arrival: null, departure: null),
          ),
          throwsValidation(ValidationError.datesRequired),
        );
      });

      test('then changing its rooms keeps the room that stays', () async {
        final updated = await endpoints.booking.setRooms(
          sessionBuilder,
          camp.id!,
          [room101.id!, room102.id!],
        );

        expect(updated.rooms, hasLength(2));
        expect(
          updated.rooms!.firstWhere((r) => r.roomId == room101.id).id,
          camp.rooms!.single.id,
        );

        final emptied = await endpoints.booking.setRooms(
          sessionBuilder,
          camp.id!,
          [],
        );
        expect(emptied.rooms, isEmpty);
      });

      test('then the room and the lead cannot be deleted', () async {
        await expectLater(
          endpoints.room.delete(sessionBuilder, room101.id!),
          throwsValidation(ValidationError.inUse),
        );
        await expectLater(
          endpoints.contact.delete(sessionBuilder, lead.id!),
          throwsValidation(ValidationError.inUse),
        );
      });
    });

    test('when giving rooms to a booking without dates '
        'then it is rejected', () async {
      final undated = await endpoints.booking.add(
        sessionBuilder,
        booking('Someday'),
      );

      await expectLater(
        endpoints.booking.setRooms(sessionBuilder, undated.id!, [room101.id!]),
        throwsValidation(ValidationError.datesRequired),
      );
    });

    test('when giving an inactive room to a booking '
        'then it is rejected', () async {
      await endpoints.room.update(
        sessionBuilder,
        room102.copyWith(active: false),
      );
      final camp = await addOctober('Camp', 12, 16);

      await expectLater(
        endpoints.booking.setRooms(sessionBuilder, camp.id!, [room102.id!]),
        throwsValidation(ValidationError.roomUnavailable, detail: '102'),
      );
    });
  });

  withServerpod(
    'Given two overlapping bookings',
    (sessionBuilder, endpoints) {
      final admin = sessionBuilder.asAdmin;

      test('when both take the same room at the same time '
          'then only one of them gets it', () async {
        final lead = await endpoints.contact.add(
          admin,
          Contact(firstName: 'Ada', lastName: 'Lovelace'),
        );
        final category = await endpoints.priceCategory.add(
          admin,
          PriceCategory(name: 'Standard'),
        );
        final room = await endpoints.room.add(
          admin,
          Room(roomNumber: '101', bedAmount: 4, priceCategoryId: category.id!),
        );
        final bookings = [
          for (final title in ['Camp', 'Choir'])
            await endpoints.booking.add(
              admin,
              Booking(
                title: title,
                arrival: DateTime.utc(2026, 10, 12),
                departure: DateTime.utc(2026, 10, 16),
                leadId: lead.id!,
              ),
            ),
        ];

        final results = await Future.wait([
          for (final booking in bookings)
            endpoints.booking
                .setRooms(admin, booking.id!, [room.id!])
                .then((_) => true)
                .catchError(
                  (_) => false,
                  test: (e) =>
                      e is ValidationException &&
                      e.reason == ValidationError.roomUnavailable,
                ),
        ]);

        expect(results.where((got) => got), hasLength(1));
        expect(await BookingRoom.db.count(admin.build()), 1);
      });
    },
    // The bookings are saved in transactions of their own, which cannot run
    // side by side inside the transaction of a test.
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
