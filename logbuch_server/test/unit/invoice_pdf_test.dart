import 'dart:convert';

import 'package:logbuch_server/src/billing/invoice_pdf.dart';
import 'package:logbuch_server/src/common/german_format.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'pdf_words.dart';

Charge _charge(int total, {int taxRate = 700, int quantity = 1}) => Charge(
  folioId: 1,
  type: ChargeType.lodging,
  description: 'Standard · Erwachsene · Sommer',
  quantity: quantity,
  unitPrice: total ~/ quantity,
  total: total,
  taxRate: taxRate,
);

void main() {
  group('taxShares', () {
    test('take the tax out of what was charged', () {
      expect(taxShares([_charge(15000)]), [
        (taxRate: 700, gross: 15000, tax: 981, net: 14019),
      ]);
    });

    test('round once per tax rate, so that the shares add up', () {
      // Each charge alone would round to 22 cents of tax, 66 in total.
      final shares = taxShares([_charge(333), _charge(333), _charge(333)]);

      expect(shares.single, (taxRate: 700, gross: 999, tax: 65, net: 934));
    });

    test('keep the tax rates apart, lowest first', () {
      final shares = taxShares([
        _charge(11900, taxRate: 1900),
        _charge(10700),
        _charge(500, taxRate: 0),
      ]);

      expect(shares, [
        (taxRate: 0, gross: 500, tax: 0, net: 500),
        (taxRate: 700, gross: 10700, tax: 700, net: 10000),
        (taxRate: 1900, gross: 11900, tax: 1900, net: 10000),
      ]);
    });

    test('take a discount off its tax rate', () {
      final shares = taxShares([_charge(10700), _charge(-1070)]);

      expect(shares.single, (taxRate: 700, gross: 9630, tax: 630, net: 9000));
    });
  });

  test('formatTaxRate drops decimals that are zero', () {
    expect(formatTaxRate(700), '7');
    expect(formatTaxRate(1900), '19');
    expect(formatTaxRate(750), '7,5');
    expect(formatTaxRate(725), '7,25');
    expect(formatTaxRate(0), '0');
  });

  test('formatAmount keeps the sign of a discount', () {
    expect(formatAmount(-600), '-6,00');
    expect(formatAmount(-123456), '-1.234,56');
  });

  group('Given an operator', () {
    Operator operator({String taxNumber = '026 250 12345', String? iban}) =>
        Operator(
          name: 'Freizeitheim Musterhöhe e. V.',
          street: 'Bergstraße 12',
          zip: '34117',
          city: 'Kassel',
          taxOffice: '',
          taxNumber: taxNumber,
          purposes: '',
          place: '',
          accountHolder: 'Freizeitheim Musterhöhe',
          iban: iban,
          bic: 'HELADEF1KAS',
          bankName: 'Kasseler Sparkasse',
          paymentTerms: 'Zahlbar innerhalb von 14 Tagen ohne Abzug.',
        );

    test('when it has a name, an address and a tax number '
        'then it can issue invoices without bank details', () {
      expect(isCompleteForInvoices(operator()), isTrue);
      expect(isCompleteForInvoices(operator(taxNumber: ' ')), isFalse);
    });

    test(
      'when building an invoice '
      'then it states the number, the charges, the tax and where to pay',
      () async {
        final pdf = await buildInvoicePdf(
          operator: operator(iban: 'DE02 5205 0353 0000 1234 56'),
          folio: Folio(
            bookingId: 1,
            payerId: 1,
            invoiceNumber: '2027-0001',
            invoicedAt: DateTime.utc(2027, 5, 14),
            payer: Contact(
              firstName: 'Marie',
              lastName: 'Weber',
              street: 'Lindenstraße 5',
              zip: '34119',
              city: 'Kassel',
            ),
            booking: Booking(
              title: 'Frühlingstage',
              leadId: 1,
              arrival: DateTime.utc(2027, 5, 10),
              departure: DateTime.utc(2027, 5, 13),
            ),
            charges: [
              _charge(15000, quantity: 3).copyWith(
                guestId: 7,
                periodFrom: DateTime.utc(2027, 5, 10),
                periodTo: DateTime.utc(2027, 5, 13),
              ),
              Charge(
                folioId: 1,
                type: ChargeType.discount,
                description: 'Frühbucher',
                quantity: 1,
                unitPrice: -1000,
                total: -1000,
                taxRate: 700,
              ),
            ],
          ),
          guestNames: {7: 'Jonas Weber'},
        );

        expect(ascii.decode(pdf.sublist(0, 5)), '%PDF-');
        final text = wordsOf(pdf).join(' ');
        for (final expected in [
          'Freizeitheim Musterhöhe e. V.',
          'Marie Weber',
          'Lindenstraße 5',
          'Rechnungsnummer: 2027-0001',
          'Rechnungsdatum: 14.05.2027',
          'Leistungszeitraum: 10.05.2027 - 13.05.2027',
          'Buchung: Frühlingstage',
          'Übernachtung: Standard · Erwachsene · Sommer',
          'Jonas Weber, 10.05.2027 - 13.05.2027',
          '3 50,00 EUR 150,00 EUR',
          'Rabatt: Frühbucher',
          '-10,00 EUR',
          'Gesamtbetrag: 140,00 EUR',
          'Darin enthalten 7 % Umsatzsteuer: 9,16 EUR (Nettobetrag 130,84 EUR)',
          'Zahlbar innerhalb von 14 Tagen ohne Abzug.',
          'IBAN: DE02 5205 0353 0000 1234 56',
          'BIC: HELADEF1KAS',
          'Verwendungszweck: Rechnung 2027-0001',
          'Steuernummer 026 250 12345',
        ]) {
          expect(text, contains(expected));
        }
      },
    );

    test('when it has no bank details '
        'then the invoice leaves them out', () async {
      final pdf = await buildInvoicePdf(
        operator: operator(),
        folio: Folio(
          bookingId: 1,
          payerId: 1,
          invoiceNumber: '2027-0002',
          payer: Contact(firstName: 'Marie', lastName: 'Weber'),
          booking: Booking(title: 'Tag', leadId: 1),
          charges: [_charge(5000)],
        ),
        guestNames: {},
      );

      final text = wordsOf(pdf).join(' ');
      expect(text, contains('Gesamtbetrag: 50,00 EUR'));
      expect(text, isNot(contains('Bankverbindung')));
      expect(text, isNot(contains('Leistungszeitraum')));
    });
  });
}
