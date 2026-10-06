import 'dart:convert';

import 'package:logbuch_server/src/donations/receipt_pdf.dart';
import 'package:logbuch_server/src/donations/receipt_text.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

Operator _operator({
  TaxNoticeType noticeType = TaxNoticeType.statutoryCompliance,
  DateTime? noticeDate,
  bool dated = true,
  String? assessmentPeriod,
  String? purposesObject = 'die Jugendhilfe',
}) => Operator(
  name: 'Haus am See e. V.',
  street: 'Seeweg 1',
  zip: '34117',
  city: 'Kassel',
  taxOffice: 'Kassel',
  taxNumber: '26 250 12345',
  noticeType: noticeType,
  noticeDate: dated ? noticeDate ?? DateTime.utc(2025, 5, 3) : null,
  assessmentPeriod: assessmentPeriod,
  purposes: 'der Jugendhilfe',
  purposesObject: purposesObject,
  place: 'Kassel',
  signatory: 'Anna Schmidt',
);

void main() {
  group('numberInWords', () {
    test('spells small numbers, with one in the form before a noun', () {
      expect(numberInWords(0), 'null');
      expect(numberInWords(1), 'ein');
      expect(numberInWords(12), 'zwölf');
      expect(numberInWords(16), 'sechzehn');
      expect(numberInWords(17), 'siebzehn');
    });

    test('puts the units in front of the tens', () {
      expect(numberInWords(21), 'einundzwanzig');
      expect(numberInWords(30), 'dreißig');
      expect(numberInWords(99), 'neunundneunzig');
    });

    test('joins hundreds and thousands into one word', () {
      expect(numberInWords(100), 'einhundert');
      expect(numberInWords(101), 'einhundertein');
      expect(numberInWords(1000), 'eintausend');
      expect(numberInWords(1234), 'eintausendzweihundertvierunddreißig');
      expect(numberInWords(20000), 'zwanzigtausend');
    });

    test('sets millions apart', () {
      expect(numberInWords(1000000), 'eine Million');
      expect(numberInWords(2500000), 'zwei Millionen fünfhunderttausend');
    });
  });

  test('amountInWords names euros and, if there are any, cents', () {
    expect(amountInWords(12000), 'einhundertzwanzig Euro');
    expect(amountInWords(12050), 'einhundertzwanzig Euro und fünfzig Cent');
    expect(amountInWords(100), 'ein Euro');
    expect(amountInWords(5), 'null Euro und fünf Cent');
  });

  test('formatAmount groups thousands and uses a decimal comma', () {
    expect(formatAmount(5), '0,05');
    expect(formatAmount(12050), '120,50');
    expect(formatAmount(123456), '1.234,56');
    expect(formatAmount(100000000), '1.000.000,00');
  });

  group('receiptStatements', () {
    test('cite the notice by § 60a AO with what the statutes promote', () {
      final statements = receiptStatements(_operator());

      expect(
        statements.first,
        'Die Einhaltung der satzungsmäßigen Voraussetzungen nach den '
        '§§ 51, 59, 60 und 61 AO wurde vom Finanzamt Kassel, '
        'StNr. 26 250 12345, mit Bescheid vom 03.05.2025 nach § 60a AO '
        'gesondert festgestellt. Wir fördern nach unserer Satzung die '
        'Jugendhilfe.',
      );
      expect(
        statements[1],
        'Es wird bestätigt, dass die Zuwendung nur zur Förderung der '
        'Jugendhilfe verwendet wird.',
      );
      expect(statements, hasLength(4));
    });

    test('cite an exemption notice with its assessment period', () {
      final statements = receiptStatements(
        _operator(
          noticeType: TaxNoticeType.exemptionNotice,
          assessmentPeriod: '2024',
        ),
      );

      expect(
        statements.first,
        allOf(
          startsWith('Wir sind wegen Förderung der Jugendhilfe nach dem '),
          contains('Freistellungsbescheid'),
          contains(
            'des Finanzamtes Kassel, StNr. 26 250 12345, vom 03.05.2025',
          ),
          contains('für den letzten Veranlagungszeitraum 2024'),
          isNot(contains('§ 60a')),
        ),
      );
    });
  });

  group('isCompleteForReceipts', () {
    test('accepts an operator with everything its notice needs', () {
      expect(isCompleteForReceipts(_operator()), isTrue);
      expect(
        isCompleteForReceipts(
          _operator(
            noticeType: TaxNoticeType.exemptionNotice,
            assessmentPeriod: '2024',
            purposesObject: null,
          ),
        ),
        isTrue,
      );
    });

    test('misses the date of the notice', () {
      expect(isCompleteForReceipts(_operator(dated: false)), isFalse);
    });

    test('misses what only the kind of notice needs', () {
      expect(isCompleteForReceipts(_operator(purposesObject: ' ')), isFalse);
      expect(
        isCompleteForReceipts(
          _operator(noticeType: TaxNoticeType.exemptionNotice),
        ),
        isFalse,
      );
    });
  });

  test('buildReceiptPdf writes a PDF, also for many donations', () async {
    final pdf = await buildReceiptPdf(
      operator: _operator(),
      donor: Contact(
        firstName: 'Marie',
        lastName: 'Weber',
        street: 'Lindenstraße 5',
        zip: '34119',
        city: 'Kassel',
      ),
      number: 'SB-2027-0001',
      year: 2027,
      issuedAt: DateTime.utc(2028, 1, 15),
      donations: [
        for (var day = 1; day <= 80; day++)
          Donation(
            contactId: 1,
            amount: 1000 + day,
            date: DateTime.utc(2027, 1, 1).add(Duration(days: day * 4)),
            source: DonationSource.direct,
          ),
      ],
    );

    expect(ascii.decode(pdf.sublist(0, 5)), '%PDF-');
    expect(pdf.length, greaterThan(5000));
  });
}
