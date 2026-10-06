import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a household of two contacts', (sessionBuilder, endpoints) {
    late Contact marie;
    late Contact jonas;
    late Contact felix;
    late Household webers;

    List<String> memberNames(Household household) => [
      for (final member in household.members!) member.contact!.firstName,
    ];

    Future<Booking> addBooking(String title) => endpoints.booking.add(
      sessionBuilder,
      Booking(
        title: title,
        arrival: DateTime.utc(2027, 5, 10),
        departure: DateTime.utc(2027, 5, 13),
        leadId: marie.id!,
      ),
    );

    Future<List<String>> guestNames(Booking booking, String groupName) async {
      final groups = await endpoints.guest.getByBooking(
        sessionBuilder,
        booking.id!,
      );
      return [
        for (final group in groups.where((g) => g.name == groupName))
          for (final guest in group.guests!) guest.contact!.firstName,
      ];
    }

    setUp(() async {
      Future<Contact> contact(String firstName, String lastName) =>
          endpoints.contact.add(
            sessionBuilder,
            Contact(firstName: firstName, lastName: lastName),
          );
      marie = await contact('Marie', 'Weber');
      jonas = await contact('Jonas', 'Weber');
      felix = await contact('Felix', 'Wagner');
      webers = await endpoints.household.save(
        sessionBuilder,
        Household(name: ' Familie Weber '),
        [marie.id!, jonas.id!],
      );
    });

    test('when listing the households '
        'then it comes with its members', () async {
      final households = await endpoints.household.getAll(
        sessionBuilder.asViewer,
      );

      expect(households.single.name, 'Familie Weber');
      expect(memberNames(households.single), ['Marie', 'Jonas']);
    });

    test('when saving it with other members '
        'then those replace the ones that are left out', () async {
      final saved = await endpoints.household.save(
        sessionBuilder,
        webers.copyWith(name: 'Weber und Wagner'),
        [jonas.id!, felix.id!],
      );

      expect(saved.id, webers.id);
      expect(saved.name, 'Weber und Wagner');
      expect(memberNames(saved), ['Jonas', 'Felix']);
      // Jonas stayed a member and was not added anew.
      expect(
        saved.members!.first.id,
        webers.members!.firstWhere((m) => m.contactId == jonas.id).id,
      );
    });

    test('when saving a household without a name '
        'then it is rejected', () async {
      await expectLater(
        endpoints.household.save(sessionBuilder, Household(name: ' '), []),
        throwsValidation(ValidationError.nameRequired),
      );
    });

    test('when deleting it '
        'then its members stay as contacts', () async {
      await endpoints.household.delete(sessionBuilder, webers.id!);

      expect(await endpoints.household.getAll(sessionBuilder), isEmpty);
      expect(await endpoints.contact.getAll(sessionBuilder), hasLength(3));
    });

    test('when deleting one of its contacts '
        'then the household goes on without that member', () async {
      await endpoints.contact.delete(sessionBuilder, jonas.id!);

      final households = await endpoints.household.getAll(sessionBuilder);
      expect(memberNames(households.single), ['Marie']);
    });

    test('when adding it to a booking '
        'then its members are the guests of a group with its name', () async {
      final booking = await addBooking('Spring days');

      final group = await endpoints.guest.addHousehold(
        sessionBuilder,
        booking.id!,
        webers.id!,
      );

      expect(group.name, 'Familie Weber');
      expect(await guestNames(booking, 'Familie Weber'), ['Marie', 'Jonas']);
    });

    test('when one of its members is a guest of the booking already '
        'then only the others are added', () async {
      final booking = await addBooking('Spring days');
      final friends = await endpoints.guest.addGroup(
        sessionBuilder,
        GuestGroup(bookingId: booking.id!, name: 'Friends'),
      );
      await endpoints.guest.addGuest(
        sessionBuilder,
        Guest(groupId: friends.id!, contactId: marie.id!),
      );

      await endpoints.guest.addHousehold(
        sessionBuilder,
        booking.id!,
        webers.id!,
      );

      expect(await guestNames(booking, 'Familie Weber'), ['Jonas']);
    });

    test('when adding it to a booking twice '
        'then the second time is rejected and adds no group', () async {
      final booking = await addBooking('Spring days');
      await endpoints.guest.addHousehold(
        sessionBuilder,
        booking.id!,
        webers.id!,
      );

      await expectLater(
        endpoints.guest.addHousehold(sessionBuilder, booking.id!, webers.id!),
        throwsValidation(ValidationError.alreadyGuest),
      );
      final groups = await endpoints.guest.getByBooking(
        sessionBuilder,
        booking.id!,
      );
      expect(groups, hasLength(1));
    });

    test('when a viewer changes households '
        'then it is rejected', () async {
      final viewer = sessionBuilder.asViewer;
      final rejected = throwsValidation(ValidationError.adminRequired);

      await expectLater(
        endpoints.household.save(viewer, Household(name: 'X'), []),
        rejected,
      );
      await expectLater(
        endpoints.household.delete(viewer, webers.id!),
        rejected,
      );
      await expectLater(
        endpoints.guest.addHousehold(viewer, 1, webers.id!),
        rejected,
      );
    });
  });
}
