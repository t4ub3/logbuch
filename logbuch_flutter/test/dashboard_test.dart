import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/dashboard_panel.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';

import 'fake_client.dart';

void main() {
  testWidgets('the dashboard shows the days ahead and what needs attention', (
    tester,
  ) async {
    // Those who only look can see all of it.
    await pumpApp(
      tester,
      const DashboardPanel(),
      filledClient(role: UserRole.viewer),
      size: const Size(1200, 1400),
    );

    expect(find.text('Arrivals in the next 7 days'), findsOneWidget);
    expect(
      find.text('Mon, Oct 12 · Marie Weber · 3 guests · 1 room · Confirmed'),
      findsOneWidget,
    );
    // An option without guests or rooms so far.
    expect(find.text('Fri, Oct 16 · Marie Weber · Option'), findsOneWidget);
    expect(find.text('Departures in the next 7 days'), findsOneWidget);
    expect(
      find.text('Fri, Oct 16 · Marie Weber · 3 guests · 1 room · Confirmed'),
      findsOneWidget,
    );

    expect(find.text('1 of 4 rooms occupied'), findsOneWidget);
    expect(find.text('3 guests in the house'), findsOneWidget);

    expect(find.text('Expired on Sat, Oct 10'), findsOneWidget);
    expect(find.text('Expires on Tue, Oct 20'), findsOneWidget);

    expect(
      find.text('2026-0007 · Marie Weber · Class trip'),
      findsOneWidget,
    );
    expect(find.text('€140.00'), findsOneWidget);

    expect(find.text('Today · Mon, Oct 12'), findsOneWidget);
    expect(find.text('3 guests · 2 Child · 1 Adult'), findsOneWidget);
    expect(
      find.text('Full board · 3 guests · 2 Child · 1 Adult'),
      findsOneWidget,
    );
    expect(find.text('Tomorrow · Tue, Oct 13'), findsOneWidget);
    expect(find.text('No guests.'), findsOneWidget);
  });

  testWidgets('a quiet day says so in every section', (tester) async {
    await pumpApp(
      tester,
      const DashboardPanel(),
      FakeClient(),
      size: const Size(1200, 1400),
    );

    expect(find.text('Nobody arrives in the next 7 days.'), findsOneWidget);
    expect(find.text('Nobody departs in the next 7 days.'), findsOneWidget);
    expect(find.text('0 of 0 rooms occupied'), findsOneWidget);
    expect(find.text('No guests in the house'), findsOneWidget);
    expect(find.text('No option expires in the next 14 days.'), findsOneWidget);
    expect(find.text('No invoice is waiting for payment.'), findsOneWidget);
    expect(find.text('No guests.'), findsNWidgets(2));
  });

  testWidgets('everything fits a narrow window', (tester) async {
    await pumpApp(
      tester,
      const DashboardPanel(),
      filledClient(),
      size: const Size(420, 700),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Arrivals in the next 7 days'), findsOneWidget);
  });

  testWidgets('tapping a stay opens its booking', (tester) async {
    await pumpApp(
      tester,
      const DashboardPanel(),
      filledClient(),
      size: const Size(1200, 1400),
    );
    final tabs = ProviderScope.containerOf(
      tester.element(find.byType(DashboardPanel)),
    );

    await tester.tap(
      find.text('Mon, Oct 12 · Marie Weber · 3 guests · 1 room · Confirmed'),
    );
    await tester.pumpAndSettle();

    final open = tabs.read(tabsProvider).tabs.whereType<BookingTab>();
    expect(open.single.booking?.title, 'Class trip');
  });
}
