import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given two seasons with rates', (sessionBuilder, endpoints) {
    late Season summer;
    late Season winter;
    late PriceCategory standard;
    late MealPlan fullBoard;
    late AgeGroup child;
    late AgeGroup adult;

    RoomRate roomRate(AgeGroup ageGroup, int price, {Season? season}) =>
        RoomRate(
          seasonId: (season ?? summer).id!,
          priceCategoryId: standard.id!,
          ageGroupId: ageGroup.id!,
          pricePerNight: price,
        );

    MealRate mealRate(AgeGroup ageGroup, int price) => MealRate(
      seasonId: summer.id!,
      mealPlanId: fullBoard.id!,
      ageGroupId: ageGroup.id!,
      pricePerNight: price,
    );

    setUp(() async {
      summer = await endpoints.season.add(
        sessionBuilder,
        Season(
          name: 'Summer',
          validFrom: DateTime.utc(2027, 6, 1),
          validTo: DateTime.utc(2027, 8, 31),
        ),
      );
      winter = await endpoints.season.add(
        sessionBuilder,
        Season(
          name: 'Winter',
          validFrom: DateTime.utc(2027, 12, 1),
          validTo: DateTime.utc(2028, 2, 29),
        ),
      );
      standard = await endpoints.priceCategory.add(
        sessionBuilder,
        PriceCategory(name: 'Standard'),
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

      await endpoints.roomRate.saveForSeason(sessionBuilder, summer.id!, [
        roomRate(child, 1200),
        roomRate(adult, 2500),
      ]);
      await endpoints.roomRate.saveForSeason(sessionBuilder, winter.id!, [
        roomRate(adult, 2000, season: winter),
      ]);
      await endpoints.mealRate.saveForSeason(sessionBuilder, summer.id!, [
        mealRate(child, 900),
        mealRate(adult, 1800),
      ]);
    });

    test('when saving the room rates of a season without a cell '
        'then that cell has no price anymore', () async {
      await endpoints.roomRate.saveForSeason(sessionBuilder, summer.id!, [
        roomRate(adult, 2700),
      ]);

      final rates = await endpoints.roomRate.getBySeason(
        sessionBuilder,
        summer.id!,
      );
      expect(rates, hasLength(1));
      expect(rates.single.ageGroupId, adult.id);
      expect(rates.single.pricePerNight, 2700);
    });

    test('when saving the room rates of a season '
        'then the other season keeps its rates', () async {
      await endpoints.roomRate.saveForSeason(sessionBuilder, summer.id!, []);

      final rates = await endpoints.roomRate.getBySeason(
        sessionBuilder,
        winter.id!,
      );
      expect(rates.single.pricePerNight, 2000);
    });

    test('when saving room rates carrying another season '
        'then they are stored for the given season', () async {
      await endpoints.roomRate.saveForSeason(sessionBuilder, summer.id!, [
        roomRate(adult, 3000, season: winter),
      ]);

      final summerRates = await endpoints.roomRate.getBySeason(
        sessionBuilder,
        summer.id!,
      );
      final winterRates = await endpoints.roomRate.getBySeason(
        sessionBuilder,
        winter.id!,
      );
      expect(summerRates.single.pricePerNight, 3000);
      expect(winterRates.single.pricePerNight, 2000);
    });

    test('when saving a negative room rate '
        'then it is rejected and the rates are unchanged', () async {
      await expectLater(
        endpoints.roomRate.saveForSeason(sessionBuilder, summer.id!, [
          roomRate(adult, -1),
        ]),
        throwsValidation(ValidationError.invalidAmount),
      );

      final rates = await endpoints.roomRate.getBySeason(
        sessionBuilder,
        summer.id!,
      );
      expect(rates, hasLength(2));
    });

    test('when saving two room rates for the same cell '
        'then it is rejected', () async {
      await expectLater(
        endpoints.roomRate.saveForSeason(sessionBuilder, summer.id!, [
          roomRate(adult, 2500),
          roomRate(adult, 2600),
        ]),
        throwsValidation(ValidationError.duplicateRate),
      );
    });

    test('when deleting the season '
        'then its room and meal rates are deleted', () async {
      await endpoints.season.delete(sessionBuilder, summer.id!);

      final session = sessionBuilder.build();
      expect(await RoomRate.db.count(session), 1);
      expect(await MealRate.db.count(session), 0);
    });

    test('when saving the meal rates of a season without a cell '
        'then that cell has no price anymore', () async {
      await endpoints.mealRate.saveForSeason(sessionBuilder, summer.id!, [
        mealRate(child, 950),
      ]);

      final rates = await endpoints.mealRate.getBySeason(
        sessionBuilder,
        summer.id!,
      );
      expect(rates.single.ageGroupId, child.id);
      expect(rates.single.pricePerNight, 950);
    });

    test('when deleting the meal plan '
        'then its meal rates are deleted', () async {
      await endpoints.mealPlan.delete(sessionBuilder, fullBoard.id!);

      expect(await MealRate.db.count(sessionBuilder.build()), 0);
    });

    test('when deleting an age group '
        'then its room and meal rates are deleted', () async {
      await endpoints.ageGroup.delete(sessionBuilder, child.id!);

      final session = sessionBuilder.build();
      expect(await RoomRate.db.count(session), 2);
      expect(await MealRate.db.count(session), 1);
    });
  });
}
