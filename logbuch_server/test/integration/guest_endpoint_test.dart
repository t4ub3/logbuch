import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a booking that holds a room', (sessionBuilder, endpoints) {
    late Contact lead;
    late Room room;
    late Booking booking;
    late GuestGroup family;

    Future<Booking> addBooking(String title, int arrival, int departure) =>
        endpoints.booking.add(
          sessionBuilder,
          Booking(
            title: title,
            arrival: DateTime.utc(2027, 5, arrival),
            departure: DateTime.utc(2027, 5, departure),
            leadId: lead.id!,
          ),
        );

    Future<List<Guest>> guestsOf(Booking booking) async {
      final groups = await endpoints.guest.getByBooking(
        sessionBuilder,
        booking.id!,
      );
      return [for (final group in groups) ...?group.guests];
    }

    setUp(() async {
      lead = await endpoints.contact.add(
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
      room = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '101', bedAmount: 4, priceCategoryId: category.id!),
      );
      booking = await addBooking('Family days', 10, 13);
      booking = await endpoints.booking.setRooms(sessionBuilder, booking.id!, [
        room.id!,
      ]);
      family = await endpoints.guest.addGroup(
        sessionBuilder,
        GuestGroup(bookingId: booking.id!, name: ' Weber family '),
      );
    });

    test(
      'when adding guests '
      'then the booking lists them in their group with their contacts',
      () async {
        await endpoints.guest.addGuest(
          sessionBuilder,
          Guest(groupId: family.id!, contactId: lead.id!),
        );
        await endpoints.guest.addNewGuest(
          sessionBuilder,
          Guest(groupId: family.id!, contactId: 0, dietaryNotes: 'No nuts'),
          Contact(
            firstName: ' Jonas ',
            lastName: 'Weber',
            birthDate: DateTime.utc(2019, 3, 3),
          ),
        );

        final groups = await endpoints.guest.getByBooking(
          sessionBuilder,
          booking.id!,
        );
        expect(groups.single.name, 'Weber family');
        expect(groups.single.guests!.map((g) => g.contact!.firstName), [
          'Marie',
          'Jonas',
        ]);
        expect(groups.single.guests!.last.dietaryNotes, 'No nuts');
        expect(await endpoints.contact.getAll(sessionBuilder), hasLength(2));
      },
    );

    test('when adding a new guest without a name '
        'then neither guest nor contact is stored', () async {
      await expectLater(
        endpoints.guest.addNewGuest(
          sessionBuilder,
          Guest(groupId: family.id!, contactId: 0),
          Contact(firstName: '', lastName: ' '),
        ),
        throwsValidation(ValidationError.nameRequired),
      );

      expect(await guestsOf(booking), isEmpty);
      expect(await endpoints.contact.getAll(sessionBuilder), hasLength(1));
    });

    group('when the booking has a guest', () {
      late Guest guest;

      setUp(() async {
        guest = await endpoints.guest.addGuest(
          sessionBuilder,
          Guest(groupId: family.id!, contactId: lead.id!),
        );
      });

      test('then the guest can be put into the room and taken out', () async {
        final hold = booking.rooms!.single;

        await endpoints.guest.assign(sessionBuilder, [guest.id!], hold.id);
        expect((await guestsOf(booking)).single.bookingRoomId, hold.id);

        await endpoints.guest.assign(sessionBuilder, [guest.id!], null);
        expect((await guestsOf(booking)).single.bookingRoomId, isNull);
      });

      test(
        'then the guest cannot be put into a room of another booking',
        () async {
          final other = await addBooking('Choir', 20, 22);
          final otherHold = (await endpoints.booking.setRooms(
            sessionBuilder,
            other.id!,
            [room.id!],
          )).rooms!.single;

          await expectLater(
            endpoints.guest.assign(sessionBuilder, [guest.id!], otherHold.id),
            throwsValidation(ValidationError.roomNotHeld),
          );
          await expectLater(
            endpoints.guest.updateGuest(
              sessionBuilder,
              guest.copyWith(bookingRoomId: otherHold.id),
            ),
            throwsValidation(ValidationError.roomNotHeld),
          );
        },
      );

      test('then giving up the room leaves the guest without one', () async {
        await endpoints.guest.assign(sessionBuilder, [
          guest.id!,
        ], booking.rooms!.single.id);

        await endpoints.booking.setRooms(sessionBuilder, booking.id!, []);

        expect((await guestsOf(booking)).single.bookingRoomId, isNull);
      });

      test(
        'then the stay of the guest must not end before it starts',
        () async {
          await expectLater(
            endpoints.guest.updateGuest(
              sessionBuilder,
              guest.copyWith(
                arrivalOverride: DateTime.utc(2027, 5, 12),
                departureOverride: DateTime.utc(2027, 5, 11),
              ),
            ),
            throwsValidation(ValidationError.invalidDateRange),
          );
        },
      );

      test('then the contact cannot be deleted', () async {
        final contact = await endpoints.contact.add(
          sessionBuilder,
          Contact(firstName: 'Felix', lastName: 'Wagner'),
        );
        await endpoints.guest.addGuest(
          sessionBuilder,
          Guest(groupId: family.id!, contactId: contact.id!),
        );

        await expectLater(
          endpoints.contact.delete(sessionBuilder, contact.id!),
          throwsValidation(ValidationError.inUse),
        );
      });

      test(
        'then deleting the group removes the guest but not the contact',
        () async {
          await endpoints.guest.deleteGroup(sessionBuilder, family.id!);

          expect(
            await endpoints.guest.getByBooking(sessionBuilder, booking.id!),
            isEmpty,
          );
          expect(await endpoints.contact.getAll(sessionBuilder), hasLength(1));
        },
      );

      test('then a viewer sees the guest but cannot add another', () async {
        final viewer = sessionBuilder.asViewer;

        final groups = await endpoints.guest.getByBooking(viewer, booking.id!);
        expect(groups.single.guests, hasLength(1));

        await expectLater(
          endpoints.guest.addGuest(
            viewer,
            Guest(groupId: family.id!, contactId: lead.id!),
          ),
          throwsValidation(ValidationError.adminRequired),
        );
        await expectLater(
          endpoints.guest.assign(viewer, [guest.id!], null),
          throwsValidation(ValidationError.adminRequired),
        );
      });

      test('then the price follows the rates for the room and the age '
          'of the guest', () async {
        final season = await endpoints.season.add(
          sessionBuilder,
          Season(
            name: 'Spring',
            validFrom: DateTime.utc(2027, 3, 1),
            validTo: DateTime.utc(2027, 5, 31),
          ),
        );
        final adult = await endpoints.ageGroup.add(
          sessionBuilder,
          AgeGroup(name: 'Adult', minAge: 18),
        );
        await endpoints.roomRate.saveForSeason(sessionBuilder, season.id!, [
          RoomRate(
            seasonId: season.id!,
            priceCategoryId: room.priceCategoryId,
            ageGroupId: adult.id!,
            pricePerNight: 2500,
          ),
        ]);
        await endpoints.fee.add(
          sessionBuilder,
          Fee(
            name: 'Final cleaning',
            amount: 4000,
            unit: FeeUnit.perBooking,
            taxRate: 700,
            autoApply: true,
          ),
        );

        // Without a room the guest cannot be priced yet.
        var price = await endpoints.pricing.calculate(
          sessionBuilder.asViewer,
          booking.id!,
        );
        expect(price.problems.single.reason, PricingProblemReason.roomMissing);
        expect(price.total, 4000);

        await endpoints.guest.assign(sessionBuilder, [
          guest.id!,
        ], booking.rooms!.single.id);
        price = await endpoints.pricing.calculate(sessionBuilder, booking.id!);

        expect(price.problems, isEmpty);
        expect(price.lines.map((l) => (l.type, l.quantity, l.total)), [
          (ChargeType.lodging, 3, 7500),
          (ChargeType.fee, 1, 4000),
        ]);
        expect(price.total, 11500);
      });
    });
  });
}
