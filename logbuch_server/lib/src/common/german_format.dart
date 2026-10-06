/// An amount in figures the German way: 123456 cents are "1.234,56".
String formatAmount(int cents) {
  final sign = cents < 0 ? '-' : '';
  final euros = (cents.abs() ~/ 100).toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+$)'),
    (match) => '.',
  );
  return '$sign$euros,${(cents.abs() % 100).toString().padLeft(2, '0')}';
}

/// A date the German way: 03.05.2027.
String formatGermanDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}.'
    '${date.month.toString().padLeft(2, '0')}.${date.year}';

/// A tax rate in basis points as a percentage: 700 is "7", 750 is "7,5".
String formatTaxRate(int basisPoints) {
  final whole = basisPoints ~/ 100;
  final rest = (basisPoints % 100).toString().padLeft(2, '0');
  final decimals = rest.replaceFirst(RegExp(r'0+$'), '');
  return decimals.isEmpty ? '$whole' : '$whole,$decimals';
}
