import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';

final _hundredths = RegExp(r'^(\d+)(?:[.,](\d{1,2}))?$');

/// Parses an amount with up to two decimals into hundredths, so euros into
/// cents and percent into basis points. Both comma and dot are accepted as
/// the decimal separator. Returns null for anything else.
int? parseHundredths(String input) {
  final match = _hundredths.firstMatch(input.trim());
  if (match == null) return null;
  final decimals = (match[2] ?? '').padRight(2, '0');
  return int.parse(match[1]!) * 100 + int.parse(decimals);
}

/// Formats hundredths for an input field, like "12.50". With [trimZeros]
/// whole amounts lose their decimals, like "7".
String formatHundredths(
  BuildContext context,
  int value, {
  bool trimZeros = false,
}) {
  final format = NumberFormat(trimZeros ? '0.##' : '0.00', _locale(context));
  return format.format(value / 100);
}

/// Formats [cents] as an amount in euros, like "€12.50".
String formatMoney(BuildContext context, int cents) {
  return NumberFormat.simpleCurrency(
    locale: _locale(context),
    name: 'EUR',
  ).format(cents / 100);
}

String _locale(BuildContext context) =>
    Localizations.localeOf(context).toLanguageTag();

/// Dates without a time of day travel as midnight UTC. Pickers and
/// formatters work with local dates, so the day is carried over as is.
DateTime toLocalDate(DateTime utcDate) =>
    DateTime(utcDate.year, utcDate.month, utcDate.day);

DateTime toUtcDate(DateTime localDate) =>
    DateTime.utc(localDate.year, localDate.month, localDate.day);

/// Formats a date that was stored as midnight UTC.
String formatDate(BuildContext context, DateTime utcDate) {
  return MaterialLocalizations.of(
    context,
  ).formatShortDate(toLocalDate(utcDate));
}

String? nullIfBlank(String text) {
  final trimmed = text.trim();
  return trimmed.isEmpty ? null : trimmed;
}

/// The message for a [ValidationException] of the server, or null if
/// [error] is something else.
String? validationMessage(BuildContext context, Object error) {
  if (error is! ValidationException) return null;
  final t = context.t.admin.errors;
  final name = error.detail ?? '';
  return switch (error.reason) {
    ValidationError.nameRequired => t.nameRequired,
    ValidationError.invalidDate => t.invalidDate,
    ValidationError.invalidDateRange => t.invalidDateRange,
    ValidationError.seasonOverlap => t.seasonOverlap(name: name),
    ValidationError.invalidAgeRange => t.invalidAgeRange,
    ValidationError.ageGroupOverlap => t.ageGroupOverlap(name: name),
    ValidationError.invalidAmount => t.invalidAmount,
    ValidationError.invalidTaxRate => t.invalidTaxRate,
    ValidationError.invalidBedAmount => t.invalidBedAmount,
    ValidationError.duplicateRate => t.duplicateRate,
    ValidationError.inUse => t.inUse,
    ValidationError.invalidGuestCount => t.invalidGuestCount,
    ValidationError.notFound => t.notFound,
    ValidationError.datesRequired => t.datesRequired,
    ValidationError.roomUnavailable => t.roomUnavailable(name: name),
    ValidationError.roomNotHeld => t.roomNotHeld,
    ValidationError.adminRequired => t.adminRequired,
    ValidationError.ownRole => t.ownRole,
    ValidationError.alreadyInvoiced => t.alreadyInvoiced,
    ValidationError.nothingToInvoice => t.nothingToInvoice,
    ValidationError.pricingIncomplete => t.pricingIncomplete,
    ValidationError.notOverpaid => t.notOverpaid,
    ValidationError.alreadyReceipted => t.alreadyReceipted,
    ValidationError.operatorIncomplete => t.operatorIncomplete,
  };
}
