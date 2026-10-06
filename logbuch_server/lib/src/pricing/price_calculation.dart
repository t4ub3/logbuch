import 'package:logbuch_server/src/generated/protocol.dart';

/// The tax on lodging and meals in basis points. Fees carry their own rate.
const lodgingTaxRate = 700;

/// The age in full years that someone born on [birthDate] has on [date].
int ageOn(DateTime birthDate, DateTime date) {
  final hadBirthday =
      date.month > birthDate.month ||
      (date.month == birthDate.month && date.day >= birthDate.day);
  return date.year - birthDate.year - (hadBirthday ? 0 : 1);
}

/// The age group a guest is priced with: the override of the guest, or else
/// the group of the age the contact has on the day of [arrival]. Null if
/// neither is known or no group covers the age.
AgeGroup? resolveAgeGroup(
  Guest guest,
  DateTime arrival,
  List<AgeGroup> ageGroups,
) {
  if (guest.ageGroupOverrideId case final id?) {
    return ageGroups.where((group) => group.id == id).firstOrNull;
  }
  final birthDate = guest.contact?.birthDate;
  if (birthDate == null) return null;
  final age = ageOn(birthDate, arrival);
  return ageGroups.where((group) {
    final maxAge = group.maxAge;
    return group.minAge <= age && (maxAge == null || age <= maxAge);
  }).firstOrNull;
}

/// Calculates what [booking] costs.
///
/// Every guest pays lodging by the price category of their room and meals by
/// the meal plan of the booking, both by their age group and per night. A
/// stay that spans seasons is priced with the rate of each night. Fees that
/// are added to every booking come on top.
///
/// Nothing is guessed: what cannot be priced is left out and reported as a
/// problem instead.
///
/// [booking] must come with the rooms it holds and [guests] with their
/// contacts.
BookingPrice calculatePrice({
  required Booking booking,
  required List<Guest> guests,
  required List<Season> seasons,
  required List<AgeGroup> ageGroups,
  required List<PriceCategory> priceCategories,
  required MealPlan? mealPlan,
  required List<RoomRate> roomRates,
  required List<MealRate> mealRates,
  required List<Fee> fees,
}) {
  final lines = <ChargeLine>[];
  final problems = <PricingProblem>[];
  void report(PricingProblemReason reason, {int? guestId, String? detail}) {
    final known = problems.any(
      (p) => p.reason == reason && p.guestId == guestId && p.detail == detail,
    );
    if (known) return;
    problems.add(
      PricingProblem(reason: reason, guestId: guestId, detail: detail),
    );
  }

  final arrival = booking.arrival;
  final departure = booking.departure;
  if (arrival == null || departure == null) {
    report(PricingProblemReason.datesMissing);
    return BookingPrice(lines: lines, total: 0, problems: problems);
  }

  final rooms = {
    for (final hold in booking.rooms ?? <BookingRoom>[]) hold.id: hold.room,
  };
  final categories = {for (final c in priceCategories) c.id: c};
  final roomPrices = {
    for (final r in roomRates)
      (r.seasonId, r.priceCategoryId, r.ageGroupId): r.pricePerNight,
  };
  final mealPrices = {
    for (final r in mealRates)
      (r.seasonId, r.mealPlanId, r.ageGroupId): r.pricePerNight,
  };

  /// Adds a line for nights of one season, or reports the missing rate.
  void addNights(
    ChargeType type,
    Guest guest,
    _Segment segment,
    int? price,
    List<String> names,
    PricingProblemReason missing,
  ) {
    if (price == null) {
      return report(missing, detail: names.join(' · '));
    }
    lines.add(
      ChargeLine(
        guestId: guest.id,
        type: type,
        description: names.join(' · '),
        quantity: segment.nights,
        unitPrice: price,
        total: price * segment.nights,
        taxRate: lodgingTaxRate,
        periodFrom: segment.firstNight,
        periodTo: _addDays(segment.firstNight, segment.nights),
      ),
    );
  }

  final guestNights = <int?, int>{};
  final guestAgeGroups = <int?, AgeGroup?>{};
  for (final guest in guests) {
    final from = guest.arrivalOverride ?? arrival;
    final to = guest.departureOverride ?? departure;
    final nights = to.difference(from).inDays;
    final ageGroup = resolveAgeGroup(guest, from, ageGroups);
    guestNights[guest.id] = nights > 0 ? nights : 0;
    guestAgeGroups[guest.id] = ageGroup;

    if (ageGroup == null) {
      report(PricingProblemReason.ageUnknown, guestId: guest.id);
      continue;
    }
    final room = rooms[guest.bookingRoomId];
    if (room == null) {
      report(PricingProblemReason.roomMissing, guestId: guest.id);
    }

    for (final segment in _segments(from, nights, seasons)) {
      final season = segment.season;
      if (season == null) {
        report(
          PricingProblemReason.seasonMissing,
          detail: segment.firstNight.toIso8601String().substring(0, 10),
        );
        continue;
      }
      if (room != null) {
        final category = categories[room.priceCategoryId];
        addNights(
          ChargeType.lodging,
          guest,
          segment,
          roomPrices[(season.id, room.priceCategoryId, ageGroup.id)],
          [?category?.name, ageGroup.name, season.name],
          PricingProblemReason.roomRateMissing,
        );
      }
      if (mealPlan != null) {
        addNights(
          ChargeType.meal,
          guest,
          segment,
          mealPrices[(season.id, mealPlan.id, ageGroup.id)],
          [mealPlan.name, ageGroup.name, season.name],
          PricingProblemReason.mealRateMissing,
        );
      }
    }
  }

  void addFee(Fee fee, int quantity, {int? guestId}) {
    if (quantity <= 0) return;
    lines.add(
      ChargeLine(
        guestId: guestId,
        type: ChargeType.fee,
        description: fee.name,
        quantity: quantity,
        unitPrice: fee.amount,
        total: fee.amount * quantity,
        taxRate: fee.taxRate,
      ),
    );
  }

  final bookingNights = departure.difference(arrival).inDays;
  for (final fee in fees.where((fee) => fee.autoApply)) {
    // A fee for one age group is not charged to guests of unknown age;
    // those are reported above.
    final payers = guests.where(
      (guest) =>
          fee.ageGroupId == null ||
          guestAgeGroups[guest.id]?.id == fee.ageGroupId,
    );
    switch (fee.unit) {
      case FeeUnit.perBooking:
        addFee(fee, 1);
      case FeeUnit.perPerson:
        for (final guest in payers) {
          addFee(fee, 1, guestId: guest.id);
        }
      case FeeUnit.perPersonNight:
        for (final guest in payers) {
          addFee(fee, guestNights[guest.id]!, guestId: guest.id);
        }
      case FeeUnit.perRoom:
        addFee(fee, rooms.length);
      case FeeUnit.perRoomNight:
        addFee(fee, rooms.length * bookingNights);
    }
  }

  return BookingPrice(
    lines: lines,
    total: lines.fold(0, (total, line) => total + line.total),
    problems: problems,
  );
}

/// Consecutive nights that fall into the same season, or into none.
typedef _Segment = ({Season? season, DateTime firstNight, int nights});

/// Splits the [nights] from [firstNight] on by season. A night belongs to
/// the season of the day it starts on.
List<_Segment> _segments(
  DateTime firstNight,
  int nights,
  List<Season> seasons,
) {
  final segments = <_Segment>[];
  for (var i = 0; i < nights; i++) {
    final night = _addDays(firstNight, i);
    final season = seasons
        .where((s) => !night.isBefore(s.validFrom) && !night.isAfter(s.validTo))
        .firstOrNull;
    if (segments.isNotEmpty && segments.last.season?.id == season?.id) {
      final last = segments.removeLast();
      segments.add((
        season: last.season,
        firstNight: last.firstNight,
        nights: last.nights + 1,
      ));
    } else {
      segments.add((season: season, firstNight: night, nights: 1));
    }
  }
  return segments;
}

/// Dates are midnight UTC, where every day has 24 hours.
DateTime _addDays(DateTime date, int days) => date.add(Duration(days: days));
