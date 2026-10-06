import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/admin_panel.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/panels/bookings_panel.dart';
import 'package:logbuch_flutter/panels/contacts_panel.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:logbuch_flutter/screens/role_gate.dart';

import 'fake_client.dart';

void main() {
  group('a viewer', () {
    testWidgets('sees the setup but cannot change it', (tester) async {
      await pumpApp(
        tester,
        const AdminPanel(),
        filledClient(role: UserRole.viewer),
      );

      expect(find.text('Room 101'), findsOneWidget);
      expect(find.text('New room'), findsNothing);
      expect(find.byTooltip('Edit'), findsNothing);
      expect(find.byTooltip('Delete'), findsNothing);
      expect(find.text('Users'), findsNothing);

      // Tapping a record does not open its form.
      await tester.tap(find.text('Room 101'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);

      await open(tester, 'Prices');
      expect(
        tester.widget<TextField>(find.byType(TextField).at(1)).enabled,
        isFalse,
      );
      expect(find.text('Save'), findsNothing);
    });

    testWidgets('sees contacts and bookings but cannot change them', (
      tester,
    ) async {
      final client = filledClient(role: UserRole.viewer);
      await pumpApp(tester, const ContactsPanel(), client);
      expect(find.text('Marie Weber'), findsOneWidget);
      expect(find.text('New contact'), findsNothing);

      await pumpApp(tester, const BookingsPanel(), client);
      expect(find.text('New booking'), findsNothing);

      final tab = BookingTab(booking: client.booking.bookings.first);
      await pumpApp(tester, BookingDetails(tab: tab), client);
      expect(find.text('Class trip'), findsOneWidget);
      expect(find.text('Edit'), findsNothing);
      await tester.tap(find.text('Rooms'));
      await tester.pumpAndSettle();
      expect(find.text('Room 101'), findsOneWidget);
      expect(find.text('Save'), findsNothing);
    });
  });

  testWidgets('an admin gives the users their roles', (tester) async {
    final client = filledClient();
    await pumpApp(tester, const AdminPanel(), client);

    await open(tester, 'Users');

    // Admins cannot change their own role.
    expect(find.text('me@example.com (you)'), findsOneWidget);
    expect(find.byType(DropdownMenu<String>), findsOneWidget);

    await tester.tap(find.byType(DropdownMenu<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View only').last);
    await tester.pumpAndSettle();

    expect(client.user.users.last.role, UserRole.viewer);
  });

  group('the role gate', () {
    testWidgets('keeps a user without a role waiting', (tester) async {
      await pumpApp(
        tester,
        const RoleGate(child: Text('The app')),
        filledClient(role: null),
      );

      expect(find.text('Waiting for access'), findsOneWidget);
      expect(find.textContaining('me@example.com'), findsOneWidget);
      expect(find.text('The app'), findsNothing);
    });

    testWidgets('lets a viewer in', (tester) async {
      await pumpApp(
        tester,
        const RoleGate(child: Text('The app')),
        filledClient(role: UserRole.viewer),
      );

      expect(find.text('The app'), findsOneWidget);
    });

    testWidgets('lets a user in once an admin gave them a role', (
      tester,
    ) async {
      final client = filledClient(role: null);
      await pumpApp(tester, const RoleGate(child: Text('The app')), client);

      await client.user.setRole(
        client.user.users.first.authUserId,
        UserRole.viewer,
      );
      await tester.tap(find.text('Check again'));
      await tester.pumpAndSettle();

      expect(find.text('The app'), findsOneWidget);
    });
  });
}
