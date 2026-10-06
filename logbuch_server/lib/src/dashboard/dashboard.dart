import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/pricing/price_calculation.dart';

/// Arrivals and departures are listed for today and this many days after.
const upcomingDays = 6;

/// An option counts as expiring soon this many days before it does.
const optionWarningDays = 14;

/// Puts together what the start screen shows.
///
/// - Arrivals and departures of today and the [upcomingDays] after.
/// - How full the house is tonight.
/// - Options that expire within [optionWarningDays] or have expired.
/// - Invoices that are not paid in full.
/// - Who is to be catered for today and tomorrow. A guest counts on every
///   day of their stay, including the days they arrive and depart.
///
/// Cancelled bookings and bookings without dates take no part, apart from
/// their invoices. A booking without a guest list counts with the number of
/// guests it expects, whose ages are not known.
///
/// [bookings] must come with their lead, their meal plan and the rooms they
/// hold, [guests] by the id of their booking with their contacts, and
/// [invoicedFolios] with payer, booking, charges and payments with the
/// donations made from those.
Dashboard buildDashboard({
  required DateTime today,
  required List<Booking> bookings,
  required Map<int, List<Guest>> guests,
  required List<AgeGroup> ageGroups,
  required int activeRooms,
  required List<Folio> invoicedFolios,
}) {
  final lastDay = today.add(const Duration(days: upcomingDays));
  final stays = [
    for (final booking in bookings)
      if (booking.status != BookingStatus.cancelled)
        if ((booking.arrival, booking.departure) case (
          final arrival?,
          final departure?,
        ))
          (booking: booking, arrival: arrival, departure: departure),
  ];
  bool upcoming(DateTime day) => !day.isBefore(today) && !day.isAfter(lastDay);

  DashboardStay stay(Booking booking, DateTime date) {
    final list = guests[booking.id] ?? [];
    return DashboardStay(
      bookingId: booking.id!,
      title: booking.title,
      status: booking.status,
      date: date,
      leadName: _name(booking.lead),
      guestCount: list.isEmpty ? booking.expectedGuestCount : list.length,
      roomCount: booking.rooms?.length ?? 0,
    );
  }

  int byDate(DashboardStay a, DashboardStay b) {
    final days = a.date.compareTo(b.date);
    return days != 0 ? days : a.title.compareTo(b.title);
  }

  // A room is taken tonight by those who arrived and do not leave today.
  final tonight = stays.where(
    (s) => !s.arrival.isAfter(today) && s.departure.isAfter(today),
  );
  var guestsTonight = 0;
  for (final s in tonight) {
    final list = guests[s.booking.id] ?? [];
    guestsTonight += list.isEmpty
        ? s.booking.expectedGuestCount ?? 0
        : list.where((guest) {
            final from = guest.arrivalOverride ?? s.arrival;
            final to = guest.departureOverride ?? s.departure;
            return !from.isAfter(today) && to.isAfter(today);
          }).length;
  }

  final warnUntil = today.add(const Duration(days: optionWarningDays));
  final expiring = [
    for (final booking in bookings)
      if (booking.status == BookingStatus.option)
        if (booking.optionExpiresAt case final expiry?)
          if (!expiry.isAfter(warnUntil))
            ExpiringOption(
              bookingId: booking.id!,
              title: booking.title,
              expiresAt: expiry,
              arrival: booking.arrival,
            ),
  ]..sort((a, b) => a.expiresAt.compareTo(b.expiresAt));

  final balances = [
    for (final folio in invoicedFolios)
      if (_owed(folio) > 0)
        OpenBalance(
          bookingId: folio.bookingId,
          bookingTitle: folio.booking?.title ?? '',
          invoiceNumber: folio.invoiceNumber ?? '',
          payerName: _name(folio.payer),
          owed: _owed(folio),
        ),
  ]..sort((a, b) => a.invoiceNumber.compareTo(b.invoiceNumber));

  return Dashboard(
    today: today,
    arrivals: [
      for (final s in stays)
        if (upcoming(s.arrival)) stay(s.booking, s.arrival),
    ]..sort(byDate),
    departures: [
      for (final s in stays)
        if (upcoming(s.departure)) stay(s.booking, s.departure),
    ]..sort(byDate),
    roomsOccupied: {
      for (final s in tonight)
        for (final hold in s.booking.rooms ?? <BookingRoom>[]) hold.roomId,
    }.length,
    roomsTotal: activeRooms,
    guestsTonight: guestsTonight,
    expiringOptions: expiring,
    openBalances: balances,
    meals: [
      for (final day in [today, today.add(const Duration(days: 1))])
        _mealDay(
          day,
          [for (final s in stays) s.booking],
          guests,
          [...ageGroups]..sort((a, b) => a.minAge.compareTo(b.minAge)),
        ),
    ],
  );
}

/// Who is in the house on [day], booking by booking and in total.
/// [youngestFirst] are all age groups in that order.
MealDay _mealDay(
  DateTime day,
  List<Booking> bookings,
  Map<int, List<Guest>> guests,
  List<AgeGroup> youngestFirst,
) {
  bool covers(DateTime from, DateTime to) =>
      !from.isAfter(day) && !to.isBefore(day);

  final totals = {for (final ageGroup in youngestFirst) ageGroup.id: 0};
  final entries = <MealBooking>[];
  var totalUnknown = 0;
  for (final booking in bookings) {
    final arrival = booking.arrival!;
    final departure = booking.departure!;
    final list = guests[booking.id] ?? [];
    final counts = <int?, int>{};
    var unknown = 0;
    if (list.isEmpty) {
      // Without a guest list only the expected number is known.
      if (covers(arrival, departure)) unknown = booking.expectedGuestCount ?? 0;
    } else {
      for (final guest in list) {
        final from = guest.arrivalOverride ?? arrival;
        if (!covers(from, guest.departureOverride ?? departure)) continue;
        final ageGroup = resolveAgeGroup(guest, from, youngestFirst);
        if (ageGroup == null) {
          unknown++;
        } else {
          counts[ageGroup.id] = (counts[ageGroup.id] ?? 0) + 1;
        }
      }
    }

    final known = counts.values.fold(0, (sum, count) => sum + count);
    if (known + unknown == 0) continue;
    for (final MapEntry(key: id, value: count) in counts.entries) {
      totals[id] = totals[id]! + count;
    }
    totalUnknown += unknown;
    entries.add(
      MealBooking(
        bookingId: booking.id!,
        title: booking.title,
        mealPlan: booking.mealPlan?.name,
        guestCount: known + unknown,
        // Only the age groups that have guests in this booking.
        ageGroups: [
          for (final ageGroup in youngestFirst)
            if (counts[ageGroup.id] case final count?)
              AgeGroupCount(ageGroup: ageGroup, count: count),
        ],
        unknownAge: unknown,
      ),
    );
  }
  entries.sort((a, b) => a.title.compareTo(b.title));

  return MealDay(
    date: day,
    bookings: entries,
    guestCount: entries.fold(0, (sum, entry) => sum + entry.guestCount),
    ageGroups: [
      for (final ageGroup in youngestFirst)
        AgeGroupCount(ageGroup: ageGroup, count: totals[ageGroup.id]!),
    ],
    unknownAge: totalUnknown,
  );
}

/// What is still to be paid on the folio.
int _owed(Folio folio) {
  var owed = 0;
  for (final charge in folio.charges ?? <Charge>[]) {
    owed += charge.total;
  }
  for (final payment in folio.payments ?? <Payment>[]) {
    owed -= payment.amount;
    for (final donation in payment.donations ?? <Donation>[]) {
      owed += donation.amount;
    }
  }
  return owed;
}

String _name(Contact? contact) =>
    '${contact?.firstName ?? ''} ${contact?.lastName ?? ''}'.trim();
