import 'package:logbuch_server/src/generated/protocol.dart';

/// Returns the trimmed [name], which must not be empty.
String requireName(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) {
    throw ValidationException(reason: ValidationError.nameRequired);
  }
  return trimmed;
}

/// Dates without a time of day are stored as midnight UTC. Anything else is
/// rejected instead of rounded, because a local midnight sent by mistake
/// would end up on the day before.
void requireDateOnly(DateTime date) {
  if (!date.isUtc || date != DateTime.utc(date.year, date.month, date.day)) {
    throw ValidationException(reason: ValidationError.invalidDate);
  }
}

/// Tax rates are stored in basis points, so 700 is 7 %.
void requireTaxRate(int taxRate) {
  if (taxRate < 0 || taxRate > 10000) {
    throw ValidationException(reason: ValidationError.invalidTaxRate);
  }
}

/// Amounts are stored in cents and must not be negative.
void requireAmount(int amount) {
  if (amount < 0) {
    throw ValidationException(reason: ValidationError.invalidAmount);
  }
}
