import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/open_file.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/panels/bookings/booking_form.dart';
import 'package:logbuch_flutter/panels/bookings_panel.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

import 'fake_client.dart';

/// Shows the booking tab that is open the way the main screen does, so that
/// the page follows what is saved.
class _OpenTab extends ConsumerWidget {
  const _OpenTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref
        .watch(tabsProvider)
        .tabs
        .whereType<BookingTab>()
        .firstOrNull;
    return switch (tab) {
      null => const SizedBox.shrink(),
      BookingTab(booking: null) => NewBookingForm(tab: tab),
      BookingTab() => BookingDetails(tab: tab),
    };
  }
}

/// Opens a tab with [booking], or with the form for a new one.
Future<void> _openTab(
  WidgetTester tester,
  FakeClient client, [
  Booking? booking,
]) async {
  await pumpApp(tester, const _OpenTab(), client);
  ProviderScope.containerOf(
    tester.element(find.byType(_OpenTab)),
  ).read(tabsProvider.notifier).openBooking(booking);
  await tester.pumpAndSettle();
}

void main() {
  group('booking details', () {
    testWidgets('show the booking with its lead', (tester) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      expect(find.text('Class trip'), findsOneWidget);
      expect(find.text('Oct 12, 2026 – Oct 16, 2026'), findsOneWidget);
      expect(inCard('Overview', find.text('Marie Weber')), findsOneWidget);
      expect(find.text('marie.weber@example.com'), findsOneWidget);
      expect(find.text('One invoice for the booking'), findsOneWidget);
    });

    testWidgets('only show the booking, with a button per card to change it', (
      tester,
    ) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      for (final title in ['Overview', 'Rooms', 'Guests', 'Assignment']) {
        expect(inCard(title, find.byTooltip('Edit')), findsOneWidget);
      }
      expect(inCard('Billing', find.byTooltip('Edit')), findsOneWidget);
      // What the kitchen needs and the price follow from the rest.
      expect(inCard('Kitchen', find.byTooltip('Edit')), findsNothing);
      expect(inCard('Price', find.byTooltip('Edit')), findsNothing);

      // Nothing on the page itself is saved or changed.
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byType(Checkbox), findsNothing);
      expect(find.byType(Draggable<List<int>>), findsNothing);
      expect(find.byTooltip('Delete'), findsNothing);
    });

    testWidgets('put the cards in two columns where there is room for them', (
      tester,
    ) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.first);
      Offset at(String title) => tester.getTopLeft(card(title));
      double width(String title) => tester.getSize(card(title)).width;

      await pumpApp(tester, BookingDetails(tab: tab), client);
      // The overview is as wide as both columns.
      expect(at('Rooms').dy, greaterThan(at('Overview').dy));
      expect(at('Guests').dy, at('Rooms').dy);
      expect(at('Guests').dx, greaterThan(at('Rooms').dx));
      expect(width('Guests'), width('Rooms'));
      expect(
        tester.getTopRight(card('Guests')).dx,
        tester.getTopRight(card('Overview')).dx,
      );
      expect(at('Assignment').dx, at('Rooms').dx);
      expect(at('Kitchen').dx, at('Guests').dx);

      await pumpApp(
        tester,
        BookingDetails(tab: tab),
        client,
        size: const Size(700, 800),
      );
      // Too narrow for two columns, so the cards are below each other.
      var below = at('Overview').dy;
      for (final title in [
        'Rooms',
        'Guests',
        'Assignment',
        'Kitchen',
        'Price',
        'Billing',
      ]) {
        expect(at(title).dx, at('Overview').dx, reason: title);
        expect(width(title), width('Overview'), reason: title);
        expect(at(title).dy, greaterThan(below), reason: title);
        below = at(title).dy;
      }
    });

    testWidgets('open the confirmation of a confirmed booking as a PDF', (
      tester,
    ) async {
      final opened = <String, Uint8List>{};
      final client = filledClient(role: UserRole.viewer);
      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(
        tester,
        BookingDetails(tab: tab),
        client,
        overrides: [
          fileOpenerProvider.overrideWithValue(
            (name, bytes) async => opened[name] = bytes,
          ),
        ],
      );

      await tester.tap(find.text('Confirmation'));
      await tester.pumpAndSettle();

      expect(opened.keys.single, 'Buchungsbestaetigung-1.pdf');
      expect(String.fromCharCodes(opened.values.single), '%PDF-confirmation');
    });

    testWidgets('offer no confirmation for a cancelled or undated booking', (
      tester,
    ) async {
      final client = filledClient();
      final cancelled = client.booking.bookings.last;
      await pumpApp(
        tester,
        BookingDetails(tab: BookingTab(booking: cancelled)),
        client,
      );
      expect(find.text('Confirmation'), findsNothing);

      final undated = client.booking.bookings.first.copyWith(
        arrival: null,
        departure: null,
      );
      await pumpApp(
        tester,
        BookingDetails(tab: BookingTab(booking: undated)),
        client,
      );
      expect(find.text('Confirmation'), findsNothing);
    });

    testWidgets('say when a booking is cancelled', (tester) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.last);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      expect(find.text('Cancelled'), findsOneWidget);
      expect(find.text('Confirmed'), findsNothing);
    });

    testWidgets('list the rooms the booking holds', (tester) async {
      final client = filledClient();
      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(tester, BookingDetails(tab: tab), client);

      expect(inCard('Rooms', find.text('Room 101')), findsOneWidget);
      expect(
        inCard('Rooms', find.text('4 beds in 1 room · 5 guests expected')),
        findsOneWidget,
      );
      expect(
        inCard('Rooms', find.textContaining('4 beds · ')),
        findsOneWidget,
      );
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

      expect(
        find.text('Set the dates of the booking to choose its rooms.'),
        findsOneWidget,
      );
      expect(inCard('Rooms', find.byTooltip('Edit')), findsNothing);
    });
  });

  group('the overlay of the rooms', () {
    testWidgets('lets the booking take the rooms that are free', (
      tester,
    ) async {
      final client = filledClient();
      await _openTab(tester, client, client.booking.bookings.first);

      await editCard(tester, 'Rooms');

      expect(inOverlay(find.text('Room 101')), findsOneWidget);
      expect(inOverlay(find.text('Room 103')), findsOneWidget);
      // Room 102 is neither free nor held by the booking.
      expect(find.text('Room 102'), findsNothing);
      expect(find.text('4 beds selected · 5 guests expected'), findsOneWidget);
      ElevatedButton save() =>
          tester.widget(find.widgetWithText(ElevatedButton, 'Save'));
      expect(save().onPressed, isNull);

      await tester.tap(inOverlay(find.text('Room 103')));
      await tester.pump();
      expect(find.text('6 beds selected · 5 guests expected'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      // Only rooms known to the fake are kept, which leaves out room 103.
      expect(client.booking.bookings.first.rooms!.map((r) => r.roomId), [1]);
      expect(find.byType(BookingOverlay), findsNothing);
      expect(inCard('Rooms', find.text('Room 101')), findsOneWidget);
    });

    testWidgets('leaves the page showing the rooms as they were saved', (
      tester,
    ) async {
      final client = filledClient();
      await _openTab(tester, client, client.booking.bookings.first);

      await editCard(tester, 'Rooms');
      await tester.tap(inOverlay(find.text('Room 101')));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(client.booking.bookings.first.rooms, isEmpty);
      expect(find.text('Room 101'), findsNothing);
      // Without rooms there is nobody to put into them either.
      expect(
        inCard('Rooms', find.text('The booking holds no rooms yet.')),
        findsOneWidget,
      );
      expect(
        inCard('Assignment', find.text('The booking holds no rooms yet.')),
        findsOneWidget,
      );
      expect(inCard('Assignment', find.byTooltip('Edit')), findsNothing);
    });

    testWidgets('changes nothing when it is cancelled', (tester) async {
      final client = filledClient();
      await _openTab(tester, client, client.booking.bookings.first);

      await editCard(tester, 'Rooms');
      await tester.tap(inOverlay(find.text('Room 101')));
      await tester.pump();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(client.booking.bookings.first.rooms!.map((r) => r.roomId), [1]);
      expect(find.byType(BookingOverlay), findsNothing);
      expect(inCard('Rooms', find.text('Room 101')), findsOneWidget);
    });
  });

  group('the overlay of the overview', () {
    testWidgets('keeps the days of a booking it saves', (tester) async {
      final client = filledClient();
      final booking = client.booking.bookings.first;
      await _openTab(tester, client, booking);

      await editCard(tester, 'Overview');
      expect(find.text('Edit booking'), findsOneWidget);
      await tester.enterText(field('Title'), 'Class trip 7b');
      await tester.enterText(field('Expected guests'), '24');
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
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

      // The overlay is gone and the page shows the booking as it was saved.
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Class trip 7b'), findsOneWidget);
      expect(inCard('Overview', find.text('24')), findsOneWidget);
    });

    testWidgets('leaves the booking alone when it is cancelled', (
      tester,
    ) async {
      final client = filledClient();
      await _openTab(tester, client, client.booking.bookings.first);

      await editCard(tester, 'Overview');
      await tester.enterText(field('Title'), 'Something else');
      await tester.ensureVisible(find.text('Cancel'));
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(client.booking.updated, isEmpty);
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Class trip'), findsOneWidget);
    });
  });

  testWidgets('a new booking is created in its tab, which then shows it', (
    tester,
  ) async {
    final client = filledClient();
    await _openTab(tester, client);
    expect(find.text('New booking'), findsOneWidget);

    // A booking needs a title and a lead.
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsNWidgets(2));
    expect(client.booking.added, isEmpty);

    await tester.enterText(field('Title'), 'Retreat');
    await tester.tap(find.byType(DropdownMenu<Contact>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marie Weber').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final added = client.booking.added.single;
    expect(added.title, 'Retreat');
    expect(added.leadId, 1);
    expect(added.status, BookingStatus.inquiry);
    expect(added.arrival, isNull);
    expect(find.byType(BookingDetails), findsOneWidget);
    expect(find.text('Retreat'), findsOneWidget);
  });

  testWidgets('a booking gets a category, which can be created on the way', (
    tester,
  ) async {
    final client = filledClient();
    await _openTab(tester, client);

    await tester.enterText(field('Title'), 'Choir');
    await tester.tap(find.byType(DropdownMenu<Contact>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marie Weber').last);
    await tester.pumpAndSettle();

    // The categories that are there can be chosen.
    await tester.tap(find.byType(DropdownButtonFormField<int?>).first);
    await tester.pumpAndSettle();
    expect(find.text('School'), findsWidgets);
    await tester.tap(find.text('School').last);
    await tester.pumpAndSettle();

    // A new one needs a name and comes with an icon and a color.
    await tester.tap(find.byTooltip('New category'));
    await tester.pumpAndSettle();
    expect(find.text('New booking category'), findsOneWidget);
    await tester.enterText(field('Name'), 'Music');
    await tester.tap(find.byIcon(YaruIcons.music_note));
    await tester.tap(find.byType(YaruColorDisk).at(7));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save').last);
    await tester.pumpAndSettle();

    final music = client.bookingCategory.categories.last;
    expect(music.name, 'Music');
    expect(music.icon, BookingCategoryIcon.music);
    expect(music.color, BookingCategoryColor.purple);
    // The form has it chosen.
    expect(find.text('Music'), findsOneWidget);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(client.booking.added.single.categoryId, music.id);
  });

  testWidgets('a booking has the icon and color of its category', (
    tester,
  ) async {
    final client = filledClient();
    final bookings = client.booking.bookings;
    await pumpApp(
      tester,
      BookingDetails(tab: BookingTab(booking: bookings.first)),
      client,
    );

    expect(inCard('Overview', find.text('School')), findsOneWidget);
    expect(bookings.first.icon, YaruIcons.education);
    expect(bookings.first.color, YaruVariant.blue.color);
    // Without a category a booking is grey.
    expect(bookings.last.icon, YaruIcons.calendar);
    expect(bookings.last.color, const Color(0xFF8E8E8E));
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
