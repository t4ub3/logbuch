import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_client/logbuch_client.dart';

const _bookingColors = [
  Color(0xFF1E88E5), // blue
  Color(0xFF00897B), // teal
  Color(0xFFF4511E), // deep orange
  Color(0xFF8E24AA), // purple
  Color(0xFF43A047), // green
  Color(0xFFD81B60), // pink
  Color(0xFF3949AB), // indigo
  Color(0xFFFF8F00), // amber
];

extension BookingX on Booking {
  /// First day of the booking (local, date only), or null if undated.
  DateTime? get startDay {
    final start = from ?? to;
    return start == null ? null : DateUtils.dateOnly(start.toLocal());
  }

  /// Last day of the booking (local, date only), or null if undated.
  DateTime? get endDay {
    final end = to ?? from;
    return end == null ? null : DateUtils.dateOnly(end.toLocal());
  }

  /// Whether the booking covers the given [day].
  bool coversDay(DateTime day) {
    final start = startDay;
    final end = endDay;
    if (start == null || end == null) return false;
    final d = DateUtils.dateOnly(day);
    return !d.isBefore(start) && !d.isAfter(end);
  }

  /// A stable color per booking, used to tell bookings apart in calendars.
  Color get color => _bookingColors[(id ?? 0) % _bookingColors.length];

  String get leadName => '${lead.firstName} ${lead.lastName}';

  String leadLabel(BuildContext context) =>
      context.t.bookings.lead(name: leadName);

  String? dateRangeLabel(BuildContext context) {
    final l10n = MaterialLocalizations.of(context);
    final start = startDay;
    final end = endDay;
    if (start == null || end == null) return null;
    if (start == end) return l10n.formatShortDate(start);
    return '${l10n.formatShortDate(start)} – ${l10n.formatShortDate(end)}';
  }
}

/// Orders bookings by start day; undated bookings come last.
int compareByStart(Booking a, Booking b) {
  final aStart = a.startDay;
  final bStart = b.startDay;
  if (aStart == null) return bStart == null ? 0 : 1;
  if (bStart == null) return -1;
  return aStart.compareTo(bStart);
}

extension BookingStatusX on BookingStatus {
  String label(BuildContext context) {
    final t = context.t.bookings.statuses;
    return switch (this) {
      BookingStatus.requested => t.requested,
      BookingStatus.booked => t.booked,
      BookingStatus.billed => t.billed,
      BookingStatus.paid => t.paid,
    };
  }
}
