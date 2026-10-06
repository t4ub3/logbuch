import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a price category with a room', (
    sessionBuilder,
    endpoints,
  ) {
    late PriceCategory comfort;
    late Room room;

    setUp(() async {
      comfort = await endpoints.priceCategory.add(
        sessionBuilder,
        PriceCategory(name: 'Comfort'),
      );
      room = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '201', bedAmount: 4, priceCategoryId: comfort.id!),
      );
    });

    test('when listing the rooms '
        'then they come with their price category', () async {
      final rooms = await endpoints.room.getAll(sessionBuilder);

      expect(rooms.single.priceCategory?.name, 'Comfort');
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
          Room(roomNumber: ' ', bedAmount: 2, priceCategoryId: comfort.id!),
        ),
        throwsValidation(ValidationError.nameRequired),
      );
    });

    test('when adding a room with a negative number of beds '
        'then it is rejected', () async {
      await expectLater(
        endpoints.room.add(
          sessionBuilder,
          Room(roomNumber: '202', bedAmount: -1, priceCategoryId: comfort.id!),
        ),
        throwsValidation(ValidationError.invalidBedAmount),
      );
    });

    test('when deleting the price category '
        'then it is rejected as in use', () async {
      await expectLater(
        endpoints.priceCategory.delete(sessionBuilder, comfort.id!),
        throwsValidation(ValidationError.inUse),
      );
    });

    test('when deleting the room first '
        'then the price category can be deleted', () async {
      await endpoints.room.delete(sessionBuilder, room.id!);
      await endpoints.priceCategory.delete(sessionBuilder, comfort.id!);

      expect(await endpoints.priceCategory.getAll(sessionBuilder), isEmpty);
    });
  });

  withAdmin('Given Fee endpoint', (sessionBuilder, endpoints) {
    test('when adding a fee with a tax rate above 100 % '
        'then it is rejected', () async {
      await expectLater(
        endpoints.fee.add(
          sessionBuilder,
          Fee(
            name: 'Linen',
            amount: 800,
            unit: FeeUnit.perPerson,
            taxRate: 10001,
          ),
        ),
        throwsValidation(ValidationError.invalidTaxRate),
      );
    });

    test('when adding a fee with a negative amount '
        'then it is rejected', () async {
      await expectLater(
        endpoints.fee.add(
          sessionBuilder,
          Fee(name: 'Linen', amount: -800, unit: FeeUnit.perPerson),
        ),
        throwsValidation(ValidationError.invalidAmount),
      );
    });

    test('when adding a fee without further details '
        'then it is untaxed, for all ages and added manually', () async {
      final fee = await endpoints.fee.add(
        sessionBuilder,
        Fee(name: 'Final cleaning', amount: 8000, unit: FeeUnit.perBooking),
      );

      expect(fee.taxRate, 0);
      expect(fee.ageGroupId, isNull);
      expect(fee.autoApply, isFalse);
    });
  });
}
