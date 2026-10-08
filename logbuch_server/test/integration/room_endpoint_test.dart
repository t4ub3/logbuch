import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a unit type and a building with a room', (
    sessionBuilder,
    endpoints,
  ) {
    late UnitType comfort;
    late Building annex;
    late Room room;

    setUp(() async {
      comfort = await endpoints.unitType.add(
        sessionBuilder,
        UnitType(name: 'Comfort'),
      );
      annex = await endpoints.building.add(
        sessionBuilder,
        Building(name: 'Annex'),
      );
      room = await endpoints.room.add(
        sessionBuilder,
        Room(
          roomNumber: '201',
          bedAmount: 4,
          unitTypeId: comfort.id!,
          buildingId: annex.id,
        ),
        const [],
      );
    });

    test('when listing the rooms '
        'then they come with their unit type and building', () async {
      final rooms = await endpoints.room.getAll(sessionBuilder);

      expect(rooms.single.unitType?.name, 'Comfort');
      expect(rooms.single.building?.name, 'Annex');
      expect(rooms.single.fees, isEmpty);
    });

    test('when the unit type was added without further details '
        'then it is taxed at 7 % and not shared', () async {
      expect(comfort.taxRate, 700);
      expect(comfort.shared, isFalse);
    });

    test('when the room was added without further details '
        'then it is active and has no crib', () async {
      expect(room.active, isTrue);
      expect(room.cribPossible, isFalse);
    });

    test('when updating the room '
        'then the changes are stored', () async {
      await endpoints.room.update(
        sessionBuilder,
        room.copyWith(bedAmount: 3, cribPossible: true, active: false),
        const [],
      );

      final fetched = await endpoints.room.getById(sessionBuilder, room.id!);
      expect(fetched?.bedAmount, 3);
      expect(fetched?.cribPossible, isTrue);
      expect(fetched?.active, isFalse);
    });

    test('when adding a room without a number '
        'then it is rejected', () async {
      await expectLater(
        endpoints.room.add(
          sessionBuilder,
          Room(roomNumber: ' ', bedAmount: 2, unitTypeId: comfort.id!),
          const [],
        ),
        throwsValidation(ValidationError.nameRequired),
      );
    });

    test('when adding a room with a negative number of beds '
        'then it is rejected', () async {
      await expectLater(
        endpoints.room.add(
          sessionBuilder,
          Room(roomNumber: '202', bedAmount: -1, unitTypeId: comfort.id!),
          const [],
        ),
        throwsValidation(ValidationError.invalidBedAmount),
      );
    });

    test('when adding a unit type with a tax rate above 100 % '
        'then it is rejected', () async {
      await expectLater(
        endpoints.unitType.add(
          sessionBuilder,
          UnitType(name: 'Hall', taxRate: 10001),
        ),
        throwsValidation(ValidationError.invalidTaxRate),
      );
    });

    test('when deleting the unit type or the building '
        'then it is rejected as in use', () async {
      await expectLater(
        endpoints.unitType.delete(sessionBuilder, comfort.id!),
        throwsValidation(ValidationError.inUse),
      );
      await expectLater(
        endpoints.building.delete(sessionBuilder, annex.id!),
        throwsValidation(ValidationError.inUse),
      );
    });

    test('when deleting the room first '
        'then the unit type and the building can be deleted', () async {
      await endpoints.room.delete(sessionBuilder, room.id!);
      await endpoints.unitType.delete(sessionBuilder, comfort.id!);
      await endpoints.building.delete(sessionBuilder, annex.id!);

      expect(await endpoints.unitType.getAll(sessionBuilder), isEmpty);
      expect(await endpoints.building.getAll(sessionBuilder), isEmpty);
    });

    group('and a surcharge for a bathroom', () {
      late Fee bathroom;

      Future<List<String>> surcharges() async => [
        for (final fee in (await endpoints.room.getById(
          sessionBuilder,
          room.id!,
        ))!.fees!)
          fee.fee!.name,
      ];

      setUp(() async {
        bathroom = await endpoints.fee.add(
          sessionBuilder,
          Fee(name: 'Bathroom', unit: FeeUnit.perPersonNight),
          [room.id!],
        );
      });

      test('when reading the room or the fee '
          'then each knows the other', () async {
        final fees = await endpoints.fee.getAll(sessionBuilder);

        expect(await surcharges(), ['Bathroom']);
        expect(fees.single.rooms!.single.roomId, room.id);
      });

      test('when saving the fee without the room '
          'then the room has no surcharge anymore', () async {
        await endpoints.fee.update(sessionBuilder, bathroom, const []);

        expect(await surcharges(), isEmpty);
      });

      test('when saving the room with its surcharges '
          'then those replace the ones it had', () async {
        final balcony = await endpoints.fee.add(
          sessionBuilder,
          Fee(name: 'Balcony', unit: FeeUnit.perRoomNight),
          const [],
        );

        await endpoints.room.update(sessionBuilder, room, [balcony.id!]);

        expect(await surcharges(), ['Balcony']);
      });

      test('when the fee is to be charged to every booking as well '
          'then it is rejected', () async {
        await expectLater(
          endpoints.fee.update(
            sessionBuilder,
            bathroom.copyWith(autoApply: true),
            [room.id!],
          ),
          throwsValidation(ValidationError.invalidFeeScope),
        );
      });

      test('when a fee per booking is to be the surcharge of a room '
          'then it is rejected', () async {
        final cleaning = await endpoints.fee.add(
          sessionBuilder,
          Fee(name: 'Cleaning', unit: FeeUnit.perBooking),
          const [],
        );

        await expectLater(
          endpoints.room.update(sessionBuilder, room, [cleaning.id!]),
          throwsValidation(ValidationError.invalidFeeScope),
        );
        await expectLater(
          endpoints.fee.update(sessionBuilder, cleaning, [room.id!]),
          throwsValidation(ValidationError.invalidFeeScope),
        );
      });

      test('when deleting the room or the fee '
          'then the surcharge goes with it', () async {
        await endpoints.fee.delete(sessionBuilder, bathroom.id!);
        expect(await surcharges(), isEmpty);

        await endpoints.room.delete(sessionBuilder, room.id!);
        expect(await RoomFee.db.count(sessionBuilder.build()), 0);
      });
    });
  });

  withAdmin('Given Fee endpoint', (sessionBuilder, endpoints) {
    test('when adding a fee with a tax rate above 100 % '
        'then it is rejected', () async {
      await expectLater(
        endpoints.fee.add(
          sessionBuilder,
          Fee(name: 'Linen', unit: FeeUnit.perPerson, taxRate: 10001),
          const [],
        ),
        throwsValidation(ValidationError.invalidTaxRate),
      );
    });

    test('when adding a fee without further details '
        'then it is untaxed, for all ages and charged to nobody', () async {
      final fee = await endpoints.fee.add(
        sessionBuilder,
        Fee(name: 'Final cleaning', unit: FeeUnit.perBooking),
        const [],
      );

      expect(fee.taxRate, 0);
      expect(fee.ageGroupId, isNull);
      expect(fee.autoApply, isFalse);
    });
  });
}
