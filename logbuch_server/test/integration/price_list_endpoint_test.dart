import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'prices.dart';
import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a price list from January 2027 with prices', (
    sessionBuilder,
    endpoints,
  ) {
    late PriceList list;
    late UnitType standard;
    late UnitType bungalow;
    late MealPlan fullBoard;
    late AgeGroup child;
    late AgeGroup adult;
    late Fee cleaning;

    RoomRate roomRate(AgeGroup ageGroup, int price) => RoomRate(
      priceListId: list.id!,
      unitTypeId: standard.id!,
      ageGroupId: ageGroup.id!,
      pricePerNight: price,
    );

    MealRate mealRate(AgeGroup ageGroup, int price) => MealRate(
      priceListId: list.id!,
      mealPlanId: fullBoard.id!,
      ageGroupId: ageGroup.id!,
      pricePerNight: price,
    );

    UnitPrice unitPrice({int? perNight, int? dayUse}) => UnitPrice(
      priceListId: list.id!,
      unitTypeId: bungalow.id!,
      pricePerNight: perNight,
      dayUsePrice: dayUse,
    );

    FeePrice feePrice(int amount) =>
        FeePrice(priceListId: list.id!, feeId: cleaning.id!, amount: amount);

    Future<PriceListPrices> pricesOf(PriceList list) =>
        endpoints.priceList.getPrices(sessionBuilder, list.id!);

    Future<PriceList> addList(String name, DateTime validFrom) =>
        endpoints.priceList.add(
          sessionBuilder,
          PriceList(name: name, validFrom: validFrom),
        );

    setUp(() async {
      list = await addList('2027', DateTime.utc(2027));
      standard = await endpoints.unitType.add(
        sessionBuilder,
        UnitType(name: 'Standard'),
      );
      bungalow = await endpoints.unitType.add(
        sessionBuilder,
        UnitType(name: 'Bungalow'),
      );
      fullBoard = await endpoints.mealPlan.add(
        sessionBuilder,
        MealPlan(name: 'Full board'),
      );
      child = await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: 'Child', minAge: 0, maxAge: 17),
      );
      adult = await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: 'Adult', minAge: 18),
      );
      cleaning = await endpoints.fee.add(
        sessionBuilder,
        Fee(name: 'Cleaning', unit: FeeUnit.perBooking, autoApply: true),
        const [],
      );

      await endpoints.priceList.savePrices(
        sessionBuilder,
        list.id!,
        prices(
          roomRates: [roomRate(child, 1200), roomRate(adult, 2500)],
          unitPrices: [unitPrice(perNight: 9000, dayUse: 5000)],
          mealRates: [mealRate(child, 900), mealRate(adult, 1800)],
          feePrices: [feePrice(4000)],
        ),
      );
    });

    test('when adding a list that begins later '
        'then it starts with the prices in force until then '
        'and the lists come by their first day', () async {
      await addList('2026', DateTime.utc(2026));
      final next = await addList('2028', DateTime.utc(2028));

      final copied = await pricesOf(next);
      expect(copied.roomRates.map((r) => r.pricePerNight).toSet(), {
        1200,
        2500,
      });
      expect(copied.unitPrices.single.dayUsePrice, 5000);
      expect(copied.mealRates, hasLength(2));
      expect(copied.feePrices.single.amount, 4000);
      expect(copied.roomRates.map((r) => r.priceListId).toSet(), {next.id});

      final lists = await endpoints.priceList.getAll(sessionBuilder);
      expect(lists.map((l) => l.name), ['2026', '2027', '2028']);
    });

    test('when adding a list that begins before all others '
        'then it has no prices yet', () async {
      final first = await addList('2026', DateTime.utc(2026));

      expect((await pricesOf(first)).roomRates, isEmpty);
    });

    test('when adding a list that begins on the same day '
        'then it is rejected', () async {
      await expectLater(
        addList('Again', DateTime.utc(2027)),
        throwsValidation(ValidationError.priceListDateTaken, detail: '2027'),
      );
    });

    test('when renaming the list itself '
        'then its own first day is not in the way', () async {
      final renamed = await endpoints.priceList.update(
        sessionBuilder,
        list.copyWith(name: 'Prices 2027'),
      );

      expect(renamed.name, 'Prices 2027');
    });

    test('when adding a list with a time of day '
        'then it is rejected', () async {
      await expectLater(
        // Midnight in Berlin, sent without converting to a UTC date.
        addList('Local midnight', DateTime.utc(2027, 12, 31, 23)),
        throwsValidation(ValidationError.invalidDate),
      );
    });

    test('when adding a list without a name then it is rejected', () async {
      await expectLater(
        addList('  ', DateTime.utc(2028)),
        throwsValidation(ValidationError.nameRequired),
      );
    });

    test('when saving the prices without one of them '
        'then that has no price anymore', () async {
      await endpoints.priceList.savePrices(
        sessionBuilder,
        list.id!,
        prices(roomRates: [roomRate(adult, 2700)]),
      );

      final saved = await pricesOf(list);
      expect(saved.roomRates.single.ageGroupId, adult.id);
      expect(saved.roomRates.single.pricePerNight, 2700);
      expect(saved.unitPrices, isEmpty);
      expect(saved.mealRates, isEmpty);
      expect(saved.feePrices, isEmpty);
    });

    test('when saving the prices of a list '
        'then another list keeps its own', () async {
      final next = await addList('2028', DateTime.utc(2028));

      await endpoints.priceList.savePrices(sessionBuilder, next.id!, prices());

      expect((await pricesOf(next)).roomRates, isEmpty);
      expect((await pricesOf(list)).roomRates, hasLength(2));
    });

    test('when saving a unit price without any amount '
        'then it is not kept', () async {
      await endpoints.priceList.savePrices(
        sessionBuilder,
        list.id!,
        prices(unitPrices: [unitPrice()]),
      );

      expect((await pricesOf(list)).unitPrices, isEmpty);
    });

    test('when saving a negative price '
        'then it is rejected and the prices are unchanged', () async {
      for (final wrong in [
        prices(roomRates: [roomRate(adult, -1)]),
        prices(unitPrices: [unitPrice(dayUse: -1)]),
        prices(mealRates: [mealRate(adult, -1)]),
        prices(feePrices: [feePrice(-1)]),
      ]) {
        await expectLater(
          endpoints.priceList.savePrices(sessionBuilder, list.id!, wrong),
          throwsValidation(ValidationError.invalidAmount),
        );
      }

      expect((await pricesOf(list)).roomRates, hasLength(2));
    });

    test('when saving two prices for the same thing '
        'then it is rejected', () async {
      for (final twice in [
        prices(roomRates: [roomRate(adult, 2500), roomRate(adult, 2600)]),
        prices(unitPrices: [unitPrice(perNight: 1), unitPrice(perNight: 2)]),
        prices(mealRates: [mealRate(adult, 1), mealRate(adult, 2)]),
        prices(feePrices: [feePrice(1), feePrice(2)]),
      ]) {
        await expectLater(
          endpoints.priceList.savePrices(sessionBuilder, list.id!, twice),
          throwsValidation(ValidationError.duplicateRate),
        );
      }
    });

    test('when deleting the list then its prices are deleted', () async {
      await endpoints.priceList.delete(sessionBuilder, list.id!);

      final session = sessionBuilder.build();
      expect(await RoomRate.db.count(session), 0);
      expect(await UnitPrice.db.count(session), 0);
      expect(await MealRate.db.count(session), 0);
      expect(await FeePrice.db.count(session), 0);
    });

    test('when deleting what a price is for '
        'then the price is deleted with it', () async {
      await endpoints.mealPlan.delete(sessionBuilder, fullBoard.id!);
      await endpoints.ageGroup.delete(sessionBuilder, child.id!);
      await endpoints.unitType.delete(sessionBuilder, bungalow.id!);
      await endpoints.fee.delete(sessionBuilder, cleaning.id!);

      final saved = await pricesOf(list);
      expect(saved.roomRates.single.ageGroupId, adult.id);
      expect(saved.unitPrices, isEmpty);
      expect(saved.mealRates, isEmpty);
      expect(saved.feePrices, isEmpty);
    });
  });
}
