import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';

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
  /// Day of arrival (local, date only), or null if undated.
  DateTime? get startDay => switch (arrival) {
    final arrival? => toLocalDate(arrival),
    null => null,
  };

  /// Day of departure (local, date only), or null if undated. Calendars
  /// show the booking up to and including this day.
  DateTime? get endDay => switch (departure) {
    final departure? => toLocalDate(departure),
    null => null,
  };

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

  String get leadName => lead?.fullName ?? '';

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

/// Distributes the [bookings] that overlap the days [first] to [last] over
/// lanes, so that bookings in the same lane never overlap and each one can
/// be drawn as a straight bar. [bookings] must be sorted by [compareByStart].
List<List<Booking>> assignLanes(
  List<Booking> bookings,
  DateTime first,
  DateTime last,
) {
  final lanes = <List<Booking>>[];
  for (final booking in bookings) {
    final start = booking.startDay;
    final end = booking.endDay;
    if (start == null || end == null) continue;
    if (start.isAfter(last) || end.isBefore(first)) continue;
    final lane = lanes.where((l) => l.last.endDay!.isBefore(start));
    if (lane.isEmpty) {
      lanes.add([booking]);
    } else {
      lane.first.add(booking);
    }
  }
  return lanes;
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
      BookingStatus.inquiry => t.inquiry,
      BookingStatus.option => t.option,
      BookingStatus.confirmed => t.confirmed,
      BookingStatus.checkedIn => t.checkedIn,
      BookingStatus.completed => t.completed,
      BookingStatus.cancelled => t.cancelled,
    };
  }

  /// Whether the booking is not agreed on yet. Such bookings hold their
  /// rooms, but are drawn hatched.
  bool get isTentative =>
      this == BookingStatus.inquiry || this == BookingStatus.option;
}

extension BillingModeX on BillingMode {
  String label(BuildContext context) {
    final t = context.t.bookings.billingModes;
    return switch (this) {
      BillingMode.single => t.single,
      BillingMode.perGroup => t.perGroup,
      BillingMode.perGuest => t.perGuest,
    };
  }
}
