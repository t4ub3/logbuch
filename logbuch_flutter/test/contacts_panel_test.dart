import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
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
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
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
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
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

  group('the details of a contact', () {
    /// The text field inside the form field with the given label.
    TextField input(WidgetTester tester, String label) => tester.widget(
      find.descendant(of: field(label), matching: find.byType(TextField)),
    );

    testWidgets('are read-only until editing is chosen', (tester) async {
      final client = filledClient();
      await pumpApp(tester, const ContactsPanel(), client);

      await tester.tap(find.text('Marie Weber'));
      await tester.pumpAndSettle();

      // The overlay shows the contact under its name, with nothing to
      // change it.
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Marie Weber'), findsNWidgets(2));
      expect(find.text('Save'), findsNothing);
      expect(input(tester, 'First name').readOnly, isTrue);
      expect(input(tester, 'Email').readOnly, isTrue);
      expect(
        input(tester, 'Email').controller!.text,
        'marie.weber@example.com',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit'));
      await tester.pumpAndSettle();

      expect(find.text('Edit contact'), findsOneWidget);
      expect(input(tester, 'First name').readOnly, isFalse);
      await tester.enterText(field('Phone'), '+49 151 1234567');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      final saved = client.contact.contacts.firstWhere((c) => c.id == 1);
      expect(saved.phone, '+49 151 1234567');
      expect(saved.mail, 'marie.weber@example.com');
      expect(saved.organizationId, 1);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('return when editing is cancelled, as they are stored', (
      tester,
    ) async {
      final client = filledClient();
      final before = client.contact.contacts;
      await pumpApp(tester, const ContactsPanel(), client);

      await tester.tap(find.text('Marie Weber'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit'));
      await tester.pumpAndSettle();
      await tester.enterText(field('First name'), '');
      await tester.enterText(field('Last name'), '');
      await tester.enterText(field('Phone'), '+49 151 1234567');
      // Saving fails, as a contact needs a name.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.text('Enter a first or a last name'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // The overlay is still there and shows the contact again.
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Save'), findsNothing);
      expect(find.widgetWithText(ElevatedButton, 'Edit'), findsOneWidget);
      expect(input(tester, 'First name').readOnly, isTrue);
      expect(input(tester, 'First name').controller!.text, 'Marie');
      expect(input(tester, 'Last name').controller!.text, 'Weber');
      expect(input(tester, 'Phone').controller!.text, '');
      expect(find.text('Enter a first or a last name'), findsNothing);
      expect(client.contact.contacts, same(before));

      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('do not light up when a field is clicked', (tester) async {
      await pumpApp(tester, const ContactsPanel(), filledClient());
      await tester.tap(find.text('Marie Weber'));
      await tester.pumpAndSettle();

      bool hasFocus(String label) => tester
          .widget<EditableText>(
            find.descendant(
              of: field(label),
              matching: find.byType(EditableText),
            ),
          )
          .focusNode
          .hasFocus;

      for (final label in ['First name', 'Email', 'City', 'Notes']) {
        await tester.ensureVisible(field(label));
        await tester.tap(field(label));
        await tester.pump();
        expect(hasFocus(label), isFalse, reason: label);
      }

      // Once editing, a click puts the cursor into the field as usual.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(field('City'));
      await tester.tap(field('City'));
      await tester.pump();
      expect(hasFocus('City'), isTrue);
    });

    testWidgets('close without saving anything', (tester) async {
      final client = filledClient();
      final before = client.contact.contacts;
      await pumpApp(tester, const ContactsPanel(), client);

      await tester.tap(find.text('Marie Weber'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
      expect(client.contact.contacts, same(before));
    });

    testWidgets('open for editing right away from the pen in the list', (
      tester,
    ) async {
      await pumpApp(tester, const ContactsPanel(), filledClient());

      await tester.tap(find.byTooltip('Edit').first);
      await tester.pumpAndSettle();

      expect(find.text('Edit contact'), findsOneWidget);
      expect(input(tester, 'First name').readOnly, isFalse);
      expect(find.widgetWithText(ElevatedButton, 'Save'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Felix Wagner'), findsNWidgets(2));
      expect(input(tester, 'First name').readOnly, isTrue);
    });

    testWidgets('let the email address be copied, also by a viewer', (
      tester,
    ) async {
      String? copied;
      final messenger = tester.binding.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      });
      addTearDown(
        () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
      );

      await pumpApp(
        tester,
        const ContactsPanel(),
        filledClient(role: UserRole.viewer),
      );
      await tester.tap(find.text('Marie Weber'));
      await tester.pumpAndSettle();

      // A viewer gets the details, but no way to edit them.
      expect(find.widgetWithText(ElevatedButton, 'Edit'), findsNothing);
      expect(input(tester, 'Email').readOnly, isTrue);

      // One button each for the email address and the phone number.
      expect(find.byTooltip('Copy'), findsNWidgets(2));
      await tester.tap(find.byTooltip('Copy').first);
      await tester.pump();

      expect(copied, 'marie.weber@example.com');
      expect(find.byTooltip('Copied'), findsOneWidget);
      // Marie has no phone number, so there is nothing to copy there.
      final phone = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.copy),
      );
      expect(phone.onPressed, isNull);

      // The check mark turns back into the copy button after a moment.
      await tester.pump(const Duration(seconds: 3));
      expect(find.byTooltip('Copied'), findsNothing);
      expect(find.byTooltip('Copy'), findsNWidgets(2));
    });
  });

  testWidgets('organizations have a list of their own', (tester) async {
    await pumpApp(tester, const ContactsPanel(), filledClient());

    await tester.tap(find.text('Organizations'));
    await tester.pumpAndSettle();

    expect(find.text('Lindenschule'), findsOneWidget);
    expect(find.text('Kassel'), findsOneWidget);
    expect(find.text('New organization'), findsOneWidget);
  });

  testWidgets('a household is put together from contacts', (tester) async {
    final client = filledClient();
    await pumpApp(tester, const ContactsPanel(), client);

    await open(tester, 'Households');
    expect(find.text('Wagner household'), findsOneWidget);
    expect(find.text('Felix Wagner'), findsOneWidget);

    await tester.tap(find.text('New household'));
    await tester.pumpAndSettle();
    expect(find.text('No members yet'), findsOneWidget);
    await tester.enterText(field('Name'), 'Weber family');
    await tester.tap(find.text('Add a member'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marie Weber').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add a member'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Felix Wagner').last);
    await tester.pumpAndSettle();
    // Felix was added by mistake.
    await tester.tap(
      find.descendant(
        of: find.widgetWithText(InputChip, 'Felix Wagner'),
        matching: find.byTooltip('Delete'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = client.household.households.last;
    expect(saved.name, 'Weber family');
    expect(saved.members!.map((member) => member.contactId), [1]);
    expect(find.text('Weber family'), findsOneWidget);
    expect(find.text('Marie Weber'), findsOneWidget);
  });
}
