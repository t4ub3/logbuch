import 'dart:typed_data';

import 'package:logbuch_server/src/common/german_format.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// What the charges of one tax rate come to, and how much of it is tax.
/// Amounts are in cents; the rate is in basis points.
typedef TaxShare = ({int taxRate, int gross, int tax, int net});

/// Splits what was charged, which includes the tax, into tax and net amount
/// for every tax rate. The tax is rounded once per rate, not per charge, so
/// that the shares add up to the total.
List<TaxShare> taxShares(List<Charge> charges) {
  final gross = <int, int>{};
  for (final charge in charges) {
    gross[charge.taxRate] = (gross[charge.taxRate] ?? 0) + charge.total;
  }
  return [
    for (final taxRate in gross.keys.toList()..sort())
      (
        taxRate: taxRate,
        gross: gross[taxRate]!,
        tax: _taxIn(gross[taxRate]!, taxRate),
        net: gross[taxRate]! - _taxIn(gross[taxRate]!, taxRate),
      ),
  ];
}

/// The tax contained in a gross amount, rounded half up to the cent.
int _taxIn(int gross, int taxRate) {
  final divisor = 10000 + taxRate;
  final tax = (2 * gross.abs() * taxRate + divisor) ~/ (2 * divisor);
  return gross < 0 ? -tax : tax;
}

/// Whether an invoice can name who issues it: by name, address and tax
/// number. Bank details and payment terms are printed if they are there.
bool isCompleteForInvoices(Operator operator) => [
  operator.name,
  operator.street,
  operator.zip,
  operator.city,
  operator.taxNumber,
].every((text) => text.trim().isNotEmpty);

/// Builds the invoice of an invoiced [folio], which must come with its
/// payer, its booking and its charges. [guestNames] are the names of the
/// guests of the booking by their id.
///
/// Invoices are German documents whatever language the app is used in. The
/// built-in fonts only cover Western European characters, so the text uses
/// "EUR" and plain hyphens instead of the euro sign and dashes.
Future<Uint8List> buildInvoicePdf({
  required Operator operator,
  required Folio folio,
  required Map<int, String> guestNames,
}) {
  final payer = folio.payer!;
  final booking = folio.booking!;
  final charges = folio.charges ?? [];
  final total = charges.fold(0, (sum, charge) => sum + charge.total);
  const small = pw.TextStyle(fontSize: 8);
  final bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);

  pw.Widget cell(pw.Widget child, {bool end = false}) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
    child: pw.Align(
      alignment: end ? pw.Alignment.topRight : pw.Alignment.topLeft,
      child: child,
    ),
  );

  final document = pw.Document(
    title: 'Rechnung ${folio.invoiceNumber}',
    author: operator.name,
  );
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(2 * PdfPageFormat.cm),
      theme: pw.ThemeData(defaultTextStyle: const pw.TextStyle(fontSize: 10)),
      footer: (context) => pw.Text(
        [
          operator.name,
          '${operator.street}, ${operator.zip} ${operator.city}',
          'Steuernummer ${operator.taxNumber}',
        ].join(' - '),
        style: small,
      ),
      build: (context) => [
        pw.Text(operator.name, style: bold),
        pw.Text('${operator.street}, ${operator.zip} ${operator.city}'),
        pw.SizedBox(height: 28),
        pw.Text('${payer.firstName} ${payer.lastName}'.trim()),
        if (payer.street case final street? when street.isNotEmpty)
          pw.Text(street),
        pw.Text('${payer.zip ?? ''} ${payer.city ?? ''}'.trim()),
        if (payer.country case final country? when country.isNotEmpty)
          pw.Text(country),
        pw.SizedBox(height: 28),
        pw.Text(
          'Rechnung',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        pw.Text('Rechnungsnummer: ${folio.invoiceNumber}'),
        if (folio.invoicedAt case final date?)
          pw.Text('Rechnungsdatum: ${formatGermanDate(date)}'),
        if ((booking.arrival, booking.departure) case (
          final arrival?,
          final departure?,
        ))
          pw.Text(
            'Leistungszeitraum: ${formatGermanDate(arrival)} - '
            '${formatGermanDate(departure)}',
          ),
        pw.Text('Buchung: ${booking.title}'),
        pw.SizedBox(height: 16),
        pw.Table(
          border: const pw.TableBorder(
            horizontalInside: pw.BorderSide(width: 0.3),
            bottom: pw.BorderSide(width: 0.8),
          ),
          columnWidths: const {
            0: pw.FlexColumnWidth(6),
            1: pw.FlexColumnWidth(1.2),
            2: pw.FlexColumnWidth(2),
            3: pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(
              repeat: true,
              children: [
                cell(pw.Text('Bezeichnung', style: bold)),
                cell(pw.Text('Menge', style: bold), end: true),
                cell(pw.Text('Einzelpreis', style: bold), end: true),
                cell(pw.Text('Betrag', style: bold), end: true),
              ],
            ),
            for (final charge in charges)
              pw.TableRow(
                children: [
                  cell(
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(_title(charge)),
                        if (_details(charge, guestNames) case final details?)
                          pw.Text(details, style: small),
                      ],
                    ),
                  ),
                  cell(pw.Text('${charge.quantity}'), end: true),
                  cell(
                    pw.Text('${formatAmount(charge.unitPrice)} EUR'),
                    end: true,
                  ),
                  cell(pw.Text('${formatAmount(charge.total)} EUR'), end: true),
                ],
              ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Gesamtbetrag: ${formatAmount(total)} EUR',
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 6),
        for (final share in taxShares(charges))
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              share.taxRate == 0
                  ? 'Ohne Umsatzsteuer: ${formatAmount(share.gross)} EUR'
                  : 'Darin enthalten ${formatTaxRate(share.taxRate)} % '
                        'Umsatzsteuer: ${formatAmount(share.tax)} EUR '
                        '(Nettobetrag ${formatAmount(share.net)} EUR)',
              style: small,
            ),
          ),
        pw.SizedBox(height: 24),
        if (operator.paymentTerms case final terms? when terms.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10),
            child: pw.Text(terms),
          ),
        if (operator.iban case final iban? when iban.isNotEmpty) ...[
          pw.Text('Bankverbindung', style: bold),
          if (operator.accountHolder case final holder? when holder.isNotEmpty)
            pw.Text('Kontoinhaber: $holder'),
          pw.Text('IBAN: $iban'),
          if (operator.bic case final bic? when bic.isNotEmpty)
            pw.Text('BIC: $bic'),
          if (operator.bankName case final bank? when bank.isNotEmpty)
            pw.Text('Bank: $bank'),
          pw.Text('Verwendungszweck: Rechnung ${folio.invoiceNumber}'),
        ],
      ],
    ),
  );
  return document.save();
}

/// What a charge is for, in German.
String _title(Charge charge) {
  final kind = switch (charge.type) {
    ChargeType.lodging => 'Übernachtung',
    ChargeType.meal => 'Verpflegung',
    ChargeType.discount => 'Rabatt',
    ChargeType.fee || ChargeType.manual => null,
  };
  return kind == null ? charge.description : '$kind: ${charge.description}';
}

/// The guest and the nights a charge is for, if it has any of them.
String? _details(Charge charge, Map<int, String> guestNames) {
  final from = charge.periodFrom;
  final to = charge.periodTo;
  final details = [
    ?guestNames[charge.guestId],
    if (from != null && to != null)
      '${formatGermanDate(from)} - ${formatGermanDate(to)}',
  ];
  return details.isEmpty ? null : details.join(', ');
}
