import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/bookings/booking_assignment.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';

import 'fake_client.dart';

/// Shows the page of the class trip, which holds room 101. With [edit] the
/// overlay of the card with that title is opened as well.
Future<void> _pumpBooking(
  WidgetTester tester,
  FakeClient client, {
  String? edit,
}) async {
  final booking = client.booking.bookings.first;
  await pumpApp(
    tester,
    BookingDetails(tab: BookingTab(booking: booking)),
    client,
  );
  if (edit != null) await editCard(tester, edit);
}

void main() {
  group('roomFit', () {
    Room room({int beds = 2, bool crib = false}) => Room(
      roomNumber: '1',
      bedAmount: beds,
      unitTypeId: 1,
      cribPossible: crib,
    );
    List<Guest> guests(int inBeds, {int inCribs = 0}) => [
      for (var i = 0; i < inBeds + inCribs; i++)
        Guest(groupId: 1, contactId: 1, needsCrib: i >= inBeds),
    ];

    test('compares the guests in beds with the beds', () {
      expect(roomFit(room(), guests(0)), RoomFit.freeBeds);
      expect(roomFit(room(), guests(1)), RoomFit.freeBeds);
      expect(roomFit(room(), guests(2)), RoomFit.full);
      expect(roomFit(room(), guests(3)), RoomFit.overfull);
    });

    test('lets one guest sleep in a crib where one can be set up', () {
      expect(roomFit(room(crib: true), guests(2, inCribs: 1)), RoomFit.full);
      expect(roomFit(room(), guests(1, inCribs: 1)), RoomFit.noCrib);
      expect(roomFit(room(crib: true), guests(1, inCribs: 2)), RoomFit.noCrib);
    });

    test('reports too many guests before a missing crib', () {
      expect(roomFit(room(), guests(3, inCribs: 1)), RoomFit.overfull);
    });
  });

  group('the guests', () {
    testWidgets('are listed in their groups', (tester) async {
      await _pumpBooking(tester, filledClient());
      Finder guests(String text) => inCard('Guests', find.text(text));

      expect(guests('Weber family · 3 guests'), findsOneWidget);
      expect(guests('Marie Weber'), findsOneWidget);
      expect(guests('Age unknown'), findsOneWidget);
      expect(guests('Mar 3, 2019 · No nuts'), findsOneWidget);
      expect(guests('Child · Crib'), findsOneWidget);
    });

    testWidgets('get a group and a guest who is not a contact yet', (
      tester,
    ) async {
      final client = filledClient();
      await _pumpBooking(tester, client, edit: 'Guests');

      await tester.tap(find.text('New group'));
      await tester.pumpAndSettle();
      await tester.enterText(field('Name'), 'Wagner family');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();
      expect(inOverlay(find.text('Wagner family · 0 guests')), findsOneWidget);

      await tester.tap(find.byTooltip('Add guest').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('New contact'));
      await tester.pumpAndSettle();
      // Without a name the guest is not saved.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.text('Enter a first or a last name'), findsOneWidget);

      await tester.enterText(field('First name'), 'Felix');
      await tester.enterText(field('Last name'), 'Wagner');
      await tester.enterText(field('Dietary needs'), 'Vegetarian');
      await tester.tap(find.text('Sleeps in a crib'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(client.guest.newContacts.single.firstName, 'Felix');
      final guest = client.guest.guests.last;
      expect(guest.groupId, client.guest.groups.last.id);
      expect(guest.needsCrib, isTrue);
      expect(guest.dietaryNotes, 'Vegetarian');
      expect(inOverlay(find.text('Wagner family · 1 guest')), findsOneWidget);
      expect(inOverlay(find.text('Felix Wagner')), findsOneWidget);

      // The card shows the same once the overlay is closed.
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(BookingOverlay), findsNothing);
      expect(
        inCard('Guests', find.text('Wagner family · 1 guest')),
        findsOneWidget,
      );
      expect(inCard('Guests', find.text('Felix Wagner')), findsOneWidget);
    });

    testWidgets('get a household as a group', (tester) async {
      final client = filledClient();
      await _pumpBooking(tester, client, edit: 'Guests');

      await tester.tap(find.text('Add household'));
      await tester.pumpAndSettle();
      // The households to choose from, with their members.
      expect(find.text('Wagner household'), findsOneWidget);
      expect(find.text('Felix Wagner'), findsOneWidget);
      await tester.tap(find.text('Wagner household'));
      await tester.pumpAndSettle();

      expect(client.guest.addedHouseholds, [1]);
      expect(inOverlay(find.text('Household 1 · 0 guests')), findsOneWidget);
    });

    testWidgets('are shown to a viewer, who cannot change them', (
      tester,
    ) async {
      await _pumpBooking(tester, filledClient(role: UserRole.viewer));

      expect(
        inCard('Guests', find.text('Weber family · 3 guests')),
        findsOneWidget,
      );
      expect(find.byTooltip('Edit'), findsNothing);
      expect(find.text('Add household'), findsNothing);
      expect(find.text('New group'), findsNothing);
    });
  });

  testWidgets('what the other cards show is loaded again after a change', (
    tester,
  ) async {
    final client = filledClient();
    await _pumpBooking(tester, client, edit: 'Guests');
    expect(inCard('Price', find.text('€140.00')), findsOneWidget);
    expect(inCard('Kitchen', find.text('3')), findsOneWidget);

    // The server works both out from the guests, who changed meanwhile.
    client.pricing.price = client.pricing.price.copyWith(total: 21000);
    client.guest.kitchen = client.guest.kitchen.copyWith(guestCount: 4);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(inCard('Price', find.text('€210.00')), findsOneWidget);
    expect(inCard('Kitchen', find.text('4')), findsOneWidget);
  });

  group('room assignment', () {
    testWidgets('shows who has a room and how the rooms fill up', (
      tester,
    ) async {
      await _pumpBooking(tester, filledClient());
      Finder assignment(String text) => inCard('Assignment', find.text(text));

      expect(assignment('Without a room'), findsOneWidget);
      expect(assignment('Weber family (2)'), findsOneWidget);
      expect(assignment('Room 101'), findsOneWidget);
      expect(assignment('1 of 4 beds · Crib possible'), findsOneWidget);
      expect(assignment('3 free beds'), findsOneWidget);
    });

    testWidgets('moves a guest with the menu', (tester) async {
      final client = filledClient();
      await _pumpBooking(tester, client, edit: 'Assignment');

      await tester.tap(inOverlay(find.text('Jonas Weber')));
      await tester.pumpAndSettle();
      // The menu is above the overlay, which is above the page.
      await tester.tap(find.text('Room 101').last);
      await tester.pumpAndSettle();

      expect(client.guest.guests[1].bookingRoomId, 11);
      expect(
        inOverlay(find.text('2 of 4 beds · Crib possible')),
        findsOneWidget,
      );
      expect(inOverlay(find.text('Weber family (1)')), findsOneWidget);
      // The card below follows.
      expect(
        inCard('Assignment', find.text('2 of 4 beds · Crib possible')),
        findsOneWidget,
      );

      await tester.tap(inOverlay(find.text('Marie Weber')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Without a room').last);
      await tester.pumpAndSettle();

      expect(client.guest.guests[0].bookingRoomId, isNull);
      expect(inOverlay(find.text('Weber family (2)')), findsOneWidget);
    });

    testWidgets('moves a whole group by dragging its name onto a room', (
      tester,
    ) async {
      final client = filledClient();
      await _pumpBooking(tester, client, edit: 'Assignment');

      final gesture = await tester.startGesture(
        tester.getCenter(inOverlay(find.text('Weber family (2)'))),
      );
      await tester.pump();
      final room = tester.getCenter(inOverlay(find.text('Room 101')));
      await gesture.moveTo(room - const Offset(30, 0));
      await tester.pump();
      await gesture.moveTo(room);
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(client.guest.guests.map((guest) => guest.bookingRoomId), [
        11,
        11,
        11,
      ]);
      // The baby sleeps in the crib, so two of the four beds stay free.
      expect(inOverlay(find.text('2 free beds')), findsOneWidget);
      expect(inOverlay(find.text('Everybody has a room.')), findsOneWidget);
    });

    testWidgets('warns when a room has more guests than beds', (tester) async {
      final client = filledClient();
      final family = client.guest.groups.single;
      client.guest.groups = [
        family.copyWith(
          guests: [
            for (var i = 0; i < 5; i++)
              family.guests!.first.copyWith(id: 20 + i, bookingRoomId: 11),
          ],
        ),
      ];
      await _pumpBooking(tester, client);

      expect(
        inCard('Assignment', find.text('More guests than beds')),
        findsOneWidget,
      );
    });

    testWidgets('only shows the rooms to a viewer', (tester) async {
      await _pumpBooking(tester, filledClient(role: UserRole.viewer));

      final guest = inCard('Assignment', find.text('Jonas Weber'));
      await tester.ensureVisible(guest);
      await tester.tap(guest);
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuItem<int>), findsNothing);
      expect(find.byType(Draggable<List<int>>), findsNothing);
      expect(inCard('Assignment', find.byTooltip('Edit')), findsNothing);
    });
  });

  group('the kitchen overview', () {
    Finder kitchen(String text) => inCard('Kitchen', find.text(text));

    testWidgets('counts the guests by age group and lists dietary needs', (
      tester,
    ) async {
      // The kitchen works with a view-only account.
      await _pumpBooking(tester, filledClient(role: UserRole.viewer));

      expect(kitchen('Guests by age group'), findsOneWidget);
      // Both age groups with their ages and their number of guests.
      expect(kitchen('Child'), findsOneWidget);
      expect(kitchen('0 to 17 years'), findsOneWidget);
      expect(kitchen('2'), findsOneWidget);
      expect(kitchen('Adult'), findsOneWidget);
      expect(kitchen('18 years and older'), findsOneWidget);
      expect(kitchen('0'), findsOneWidget);
      expect(kitchen('Age unknown'), findsOneWidget);
      expect(kitchen('1'), findsOneWidget);
      expect(kitchen('Guests in total'), findsOneWidget);
      expect(kitchen('3'), findsOneWidget);

      // The class trip has no meal plan.
      expect(kitchen('None chosen'), findsOneWidget);
      expect(kitchen('No nuts'), findsOneWidget);
      expect(kitchen('Jonas Weber · Weber family · Child'), findsOneWidget);
    });

    testWidgets('names the meal plan and says when nobody has needs', (
      tester,
    ) async {
      final client = filledClient();
      client.booking.bookings = [
        client.booking.bookings.first.copyWith(
          mealPlanId: 1,
          mealPlan: client.mealPlan.plans.single,
        ),
      ];
      client.guest.kitchen = client.guest.kitchen.copyWith(
        unknownAge: 0,
        dietaryNeeds: [],
      );
      await _pumpBooking(tester, client);

      expect(kitchen('Full board'), findsOneWidget);
      expect(kitchen('Age unknown'), findsNothing);
      expect(
        kitchen('No dietary needs were noted for the guests.'),
        findsOneWidget,
      );
    });
  });

  testWidgets('the price lists what every guest pays and what is missing', (
    tester,
  ) async {
    await _pumpBooking(tester, filledClient());
    Finder price(Finder finder) => inCard('Price', finder);

    expect(price(find.text('Marie Weber')), findsOneWidget);
    expect(
      price(find.text('Lodging · Standard · Adult')),
      findsOneWidget,
    );
    expect(price(find.text('4 × €25.00')), findsOneWidget);
    expect(price(find.text('€100.00')), findsNWidgets(2));
    expect(price(find.text('Whole booking')), findsOneWidget);
    expect(price(find.text('Fee · Final cleaning')), findsOneWidget);
    expect(price(find.text('Total')), findsOneWidget);
    expect(price(find.text('€140.00')), findsOneWidget);
    expect(
      price(find.textContaining('Jonas Weber: the age is not known.')),
      findsOneWidget,
    );
    expect(
      price(find.textContaining('No price list is valid on Oct 15, 2026.')),
      findsOneWidget,
    );
  });
}
