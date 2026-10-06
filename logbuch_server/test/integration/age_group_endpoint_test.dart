import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given the age groups 0–2 and 18+', (
    sessionBuilder,
    endpoints,
  ) {
    late AgeGroup toddler;
    late AgeGroup adult;

    setUp(() async {
      adult = await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: 'Adult', minAge: 18),
      );
      toddler = await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: '0–2', minAge: 0, maxAge: 2),
      );
    });

    test('when adding the ages in between '
        'then the groups are listed by age', () async {
      await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: '3–17', minAge: 3, maxAge: 17),
      );

      final groups = await endpoints.ageGroup.getAll(sessionBuilder);
      expect(groups.map((g) => g.name), ['0–2', '3–17', 'Adult']);
    });

    test('when adding a group that shares an age with another '
        'then it is rejected as overlapping', () async {
      await expectLater(
        endpoints.ageGroup.add(
          sessionBuilder,
          AgeGroup(name: '2–5', minAge: 2, maxAge: 5),
        ),
        throwsValidation(ValidationError.ageGroupOverlap, detail: '0–2'),
      );
    });

    test('when adding a second open-ended group '
        'then it is rejected as overlapping', () async {
      await expectLater(
        endpoints.ageGroup.add(
          sessionBuilder,
          AgeGroup(name: 'Senior', minAge: 65),
        ),
        throwsValidation(ValidationError.ageGroupOverlap, detail: 'Adult'),
      );
    });

    test('when lowering the minimum age of a group '
        'then it does not overlap itself', () async {
      final updated = await endpoints.ageGroup.update(
        sessionBuilder,
        adult.copyWith(minAge: 16),
      );

      expect(updated.minAge, 16);
    });

    test('when adding a group whose maximum is below its minimum '
        'then it is rejected', () async {
      await expectLater(
        endpoints.ageGroup.add(
          sessionBuilder,
          AgeGroup(name: 'Backwards', minAge: 10, maxAge: 5),
        ),
        throwsValidation(ValidationError.invalidAgeRange),
      );
    });

    test('when deleting a group that a fee is limited to '
        'then it is rejected as in use', () async {
      await endpoints.fee.add(
        sessionBuilder,
        Fee(
          name: 'Crib',
          amount: 500,
          unit: FeeUnit.perPersonNight,
          ageGroupId: toddler.id,
        ),
      );

      await expectLater(
        endpoints.ageGroup.delete(sessionBuilder, toddler.id!),
        throwsValidation(ValidationError.inUse),
      );
    });
  });
}
