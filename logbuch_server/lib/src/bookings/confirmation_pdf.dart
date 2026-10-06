import 'dart:typed_data';

import 'package:logbuch_server/src/common/german_format.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Whether a confirmation can name who sends it: by name and address.
bool isCompleteForConfirmations(Operator operator) => [
  operator.name,
  operator.street,
  operator.zip,
  operator.city,
].every((text) => text.trim().isNotEmpty);

/// Whether a booking is far enough to be confirmed in writing: reserved as
/// an option, or confirmed and beyond. An inquiry is not agreed on yet and a
/// cancelled booking is over.
bool isConfirmable(BookingStatus status) => switch (status) {
  BookingStatus.option ||
  BookingStatus.confirmed ||
  BookingStatus.checkedIn ||
  BookingStatus.completed => true,
  BookingStatus.inquiry || BookingStatus.cancelled => false,
};

/// Builds the confirmation of [booking] for its lead, as the booking is now.
///
/// [booking] must have dates and come with its lead, its meal plan and the
/// rooms it holds. [guestCount] is the number of its guests, or of the
/// guests it expects while there is no guest list. [price] is what it costs;
/// it is left out when null, which it should be while a part of the booking
/// cannot be priced, so that no misleading total is sent out.
///
/// Confirmations are German documents whatever language the app is used in.
/// The built-in fonts only cover Western European characters, so the text
/// uses "EUR" and plain hyphens instead of the euro sign and dashes.
Future<Uint8List> buildConfirmationPdf({
  required Operator operator,
  required Booking booking,
  required int? guestCount,
  required BookingPrice? price,
  required DateTime today,
}) {
  final lead = booking.lead!;
  final leadName = '${lead.firstName} ${lead.lastName}'.trim();
  final arrival = booking.arrival!;
  final departure = booking.departure!;
  final nights = departure.difference(arrival).inDays;
  final isOption = booking.status == BookingStatus.option;
  final rooms = [
    for (final hold in booking.rooms ?? <BookingRoom>[]) ?hold.room,
  ]..sort((a, b) => a.roomNumber.compareTo(b.roomNumber));
  final beds = rooms.fold(0, (sum, room) => sum + room.bedAmount);
  final bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);
  const small = pw.TextStyle(fontSize: 8);

  pw.TableRow row(String label, String value, {pw.TextStyle? style}) =>
      pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            child: pw.Text(label, style: style),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            child: pw.Text(value, style: style),
          ),
        ],
      );

  int sumOf(Set<ChargeType> types) => price!.lines
      .where((line) => types.contains(line.type))
      .fold(0, (sum, line) => sum + line.total);

  final document = pw.Document(
    title: isOption ? 'Reservierungsbestätigung' : 'Buchungsbestätigung',
    author: operator.name,
  );
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(2 * PdfPageFormat.cm),
      theme: pw.ThemeData(defaultTextStyle: const pw.TextStyle(fontSize: 10)),
      build: (context) => [
        pw.Text(operator.name, style: bold),
        pw.Text('${operator.street}, ${operator.zip} ${operator.city}'),
        pw.SizedBox(height: 28),
        pw.Text(leadName),
        if (lead.street case final street? when street.isNotEmpty)
          pw.Text(street),
        pw.Text('${lead.zip ?? ''} ${lead.city ?? ''}'.trim()),
        if (lead.country case final country? when country.isNotEmpty)
          pw.Text(country),
        pw.SizedBox(height: 20),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Datum: ${formatGermanDate(today)}'),
        ),
        pw.SizedBox(height: 12),
        pw.Text(
          isOption ? 'Reservierungsbestätigung' : 'Buchungsbestätigung',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Text('Guten Tag $leadName,'),
        pw.SizedBox(height: 8),
        pw.Text(
          isOption
              ? 'vielen Dank für Ihre Anfrage. Wir haben den folgenden '
                    'Aufenthalt für Sie reserviert:'
              : 'vielen Dank für Ihre Buchung. Wir bestätigen Ihren '
                    'Aufenthalt wie folgt:',
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          columnWidths: const {
            0: pw.FixedColumnWidth(110),
            1: pw.FlexColumnWidth(),
          },
          children: [
            row('Buchung', booking.title),
            row('Anreise', formatGermanDate(arrival)),
            row(
              'Abreise',
              '${formatGermanDate(departure)} '
                  '(${nights == 1 ? '1 Nacht' : '$nights Nächte'})',
            ),
            if (rooms.isNotEmpty)
              row(
                rooms.length == 1 ? 'Zimmer' : 'Zimmer (${rooms.length})',
                '${rooms.map((room) => room.roomNumber).join(', ')} '
                '(${beds == 1 ? '1 Bett' : '$beds Betten'})',
              ),
            if (guestCount != null) row('Gäste', '$guestCount'),
            row('Verpflegung', booking.mealPlan?.name ?? 'keine'),
          ],
        ),
        if (isOption)
          if (booking.optionExpiresAt case final expiry?)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10),
              child: pw.Text(
                'Die Reservierung gilt bis zum ${formatGermanDate(expiry)}.',
              ),
            ),
        if (price != null) ...[
          pw.SizedBox(height: 16),
          pw.Text('Voraussichtlicher Preis', style: bold),
          pw.SizedBox(height: 4),
          pw.Table(
            columnWidths: const {
              0: pw.FixedColumnWidth(110),
              1: pw.FlexColumnWidth(),
            },
            children: [
              for (final (label, types) in [
                ('Übernachtung', {ChargeType.lodging}),
                ('Verpflegung', {ChargeType.meal}),
                ('Gebühren', {ChargeType.fee}),
              ])
                if (sumOf(types) != 0)
                  row(label, '${formatAmount(sumOf(types))} EUR'),
              row('Gesamt', '${formatAmount(price.total)} EUR', style: bold),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Alle Preise enthalten die Umsatzsteuer. Der Preis ergibt sich '
            'aus der aktuellen Gästeliste und ändert sich, wenn sich diese '
            'oder die Buchung ändert.',
            style: small,
          ),
        ],
        if (operator.confirmationNote case final note? when note.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 16),
            child: pw.Text(note),
          ),
        pw.SizedBox(height: 24),
        pw.Text('Mit freundlichen Grüßen'),
        pw.SizedBox(height: 4),
        pw.Text(operator.name),
      ],
    ),
  );
  return document.save();
}
