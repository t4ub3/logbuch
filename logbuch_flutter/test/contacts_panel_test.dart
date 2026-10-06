import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_flutter/panels/contacts_panel.dart';

import 'fake_client.dart';

void main() {
  testWidgets('contacts are listed with their organization', (tester) async {
    await pumpApp(tester, const ContactsPanel(), filledClient());

    expect(find.text('Felix Wagner'), findsOneWidget);
    expect(find.text('Erfurt'), findsOneWidget);
    expect(find.text('Marie Weber'), findsOneWidget);
    expect(
      find.text('Lindenschule · marie.weber@example.com'),
      findsOneWidget,
    );
  });

  testWidgets('the search narrows the contacts down by every word', (
    tester,
  ) async {
    await pumpApp(tester, const ContactsPanel(), filledClient());

    await tester.enterText(find.byType(TextField), 'linden mar');
    await tester.pump();
    expect(find.text('Marie Weber'), findsOneWidget);
    expect(find.text('Felix Wagner'), findsNothing);

    await tester.enterText(find.byType(TextField), 'nobody');
    await tester.pump();
    expect(find.text('No matching contacts'), findsOneWidget);
  });

  testWidgets('a contact needs one name and is saved with its details', (
    tester,
  ) async {
    final client = filledClient();
    await pumpApp(tester, const ContactsPanel(), client);

    await tester.tap(find.text('New contact'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a first or a last name'), findsOneWidget);

    await tester.enterText(field('Last name'), ' Schmidt ');
    await tester.enterText(field('City'), 'Kassel');
    await tester.tap(find.text('Organization'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lindenschule').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.text('Consented to the storing of their data'),
    );
    await tester.tap(find.text('Consented to the storing of their data'));
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final contact = client.contact.contacts.last;
    expect(contact.firstName, '');
    expect(contact.lastName, 'Schmidt');
    expect(contact.city, 'Kassel');
    expect(contact.mail, isNull);
    expect(contact.organizationId, 1);
    expect(contact.privacyConsentAt, isNotNull);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('organizations have a list of their own', (tester) async {
    await pumpApp(tester, const ContactsPanel(), filledClient());

    await tester.tap(find.text('Organizations'));
    await tester.pumpAndSettle();

    expect(find.text('Lindenschule'), findsOneWidget);
    expect(find.text('Kassel'), findsOneWidget);
    expect(find.text('New organization'), findsOneWidget);
  });
}
