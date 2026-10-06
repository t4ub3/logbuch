import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a contact of an organization', (sessionBuilder, endpoints) {
    late Organization school;
    late Contact teacher;

    setUp(() async {
      school = await endpoints.organization.add(
        sessionBuilder,
        Organization(name: 'Lindenschule', city: 'Kassel'),
      );
      teacher = await endpoints.contact.add(
        sessionBuilder,
        Contact(
          firstName: ' Marie ',
          lastName: 'Weber',
          birthDate: DateTime.utc(1984, 5, 17),
          organizationId: school.id,
        ),
      );
    });

    test(
      'when listing the contacts '
      'then they are sorted by name and come with their organization',
      () async {
        await endpoints.contact.add(
          sessionBuilder,
          Contact(firstName: 'Anna', lastName: 'Becker'),
        );

        final contacts = await endpoints.contact.getAll(sessionBuilder);
        expect(contacts.map((c) => c.lastName), ['Becker', 'Weber']);
        expect(contacts.last.firstName, 'Marie');
        expect(contacts.last.organization?.name, 'Lindenschule');
      },
    );

    test('when adding a contact with only a last name '
        'then it is stored', () async {
      final guest = await endpoints.contact.add(
        sessionBuilder,
        Contact(firstName: '', lastName: 'Schmidt'),
      );

      expect(guest.id, isNotNull);
    });

    test('when adding a contact without any name '
        'then it is rejected', () async {
      await expectLater(
        endpoints.contact.add(
          sessionBuilder,
          Contact(firstName: ' ', lastName: ''),
        ),
        throwsValidation(ValidationError.nameRequired),
      );
    });

    test('when storing a birth date with a time of day '
        'then it is rejected', () async {
      await expectLater(
        endpoints.contact.update(
          sessionBuilder,
          teacher.copyWith(birthDate: DateTime.utc(1984, 5, 16, 22)),
        ),
        throwsValidation(ValidationError.invalidDate),
      );
    });

    test('when deleting the organization '
        'then the contact stays without an organization', () async {
      await endpoints.organization.delete(sessionBuilder, school.id!);

      final fetched = await endpoints.contact.getById(
        sessionBuilder,
        teacher.id!,
      );
      expect(fetched?.lastName, 'Weber');
      expect(fetched?.organizationId, isNull);
    });

    test('when the organization has a booking '
        'then it cannot be deleted', () async {
      await endpoints.booking.add(
        sessionBuilder,
        Booking(
          title: 'Class trip',
          leadId: teacher.id!,
          organizationId: school.id,
        ),
      );

      await expectLater(
        endpoints.organization.delete(sessionBuilder, school.id!),
        throwsValidation(ValidationError.inUse),
      );
    });

    test('when deleting a contact that leads no booking '
        'then it is gone', () async {
      await endpoints.contact.delete(sessionBuilder, teacher.id!);

      expect(await endpoints.contact.getAll(sessionBuilder), isEmpty);
    });
  });
}
