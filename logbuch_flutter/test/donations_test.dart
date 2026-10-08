import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/open_file.dart';
import 'package:logbuch_flutter/panels/admin_panel.dart';
import 'package:logbuch_flutter/panels/donations_panel.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';

import 'fake_client.dart';

void main() {
  // The panel opens on the current year, which the fake has donations for.
  final year = DateTime.now().year;

  testWidgets('the donations of the year are listed with their receipts', (
    tester,
  ) async {
    await pumpApp(tester, const DonationsPanel(), filledClient());

    expect(find.text('Donations $year'), findsOneWidget);
    expect(find.text('Mar 1, $year · Felix Wagner'), findsOneWidget);
    expect(
      find.text('Oct 16, $year · Marie Weber · Left over from a payment'),
      findsOneWidget,
    );
    expect(find.text('No receipt yet'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('€60.00'), findsOneWidget);
    // The receipt that was issued already, in the list and at its donation.
    expect(find.text('SB-$year-0001'), findsNWidgets(2));
    expect(
      find.text('Felix Wagner · €50.00 · Apr 1, $year'),
      findsOneWidget,
    );
  });

  testWidgets('other years are reached with the arrows', (tester) async {
    await pumpApp(tester, const DonationsPanel(), filledClient());

    await tester.tap(find.byTooltip('Previous year'));
    await tester.pumpAndSettle();

    expect(find.text('Donations ${year - 1}'), findsOneWidget);
    expect(find.text('No donations in ${year - 1}'), findsOneWidget);
  });

  testWidgets('receipts are created after a look at what they will cover', (
    tester,
  ) async {
    final client = filledClient();
    await pumpApp(tester, const DonationsPanel(), client);

    await tester.tap(find.text('Create receipts'));
    await tester.pumpAndSettle();
    expect(find.text('Receipts for $year'), findsOneWidget);
    expect(find.text('Marie Weber'), findsOneWidget);
    expect(find.text('1 donation'), findsOneWidget);
    expect(find.text('€10.00'), findsNWidgets(2));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Create receipts'));
    await tester.pumpAndSettle();

    expect(
      statusMessage(tester),
      isA<Done>().having((done) => done.text, 'text', '1 receipt created'),
    );
    expect(client.donation.receipts, hasLength(2));
    expect(find.text('SB-$year-0002'), findsOneWidget);
  });

  testWidgets('a donor without an address gets no receipt', (tester) async {
    final client = filledClient();
    client.donation.previews = [
      ReceiptPreview(
        contact: client.contact.contacts.first,
        donationCount: 2,
        total: 3000,
        addressComplete: false,
      ),
    ];
    await pumpApp(tester, const DonationsPanel(), client);

    await tester.tap(find.text('Create receipts'));
    await tester.pumpAndSettle();

    expect(
      find.text('No receipt: the address is incomplete'),
      findsOneWidget,
    );
    final create = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Create receipts'),
    );
    expect(create.onPressed, isNull);
  });

  testWidgets('a receipt is opened as a PDF named after its number', (
    tester,
  ) async {
    final opened = <String, Uint8List>{};
    await pumpApp(
      tester,
      const DonationsPanel(),
      filledClient(),
      overrides: [
        fileOpenerProvider.overrideWithValue(
          (name, bytes) async => opened[name] = bytes,
        ),
      ],
    );

    await tester.tap(find.byTooltip('Open the PDF'));
    await tester.pumpAndSettle();

    expect(opened.keys.single, 'SB-$year-0001.pdf');
    expect(String.fromCharCodes(opened.values.single), '%PDF-fake');
  });

  testWidgets('a donation is recorded for a donor', (tester) async {
    final client = filledClient();
    await pumpApp(tester, const DonationsPanel(), client);

    await tester.tap(find.text('New donation'));
    await tester.pumpAndSettle();
    // Without a donor and an amount nothing is saved.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsNWidgets(2));

    await tester.tap(find.text('Donor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marie Weber').last);
    await tester.pumpAndSettle();
    await tester.enterText(field('Amount'), '25');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final donation = client.donation.donations.last;
    expect(donation.contactId, 1);
    expect(donation.amount, 2500);
    expect(donation.source, DonationSource.direct);
    expect(donation.date.isUtc, isTrue);
    expect(donation.date.year, year);
  });

  testWidgets('a viewer sees donations and receipts but changes nothing', (
    tester,
  ) async {
    await pumpApp(
      tester,
      const DonationsPanel(),
      filledClient(role: UserRole.viewer),
    );

    expect(find.text('Mar 1, $year · Felix Wagner'), findsOneWidget);
    expect(find.byTooltip('Open the PDF'), findsOneWidget);
    expect(find.text('New donation'), findsNothing);
    expect(find.text('Create receipts'), findsNothing);
    expect(find.byTooltip('Delete'), findsNothing);
  });

  testWidgets('the details of the operator are saved for the receipts', (
    tester,
  ) async {
    final client = filledClient();
    await pumpApp(tester, const AdminPanel(), client);
    await open(tester, 'Organisation');
    await open(tester, 'Operator');

    // A notice by § 60a AO needs the purposes in a second wording, an
    // exemption notice its assessment period instead.
    expect(
      find.textContaining('Wir fördern nach unserer Satzung'),
      findsOneWidget,
    );
    expect(field('Assessment period of the notice'), findsNothing);

    await tester.enterText(field('Name'), 'Haus am See e. V.');
    await tester.enterText(field('Tax office'), 'Kassel');
    await tester.enterText(field('Place where receipts are signed'), 'Kassel');
    await tester.ensureVisible(field('IBAN'));
    await tester.enterText(field('IBAN'), ' DE02 5205 0353 0000 1234 56 ');
    await tester.enterText(
      field('Payment terms'),
      'Zahlbar innerhalb von 14 Tagen ohne Abzug.',
    );
    await tester.ensureVisible(field('Note on booking confirmations'));
    await tester.enterText(
      field('Note on booking confirmations'),
      'Anreise ab 15 Uhr.',
    );
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = client.operator.operator!;
    expect(saved.name, 'Haus am See e. V.');
    expect(saved.taxOffice, 'Kassel');
    expect(saved.place, 'Kassel');
    expect(saved.iban, 'DE02 5205 0353 0000 1234 56');
    expect(saved.paymentTerms, 'Zahlbar innerhalb von 14 Tagen ohne Abzug.');
    expect(saved.bic, isNull);
    expect(saved.confirmationNote, 'Anreise ab 15 Uhr.');
    expect(saved.noticeType, TaxNoticeType.statutoryCompliance);
    expect(saved.noticeDate, isNull);
    expect(statusMessage(tester), isA<Saved>());

    await tester.ensureVisible(
      find.text('Feststellungsbescheid nach § 60a AO'),
    );
    await tester.tap(find.text('Feststellungsbescheid nach § 60a AO'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Freistellungsbescheid').last);
    await tester.pumpAndSettle();

    expect(field('Assessment period of the notice'), findsOneWidget);
    expect(
      find.textContaining('Wir fördern nach unserer Satzung'),
      findsNothing,
    );
  });
}
