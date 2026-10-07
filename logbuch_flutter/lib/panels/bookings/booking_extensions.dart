import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:yaru/yaru.dart';

/// The color of a booking that has no category.
const _noCategoryColor = Color(0xFF8E8E8E);

extension BookingCategoryColorX on BookingCategoryColor {
  /// The Yaru accent color of the same name.
  Color get color => YaruVariant.values.byName(name).color;
}

extension BookingCategoryIconX on BookingCategoryIcon {
  IconData get data => switch (this) {
    BookingCategoryIcon.calendar => YaruIcons.calendar,
    BookingCategoryIcon.users => YaruIcons.users,
    BookingCategoryIcon.family => YaruIcons.familly,
    BookingCategoryIcon.education => YaruIcons.education,
    BookingCategoryIcon.book => YaruIcons.book,
    BookingCategoryIcon.presentation => YaruIcons.office_presentation,
    BookingCategoryIcon.music => YaruIcons.music_note,
    BookingCategoryIcon.sport => YaruIcons.basketball,
    BookingCategoryIcon.tree => YaruIcons.tree,
    BookingCategoryIcon.compass => YaruIcons.compass,
    BookingCategoryIcon.sun => YaruIcons.sun,
    BookingCategoryIcon.heart => YaruIcons.heart,
    BookingCategoryIcon.star => YaruIcons.star,
    BookingCategoryIcon.home => YaruIcons.home,
    BookingCategoryIcon.puzzle => YaruIcons.puzzle_piece,
    BookingCategoryIcon.flag => YaruIcons.flag,
  };
}

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

  /// The color of the category of the booking, which tells bookings apart
  /// in calendars. Without a category it is grey.
  Color get color => category?.color.color ?? _noCategoryColor;

  /// The icon of the category of the booking.
  IconData get icon => category?.icon.data ?? YaruIcons.calendar;

  String get leadName => lead?.fullName ?? '';

  /// Whether the booking can be confirmed in writing: it has dates and is
  /// an option or confirmed, as the server requires.
  bool get canBeConfirmed =>
      arrival != null &&
      departure != null &&
      status != BookingStatus.inquiry &&
      status != BookingStatus.cancelled;

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
