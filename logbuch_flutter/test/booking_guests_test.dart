import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/bookings/booking_assignment_tab.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';

import 'fake_client.dart';

/// Shows a tab of the details of the class trip, which holds room 101.
Future<void> _pumpTab(
  WidgetTester tester,
  FakeClient client,
  String tab,
) async {
  final booking = client.booking.bookings.first;
  await pumpApp(
    tester,
    BookingDetails(tab: BookingTab(booking: booking)),
    client,
  );
  await open(tester, tab);
}

void main() {
  group('roomFit', () {
    Room room({int beds = 2, bool crib = false}) => Room(
      roomNumber: '1',
      bedAmount: beds,
      priceCategoryId: 1,
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

  testWidgets('guests are listed in their groups', (tester) async {
    await _pumpTab(tester, filledClient(), 'Guests');

    expect(find.text('Weber family · 3 guests'), findsOneWidget);
    expect(find.text('Marie Weber'), findsOneWidget);
    expect(find.text('Age unknown'), findsOneWidget);
    expect(find.text('Mar 3, 2019 · No nuts'), findsOneWidget);
    expect(find.text('Child · Crib'), findsOneWidget);
  });

  testWidgets('a group and a guest who is not a contact yet are added', (
    tester,
  ) async {
    final client = filledClient();
    await _pumpTab(tester, client, 'Guests');

    await tester.tap(find.text('New group'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Name'), 'Wagner family');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Wagner family · 0 guests'), findsOneWidget);

    await tester.tap(find.byTooltip('Add guest').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('New contact'));
    await tester.pumpAndSettle();
    // Without a name the guest is not saved.
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a first or a last name'), findsOneWidget);

    await tester.enterText(field('First name'), 'Felix');
    await tester.enterText(field('Last name'), 'Wagner');
    await tester.enterText(field('Dietary needs'), 'Vegetarian');
    await tester.tap(find.text('Sleeps in a crib'));
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(client.guest.newContacts.single.firstName, 'Felix');
    final guest = client.guest.guests.last;
    expect(guest.groupId, client.guest.groups.last.id);
    expect(guest.needsCrib, isTrue);
    expect(guest.dietaryNotes, 'Vegetarian');
    expect(find.text('Wagner family · 1 guest'), findsOneWidget);
    expect(find.text('Felix Wagner'), findsOneWidget);
  });

  group('room assignment', () {
    testWidgets('shows who has a room and how the rooms fill up', (
      tester,
    ) async {
      await _pumpTab(tester, filledClient(), 'Assignment');

      expect(find.text('Without a room'), findsOneWidget);
      expect(find.text('Weber family (2)'), findsOneWidget);
      expect(find.text('Room 101'), findsOneWidget);
      expect(find.text('1 of 4 beds · Crib possible'), findsOneWidget);
      expect(find.text('3 free beds'), findsOneWidget);
    });

    testWidgets('moves a guest with the menu', (tester) async {
      final client = filledClient();
      await _pumpTab(tester, client, 'Assignment');

      await tester.tap(find.text('Jonas Weber'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Room 101').last);
      await tester.pumpAndSettle();

      expect(client.guest.guests[1].bookingRoomId, 11);
      expect(find.text('2 of 4 beds · Crib possible'), findsOneWidget);
      expect(find.text('Weber family (1)'), findsOneWidget);

      await tester.tap(find.text('Marie Weber'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Without a room').last);
      await tester.pumpAndSettle();

      expect(client.guest.guests[0].bookingRoomId, isNull);
      expect(find.text('Weber family (2)'), findsOneWidget);
    });

    testWidgets('moves a whole group by dragging its name onto a room', (
      tester,
    ) async {
      final client = filledClient();
      await _pumpTab(tester, client, 'Assignment');

      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Weber family (2)')),
      );
      await tester.pump();
      final room = tester.getCenter(find.text('Room 101'));
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
      expect(find.text('2 free beds'), findsOneWidget);
      expect(find.text('Everybody has a room.'), findsOneWidget);
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
      await _pumpTab(tester, client, 'Assignment');

      expect(find.text('More guests than beds'), findsOneWidget);
    });

    testWidgets('only shows the rooms to a viewer', (tester) async {
      await _pumpTab(
        tester,
        filledClient(role: UserRole.viewer),
        'Assignment',
      );

      await tester.tap(find.text('Jonas Weber'));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuItem<int>), findsNothing);
      expect(find.byType(Draggable<List<int>>), findsNothing);
    });
  });

  testWidgets('the price lists what every guest pays and what is missing', (
    tester,
  ) async {
    await _pumpTab(tester, filledClient(), 'Price');

    expect(find.text('Marie Weber'), findsOneWidget);
    expect(find.text('Lodging · Standard · Adult · Spring'), findsOneWidget);
    expect(find.text('4 × €25.00'), findsOneWidget);
    expect(find.text('€100.00'), findsNWidgets(2));
    expect(find.text('Whole booking'), findsOneWidget);
    expect(find.text('Fee · Final cleaning'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('€140.00'), findsOneWidget);
    expect(
      find.textContaining('Jonas Weber: the age is not known.'),
      findsOneWidget,
    );
    expect(
      find.textContaining('No season covers Oct 15, 2026.'),
      findsOneWidget,
    );
  });
}
