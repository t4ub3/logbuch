import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a season from March to May', (
    sessionBuilder,
    endpoints,
  ) {
    late Season spring;

    setUp(() async {
      spring = await endpoints.season.add(
        sessionBuilder,
        Season(
          name: 'Spring',
          validFrom: DateTime.utc(2027, 3, 1),
          validTo: DateTime.utc(2027, 5, 31),
        ),
      );
    });

    test('when adding a season starting on its last day '
        'then it is rejected as overlapping', () async {
      await expectLater(
        endpoints.season.add(
          sessionBuilder,
          Season(
            name: 'Summer',
            validFrom: DateTime.utc(2027, 5, 31),
            validTo: DateTime.utc(2027, 8, 31),
          ),
        ),
        throwsValidation(ValidationError.seasonOverlap, detail: 'Spring'),
      );
    });

    test('when adding a season starting the day after '
        'then both are listed by start date', () async {
      await endpoints.season.add(
        sessionBuilder,
        Season(
          name: 'Summer',
          validFrom: DateTime.utc(2027, 6, 1),
          validTo: DateTime.utc(2027, 8, 31),
        ),
      );
      await endpoints.season.add(
        sessionBuilder,
        Season(
          name: 'Winter',
          validFrom: DateTime.utc(2027, 1, 1),
          validTo: DateTime.utc(2027, 2, 28),
        ),
      );

      final seasons = await endpoints.season.getAll(sessionBuilder);
      expect(seasons.map((s) => s.name), ['Winter', 'Spring', 'Summer']);
    });

    test('when extending the season itself '
        'then it does not count as overlapping', () async {
      final updated = await endpoints.season.update(
        sessionBuilder,
        spring.copyWith(validTo: DateTime.utc(2027, 6, 15)),
      );

      expect(updated.validTo, DateTime.utc(2027, 6, 15));
    });

    test('when adding a season that ends before it starts '
        'then it is rejected', () async {
      await expectLater(
        endpoints.season.add(
          sessionBuilder,
          Season(
            name: 'Backwards',
            validFrom: DateTime.utc(2028, 2, 1),
            validTo: DateTime.utc(2028, 1, 1),
          ),
        ),
        throwsValidation(ValidationError.invalidDateRange),
      );
    });

    test('when adding a season with a time of day '
        'then it is rejected', () async {
      await expectLater(
        endpoints.season.add(
          sessionBuilder,
          Season(
            name: 'Local midnight',
            // Midnight in Berlin, sent without converting to a UTC date.
            validFrom: DateTime.utc(2027, 12, 31, 23),
            validTo: DateTime.utc(2028, 3, 31),
          ),
        ),
        throwsValidation(ValidationError.invalidDate),
      );
    });

    test('when adding a season without a name '
        'then it is rejected', () async {
      await expectLater(
        endpoints.season.add(
          sessionBuilder,
          Season(
            name: '  ',
            validFrom: DateTime.utc(2028, 1, 1),
            validTo: DateTime.utc(2028, 3, 31),
          ),
        ),
        throwsValidation(ValidationError.nameRequired),
      );
    });
  });
}
