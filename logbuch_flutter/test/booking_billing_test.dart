import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';

import 'fake_client.dart';

/// Shows the billing of the class trip, whose lead owes 140 euros.
Future<void> _pumpBilling(WidgetTester tester, FakeClient client) async {
  final booking = client.booking.bookings.first;
  await pumpApp(
    tester,
    BookingDetails(tab: BookingTab(booking: booking)),
    client,
  );
  await open(tester, 'Billing');
}

/// Records a payment of [amount] euros with the dialog.
Future<void> _pay(WidgetTester tester, String amount) async {
  await tester.tap(find.text('Record payment'));
  await tester.pumpAndSettle();
  await tester.enterText(field('Amount'), amount);
  await tester.tap(find.widgetWithText(FilledButton, 'Save'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a folio shows what its payer is charged and still owes', (
    tester,
  ) async {
    await _pumpBilling(tester, filledClient());

    expect(find.text('Marie Weber'), findsOneWidget);
    expect(find.text('Not invoiced yet'), findsOneWidget);
    expect(find.text('Lodging · Standard · Adult · Spring'), findsOneWidget);
    expect(find.text('4 × €25.00'), findsOneWidget);
    expect(find.text('Fee · Final cleaning'), findsOneWidget);
    expect(find.text('Still to pay'), findsOneWidget);
    expect(find.text('€140.00'), findsOneWidget);
  });

  testWidgets('a payment is suggested with what is owed and settles it', (
    tester,
  ) async {
    final client = filledClient();
    await _pumpBilling(tester, client);

    await tester.tap(find.text('Record payment'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, '140.00'), findsOneWidget);
    await tester.enterText(field('Reference'), 'Invoice 12');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final payment = client.billing.folios.single.payments!.single;
    expect(payment.amount, 14000);
    expect(payment.payerId, 1);
    expect(payment.method, PaymentMethod.bankTransfer);
    expect(payment.reference, 'Invoice 12');
    expect(payment.date.isUtc, isTrue);
    expect(find.text('Paid in full'), findsOneWidget);
    // Nothing was overpaid, so nothing is asked.
    expect(find.byType(AlertDialog), findsNothing);
  });

  group('when more is paid than owed', () {
    testWidgets('the rest becomes a donation if that is chosen', (
      tester,
    ) async {
      final client = filledClient();
      await _pumpBilling(tester, client);

      await _pay(tester, '150');
      expect(find.text('€10.00 overpaid'), findsOneWidget);
      expect(find.textContaining('Marie Weber said'), findsOneWidget);
      await tester.tap(find.text('Record as donation'));
      await tester.pumpAndSettle();

      final payment = client.billing.folios.single.payments!.single;
      expect(payment.amount, 15000);
      expect(payment.donations!.single.amount, 1000);
      expect(find.text('Donation'), findsOneWidget);
      expect(find.text('Paid in full'), findsOneWidget);
    });

    testWidgets('the rest stays a credit unless something else is chosen', (
      tester,
    ) async {
      final client = filledClient();
      await _pumpBilling(tester, client);

      await _pay(tester, '150');
      await tester.tap(find.text('Keep as credit'));
      await tester.pumpAndSettle();

      expect(client.billing.folios.single.payments!.single.donations, isEmpty);
      expect(find.text('Overpaid'), findsOneWidget);
      expect(find.text('€10.00'), findsOneWidget);

      // The question can be answered later.
      await tester.tap(find.text('Decide'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Refund'));
      await tester.pumpAndSettle();

      final payments = client.billing.folios.single.payments!;
      expect(payments.map((payment) => payment.amount), [15000, -1000]);
      expect(find.text('Paid in full'), findsOneWidget);
    });
  });

  testWidgets('an invoiced folio shows its number and takes no more charges', (
    tester,
  ) async {
    await _pumpBilling(tester, filledClient());

    await tester.tap(find.text('Create invoice'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Create invoice'));
    await tester.pumpAndSettle();

    expect(find.text('Invoice 2026-0001 of Oct 16, 2026'), findsOneWidget);
    expect(find.text('Add charge'), findsNothing);
    expect(find.text('Create invoice'), findsNothing);
    expect(find.text('Record payment'), findsOneWidget);
  });

  testWidgets('charges and discounts are added by hand', (tester) async {
    final client = filledClient();
    await _pumpBilling(tester, client);

    await tester.tap(find.text('Add charge'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Description'), 'Sauna');
    await tester.enterText(field('Quantity'), '2');
    await tester.enterText(field('Price each'), '8');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    var charge = client.billing.folios.single.charges!.last;
    expect(charge.type, ChargeType.manual);
    expect(charge.quantity, 2);
    expect(charge.unitPrice, 800);
    expect(charge.taxRate, 700);
    expect(find.text('Other · Sauna'), findsOneWidget);
    expect(find.text('€156.00'), findsOneWidget);

    await tester.tap(find.text('Add charge'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Description'), 'Early bird');
    await tester.enterText(field('Price each'), '6,00');
    await tester.tap(find.text('This is a discount'));
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    charge = client.billing.folios.single.charges!.last;
    expect(charge.type, ChargeType.discount);
    expect(charge.unitPrice, -600);
    expect(find.text('€150.00'), findsOneWidget);
  });

  testWidgets('a viewer sees the folio without anything to change it', (
    tester,
  ) async {
    await _pumpBilling(tester, filledClient(role: UserRole.viewer));

    expect(find.text('Still to pay'), findsOneWidget);
    expect(find.text('Record payment'), findsNothing);
    expect(find.text('Create invoice'), findsNothing);
    expect(find.text('Add charge'), findsNothing);
    expect(find.byTooltip('Delete'), findsNothing);
  });

  testWidgets('a booking without charges has nothing to bill', (tester) async {
    final client = filledClient()..billing.folios = [];
    await _pumpBilling(tester, client);

    expect(find.textContaining('Nothing to bill yet.'), findsOneWidget);
  });
}
