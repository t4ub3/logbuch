import 'dart:typed_data';

import 'package:logbuch_server/src/common/german_format.dart';
import 'package:logbuch_server/src/donations/receipt_text.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Builds the receipt for the [donations] of [donor] in [year]: the
/// confirmation itself, followed by the list of the donations as its annex.
///
/// The built-in fonts only cover Western European characters, so the text
/// uses "EUR" and plain hyphens instead of the euro sign and dashes.
Future<Uint8List> buildReceiptPdf({
  required Operator operator,
  required Contact donor,
  required String number,
  required int year,
  required DateTime issuedAt,
  required List<Donation> donations,
}) {
  final total = donations.fold(0, (sum, donation) => sum + donation.amount);
  const small = pw.TextStyle(fontSize: 8);
  final bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);

  pw.Widget box(String label, List<String> lines) => pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.all(6),
    decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(label, style: small),
        pw.SizedBox(height: 3),
        for (final line in lines) pw.Text(line),
      ],
    ),
  );

  final document = pw.Document(
    title: 'Sammelbestätigung $number',
    author: operator.name,
  );
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(2 * PdfPageFormat.cm),
      theme: pw.ThemeData(defaultTextStyle: const pw.TextStyle(fontSize: 10)),
      build: (context) => [
        box(
          'Aussteller (Bezeichnung und Anschrift der steuerbegünstigten '
          'Einrichtung)',
          [
            operator.name,
            '${operator.street}, ${operator.zip} ${operator.city}',
          ],
        ),
        pw.SizedBox(height: 14),
        pw.Text(
          'Sammelbestätigung über Geldzuwendungen/Mitgliedsbeiträge',
          style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          'im Sinne des § 10b des Einkommensteuergesetzes an eine der in '
          '§ 5 Abs. 1 Nr. 9 des Körperschaftsteuergesetzes bezeichneten '
          'Körperschaften, Personenvereinigungen oder Vermögensmassen',
        ),
        pw.SizedBox(height: 4),
        pw.Text('Nr. $number', style: small),
        pw.SizedBox(height: 10),
        box('Name und Anschrift des Zuwendenden', [
          '${donor.firstName} ${donor.lastName}'.trim(),
          donor.street ?? '',
          '${donor.zip ?? ''} ${donor.city ?? ''}'.trim(),
          if (donor.country case final country? when country.isNotEmpty)
            country,
        ]),
        pw.SizedBox(height: 6),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 2,
              child: box('Gesamtbetrag der Zuwendung - in Ziffern -', [
                '${formatAmount(total)} EUR',
              ]),
            ),
            pw.SizedBox(width: 6),
            pw.Expanded(
              flex: 4,
              child: box('- in Buchstaben -', [amountInWords(total)]),
            ),
            pw.SizedBox(width: 6),
            pw.Expanded(
              flex: 3,
              child: box('Zeitraum der Sammelbestätigung', [
                '01.01.$year - 31.12.$year',
              ]),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        for (final statement in receiptStatements(operator))
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Text(statement, textAlign: pw.TextAlign.justify),
          ),
        pw.SizedBox(height: 40),
        pw.Text('${operator.place}, ${formatGermanDate(issuedAt)}'),
        pw.Divider(thickness: 0.5),
        pw.Text(
          '(Ort, Datum und Unterschrift des Zuwendungsempfängers)',
          style: small,
        ),
        if (operator.signatory case final signatory? when signatory.isNotEmpty)
          pw.Text(signatory, style: small),
        pw.SizedBox(height: 16),
        pw.Text(receiptNotice, style: small, textAlign: pw.TextAlign.justify),
        pw.NewPage(),
        pw.Text('Anlage zur Sammelbestätigung Nr. $number', style: bold),
        pw.Text(
          '${donor.firstName} ${donor.lastName}'.trim(),
        ),
        pw.SizedBox(height: 10),
        pw.TableHelper.fromTextArray(
          headerStyle: bold,
          cellAlignments: const {3: pw.Alignment.centerRight},
          headers: [
            'Datum der Zuwendung',
            'Art der Zuwendung',
            'Verzicht auf die Erstattung von Aufwendungen',
            'Betrag',
          ],
          data: [
            for (final donation in donations)
              [
                formatGermanDate(donation.date),
                'Geldzuwendung',
                'nein',
                '${formatAmount(donation.amount)} EUR',
              ],
            ['Gesamtsumme', '', '', '${formatAmount(total)} EUR'],
          ],
        ),
      ],
    ),
  );
  return document.save();
}
