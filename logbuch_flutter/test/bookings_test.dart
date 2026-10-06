import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/panels/bookings/booking_editor.dart';
import 'package:logbuch_flutter/panels/bookings_panel.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';

import 'fake_client.dart';

void main() {
  group('booking details', () {
    testWidgets('show the booking with its lead', (tester) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      expect(find.text('Class trip'), findsOneWidget);
      expect(find.text('Oct 12, 2026 – Oct 16, 2026'), findsOneWidget);
      expect(find.text('Marie Weber'), findsOneWidget);
      expect(find.text('marie.weber@example.com'), findsOneWidget);
      expect(find.text('One invoice for the booking'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('say when a booking is cancelled', (tester) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.last);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      expect(find.text('Cancelled'), findsOneWidget);
      expect(find.text('Confirmed'), findsNothing);
    });

    testWidgets('let the booking take the rooms that are free', (
      tester,
    ) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      await tester.tap(find.text('Rooms'));
      await tester.pumpAndSettle();

      expect(find.text('Room 101'), findsOneWidget);
      expect(find.text('Room 103'), findsOneWidget);
      // Room 102 is neither free nor held by the booking.
      expect(find.text('Room 102'), findsNothing);
      expect(find.text('4 beds selected · 5 guests expected'), findsOneWidget);
      FilledButton save() =>
          tester.widget(find.widgetWithText(FilledButton, 'Save'));
      expect(save().onPressed, isNull);

      await tester.tap(find.text('Room 103'));
      await tester.pump();
      expect(find.text('6 beds selected · 5 guests expected'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();

      final saved = client.booking.bookings.first;
      // Only rooms known to the fake are kept, which leaves out room 103.
      expect(saved.rooms!.map((r) => r.roomId), [1]);
      expect(find.text('Rooms saved'), findsOneWidget);
    });

    testWidgets('ask for dates before rooms can be chosen', (tester) async {
      final client = filledClient();
      final undated = client.booking.bookings.first.copyWith(
        arrival: null,
        departure: null,
      );
      await pumpApp(
        tester,
        BookingDetails(tab: BookingTab(booking: undated)),
        client,
      );

      await tester.tap(find.text('Rooms'));
      await tester.pumpAndSettle();

      expect(
        find.text('Set the dates of the booking to choose its rooms.'),
        findsOneWidget,
      );
    });
  });

  testWidgets('the editor keeps the days of a booking it saves', (
    tester,
  ) async {
    final client = filledClient();
    final booking = client.booking.bookings.first;
    final tab = BookingTab(booking: booking, editing: true);
    await pumpApp(tester, BookingEditor(tab: tab), client);

    await tester.enterText(field('Title'), 'Class trip 7b');
    await tester.enterText(field('Expected guests'), '24');
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Save'));
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = client.booking.updated.single;
    expect(saved.id, booking.id);
    expect(saved.title, 'Class trip 7b');
    expect(saved.arrival, DateTime.utc(2026, 10, 12));
    expect(saved.departure, DateTime.utc(2026, 10, 16));
    expect(saved.leadId, 1);
    expect(saved.status, BookingStatus.confirmed);
    expect(saved.billingMode, BillingMode.single);
    expect(saved.expectedGuestCount, 24);
    expect(saved.optionExpiresAt, isNull);
  });

  group('bookings panel', () {
    testWidgets('lists the bookings with their lead', (tester) async {
      await pumpApp(tester, const BookingsPanel(), filledClient());
      final panel = ProviderScope.containerOf(
        tester.element(find.byType(BookingsPanel)),
      );
      panel.read(selectedBookingsViewProvider.notifier).select(.month);
      panel.read(displayedMonthProvider.notifier).show(DateTime(2026, 10));
      await tester.pumpAndSettle();

      expect(find.text('Class trip'), findsWidgets);
      expect(find.text('New booking'), findsOneWidget);
    });

    testWidgets('shows which booking holds which room', (tester) async {
      await pumpApp(tester, const BookingsPanel(), filledClient());
      final panel = ProviderScope.containerOf(
        tester.element(find.byType(BookingsPanel)),
      );
      panel.read(displayedMonthProvider.notifier).show(DateTime(2026, 10));

      await tester.tap(find.text('Occupancy'));
      await tester.pumpAndSettle();

      expect(find.text('Room 101'), findsOneWidget);
      // Room 102 is inactive and not held, so it has no row.
      expect(find.text('Room 102'), findsNothing);
      expect(find.text('Class trip'), findsOneWidget);
      expect(find.text('Choir weekend'), findsOneWidget);
      expect(find.text('Called off'), findsNothing);

      // The class trip leaves on the day the choir arrives, so their bars
      // meet in the middle of that day without overlapping.
      final trip = tester.getRect(
        find
            .ancestor(
              of: find.text('Class trip'),
              matching: find.byType(Material),
            )
            .first,
      );
      final choir = tester.getRect(
        find
            .ancestor(
              of: find.text('Choir weekend'),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(trip.right, choir.left);
      expect(trip.width, 4 * 36);
      expect(choir.width, 2 * 36);
    });
  });
}
