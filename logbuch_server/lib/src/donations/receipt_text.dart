/// The wording of a donation receipt. Receipts are German tax documents, so
/// their text is German whatever language the app is used in. The sentences
/// follow the official template for a "Sammelbestätigung über
/// Geldzuwendungen", whose wording has to be kept.
library;

import 'package:logbuch_server/src/generated/protocol.dart';

const _small = [
  '',
  'ein',
  'zwei',
  'drei',
  'vier',
  'fünf',
  'sechs',
  'sieben',
  'acht',
  'neun',
  'zehn',
  'elf',
  'zwölf',
  'dreizehn',
  'vierzehn',
  'fünfzehn',
  'sechzehn',
  'siebzehn',
  'achtzehn',
  'neunzehn',
];

const _tens = [
  '',
  '',
  'zwanzig',
  'dreißig',
  'vierzig',
  'fünfzig',
  'sechzig',
  'siebzig',
  'achtzig',
  'neunzig',
];

String _below1000(int n) {
  final words = StringBuffer();
  if (n >= 100) words.write('${_small[n ~/ 100]}hundert');
  final rest = n % 100;
  if (rest < 20) {
    words.write(_small[rest]);
  } else {
    if (rest % 10 > 0) words.write('${_small[rest % 10]}und');
    words.write(_tens[rest ~/ 10]);
  }
  return words.toString();
}

/// A whole number below a billion in German words, in the form used in
/// front of a noun: 1 is "ein" and 21 is "einundzwanzig".
String numberInWords(int n) {
  if (n == 0) return 'null';
  final millions = n ~/ 1000000;
  final thousands = n ~/ 1000 % 1000;
  final below = [
    if (thousands > 0) '${_below1000(thousands)}tausend',
    _below1000(n % 1000),
  ].join();
  return [
    if (millions == 1) 'eine Million',
    if (millions > 1) '${_below1000(millions)} Millionen',
    if (below.isNotEmpty) below,
  ].join(' ');
}

/// An amount in words, as a receipt has to state it next to the figures:
/// 12050 cents are "einhundertzwanzig Euro und fünfzig Cent".
String amountInWords(int cents) {
  final euros = '${numberInWords(cents ~/ 100)} Euro';
  final rest = cents % 100;
  return rest == 0 ? euros : '$euros und ${numberInWords(rest)} Cent';
}

/// An amount in figures the German way: 123456 cents are "1.234,56".
String formatAmount(int cents) {
  final euros = (cents ~/ 100).toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+$)'),
    (match) => '.',
  );
  return '$euros,${(cents % 100).toString().padLeft(2, '0')}';
}

/// A date the German way: 03.05.2027.
String formatGermanDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}.'
    '${date.month.toString().padLeft(2, '0')}.${date.year}';

/// Whether everything that a receipt states about the operator is there.
bool isCompleteForReceipts(Operator operator) {
  final required = [
    operator.name,
    operator.street,
    operator.zip,
    operator.city,
    operator.taxOffice,
    operator.taxNumber,
    operator.purposes,
    operator.place,
    switch (operator.noticeType) {
      TaxNoticeType.exemptionNotice => operator.assessmentPeriod ?? '',
      TaxNoticeType.statutoryCompliance => operator.purposesObject ?? '',
    },
  ];
  return operator.noticeDate != null &&
      required.every((text) => text.trim().isNotEmpty);
}

/// Whether a receipt can name where the donor lives.
bool hasFullAddress(Contact contact) => [
  contact.street,
  contact.zip,
  contact.city,
].every((text) => text != null && text.trim().isNotEmpty);

/// The statements of the operator on a receipt. The first one depends on
/// the notice of the tax office that the operator has.
List<String> receiptStatements(Operator operator) {
  final office = operator.taxOffice;
  final number = operator.taxNumber;
  final date = switch (operator.noticeDate) {
    final date? => formatGermanDate(date),
    null => '',
  };
  return [
    switch (operator.noticeType) {
      TaxNoticeType.statutoryCompliance =>
        'Die Einhaltung der satzungsmäßigen Voraussetzungen nach den '
            '§§ 51, 59, 60 und 61 AO wurde vom Finanzamt $office, '
            'StNr. $number, mit Bescheid vom $date nach § 60a AO gesondert '
            'festgestellt. Wir fördern nach unserer Satzung '
            '${operator.purposesObject}.',
      TaxNoticeType.exemptionNotice =>
        'Wir sind wegen Förderung ${operator.purposes} nach dem '
            'Freistellungsbescheid bzw. nach der Anlage zum '
            'Körperschaftsteuerbescheid des Finanzamtes $office, '
            'StNr. $number, vom $date für den letzten Veranlagungszeitraum '
            '${operator.assessmentPeriod} nach § 5 Abs. 1 Nr. 9 des '
            'Körperschaftsteuergesetzes von der Körperschaftsteuer und nach '
            '§ 3 Nr. 6 des Gewerbesteuergesetzes von der Gewerbesteuer '
            'befreit.',
    },
    'Es wird bestätigt, dass die Zuwendung nur zur Förderung '
        '${operator.purposes} verwendet wird.',
    'Es wird bestätigt, dass über die in der Gesamtsumme enthaltenen '
        'Zuwendungen keine weiteren Bestätigungen, weder formelle '
        'Zuwendungsbestätigungen noch Beitragsquittungen oder Ähnliches '
        'ausgestellt wurden und werden.',
    'Ob es sich um den Verzicht auf Erstattung von Aufwendungen handelt, '
        'ist der Anlage zur Sammelbestätigung zu entnehmen.',
  ];
}

/// The notice about liability that closes a receipt.
const receiptNotice =
    'Hinweis: Wer vorsätzlich oder grob fahrlässig eine unrichtige '
    'Zuwendungsbestätigung erstellt oder veranlasst, dass Zuwendungen nicht '
    'zu den in der Zuwendungsbestätigung angegebenen steuerbegünstigten '
    'Zwecken verwendet werden, haftet für die entgangene Steuer (§ 10b '
    'Abs. 4 EStG, § 9 Abs. 3 KStG, § 9 Nr. 5 GewStG). Diese Bestätigung '
    'wird nicht als Nachweis für die steuerliche Berücksichtigung der '
    'Zuwendung anerkannt, wenn das Datum des Freistellungsbescheides länger '
    'als 5 Jahre bzw. das Datum der Feststellung der Einhaltung der '
    'satzungsmäßigen Voraussetzungen nach § 60a Abs. 1 AO länger als '
    '3 Jahre seit Ausstellung des Bescheides zurückliegt (§ 63 Abs. 5 AO).';
