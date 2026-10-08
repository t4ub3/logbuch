import 'dart:convert';

import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'prices.dart';
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
      final category = await endpoints.unitType.add(
        sessionBuilder,
        UnitType(name: 'Standard'),
      );
      room101 = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '101', bedAmount: 4, unitTypeId: category.id!),
        const [],
      );
      room102 = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '102', bedAmount: 2, unitTypeId: category.id!),
        const [],
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
          const [],
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

    group('when asking for the confirmation of a booking', () {
      Future<Booking> withStatus(BookingStatus status, {bool dated = true}) =>
          endpoints.booking.add(
            sessionBuilder,
            booking(
              'Camp',
              arrival: dated ? DateTime.utc(2026, 10, 12) : null,
              departure: dated ? DateTime.utc(2026, 10, 16) : null,
              status: status,
            ),
          );

      Future<void> saveOperator() => endpoints.operator.save(
        sessionBuilder,
        Operator(
          name: 'Haus am See e. V.',
          street: 'Seeweg 1',
          zip: '34117',
          city: 'Kassel',
          taxOffice: '',
          taxNumber: '',
          purposes: '',
          place: '',
        ),
      );

      test('that is confirmed then it comes as a PDF', () async {
        await saveOperator();
        final confirmed = await withStatus(BookingStatus.confirmed);

        // Those who only look at bookings can send it out as well.
        final pdf = await endpoints.booking.getConfirmationPdf(
          sessionBuilder.asViewer,
          confirmed.id!,
        );

        final start = pdf.buffer.asUint8List(pdf.offsetInBytes, 5);
        expect(ascii.decode(start), '%PDF-');
      });

      test('that is only an inquiry or cancelled then there is none', () async {
        await saveOperator();

        for (final status in [BookingStatus.inquiry, BookingStatus.cancelled]) {
          final unconfirmed = await withStatus(status);
          await expectLater(
            endpoints.booking.getConfirmationPdf(
              sessionBuilder,
              unconfirmed.id!,
            ),
            throwsValidation(ValidationError.notConfirmed),
          );
        }
      });

      test('that has no dates then there is none', () async {
        await saveOperator();
        final undated = await withStatus(BookingStatus.option, dated: false);

        await expectLater(
          endpoints.booking.getConfirmationPdf(sessionBuilder, undated.id!),
          throwsValidation(ValidationError.datesRequired),
        );
      });

      test('before the operator has a name and an address '
          'then there is none', () async {
        final confirmed = await withStatus(BookingStatus.confirmed);

        await expectLater(
          endpoints.booking.getConfirmationPdf(sessionBuilder, confirmed.id!),
          throwsValidation(ValidationError.operatorIncomplete),
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
        const [],
      );
      final camp = await addOctober('Camp', 12, 16);

      await expectLater(
        endpoints.booking.setRooms(sessionBuilder, camp.id!, [room102.id!]),
        throwsValidation(ValidationError.roomUnavailable, detail: '102'),
      );
    });

    group('and a hall that bookings share', () {
      late Room hall;

      Future<Booking> addWithHall(String title, int arrival, int departure) {
        return addOctober(title, arrival, departure).then(
          (added) => endpoints.booking.setRooms(sessionBuilder, added.id!, [
            hall.id!,
          ]),
        );
      }

      Future<List<String>> crowded(Booking booking) async => [
        for (final room in await endpoints.booking.crowdedRooms(
          sessionBuilder,
          booking.id!,
        ))
          room.roomNumber,
      ];

      setUp(() async {
        final shared = await endpoints.unitType.add(
          sessionBuilder,
          UnitType(name: 'Hall', shared: true),
        );
        hall = await endpoints.room.add(
          sessionBuilder,
          Room(roomNumber: 'Hall', bedAmount: 0, unitTypeId: shared.id!),
          const [],
        );
        final list = await endpoints.priceList.add(
          sessionBuilder,
          PriceList(name: '2026', validFrom: DateTime.utc(2026)),
        );
        await endpoints.priceList.savePrices(
          sessionBuilder,
          list.id!,
          prices(
            unitPrices: [
              UnitPrice(
                priceListId: list.id!,
                unitTypeId: shared.id!,
                pricePerNight: 5000,
              ),
            ],
          ),
        );
      });

      test('when two bookings take it for the same nights '
          'then both get it and it stays available', () async {
        final camp = await addWithHall('Camp', 12, 16);
        final choir = await addWithHall('Choir', 14, 18);

        expect(camp.rooms!.single.roomId, hall.id);
        expect(choir.rooms!.single.roomId, hall.id);
        final free = await endpoints.booking.availableRooms(
          sessionBuilder,
          DateTime.utc(2026, 10, 12),
          DateTime.utc(2026, 10, 16),
        );
        expect(free.map((room) => room.roomNumber), contains('Hall'));
      });

      test('when two bookings share it '
          'then each pays half for the nights they share', () async {
        final camp = await addWithHall('Camp', 12, 16);
        final choir = await addWithHall('Choir', 14, 18);

        final campPrice = await endpoints.pricing.calculate(
          sessionBuilder,
          camp.id!,
        );
        final choirPrice = await endpoints.pricing.calculate(
          sessionBuilder,
          choir.id!,
        );

        expect(campPrice.lines.map((l) => (l.quantity, l.unitPrice)), [
          (2, 5000),
          (2, 2500),
        ]);
        expect(choirPrice.lines.map((l) => (l.quantity, l.unitPrice)), [
          (2, 2500),
          (2, 5000),
        ]);
      });

      test('when one of them is cancelled '
          'then the other pays in full again', () async {
        final camp = await addWithHall('Camp', 12, 16);
        final choir = await addWithHall('Choir', 12, 16);
        await endpoints.booking.update(
          sessionBuilder,
          choir.copyWith(status: BookingStatus.cancelled),
        );

        final price = await endpoints.pricing.calculate(
          sessionBuilder,
          camp.id!,
        );

        expect(price.total, 20000);
      });

      test('when more than two bookings hold it in the same night '
          'then it is crowded for those bookings', () async {
        final camp = await addWithHall('Camp', 12, 16);
        final choir = await addWithHall('Choir', 15, 18);
        expect(await crowded(camp), isEmpty);

        final party = await addWithHall('Party', 15, 16);
        final later = await addWithHall('Later', 16, 17);

        expect(await crowded(camp), ['Hall']);
        expect(await crowded(choir), ['Hall']);
        expect(await crowded(party), ['Hall']);
        // On its night only the choir is there as well.
        expect(await crowded(later), isEmpty);
      });
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
        final category = await endpoints.unitType.add(
          admin,
          UnitType(name: 'Standard'),
        );
        final room = await endpoints.room.add(
          admin,
          Room(roomNumber: '101', bedAmount: 4, unitTypeId: category.id!),
          const [],
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
