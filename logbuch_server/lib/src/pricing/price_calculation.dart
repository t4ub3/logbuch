import 'dart:math';

import 'package:logbuch_server/src/generated/protocol.dart';

/// The tax on meals in basis points. Lodging is taxed by the unit type of
/// the room and a fee carries its own rate.
const lodgingTaxRate = 700;

/// How many bookings can share a room before the app warns about it.
const maxSharing = 2;

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

/// The bookings that hold the room during [night] according to [holds],
/// which must come with their bookings.
Iterable<Booking> _sharers(
  DateTime night,
  int roomId,
  List<BookingRoom> holds,
) sync* {
  for (final hold in holds) {
    final other = hold.booking;
    final arrival = other?.arrival;
    final departure = other?.departure;
    if (hold.roomId != roomId || arrival == null || departure == null) {
      continue;
    }
    if (!night.isBefore(arrival) && night.isBefore(departure)) yield other!;
  }
}

/// The largest number of bookings, [booking] included, that hold the room
/// during one of the nights of [booking]. [others] are the holds of the
/// other bookings with their bookings.
int mostSharing(Booking booking, int roomId, List<BookingRoom> others) {
  final arrival = booking.arrival;
  final departure = booking.departure;
  if (arrival == null || departure == null) return 1;
  var most = 1;
  for (var n = arrival; n.isBefore(departure); n = _addDays(n, 1)) {
    most = max(most, 1 + _sharers(n, roomId, others).length);
  }
  return most;
}

/// Calculates what [booking] costs.
///
/// A night is priced by the price list that is in force on the day it
/// starts, so a stay across the first day of a new list is priced with
/// both.
///
/// - Every guest pays lodging per night by the unit type of their room and
///   their age group, and meals by the meal plan of the booking.
/// - A room whose unit type has a price of its own costs that per night,
///   whoever stays in it. A booking that arrives and departs on the same
///   day pays the price for day use instead.
/// - A room that bookings share costs each of them its part of the price
///   for the nights they share it. [sharedHolds] are the holds of the other
///   bookings on such rooms, with their bookings.
/// - The surcharges of the rooms and the fees that every booking is charged
///   come on top. A fee that the price list has no amount for is not
///   charged.
///
/// Nothing is guessed: what cannot be priced is left out and reported as a
/// problem instead.
///
/// [booking] must come with the rooms it holds, [guests] with their
/// contacts and [fees] with the rooms they are a surcharge of.
BookingPrice calculatePrice({
  required Booking booking,
  required List<Guest> guests,
  required List<PriceList> priceLists,
  required List<AgeGroup> ageGroups,
  required List<UnitType> unitTypes,
  required MealPlan? mealPlan,
  required List<RoomRate> roomRates,
  required List<UnitPrice> unitPrices,
  required List<MealRate> mealRates,
  required List<Fee> fees,
  required List<FeePrice> feePrices,
  List<BookingRoom> sharedHolds = const [],
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
  final bookingNights = departure.difference(arrival).inDays;

  final lists = [...priceLists]
    ..sort((a, b) => a.validFrom.compareTo(b.validFrom));
  PriceList? listOn(DateTime day) =>
      lists.where((list) => !list.validFrom.isAfter(day)).lastOrNull;

  /// The nights from [firstNight] on, split by price list. Nights that no
  /// list prices are reported and left out.
  List<_Segment> segments(DateTime firstNight, int nights) {
    final priced = <_Segment>[];
    for (final segment in _segments(firstNight, nights, listOn)) {
      if (segment.list == null) {
        report(
          PricingProblemReason.priceListMissing,
          detail: _isoDay(segment.firstNight),
        );
      } else {
        priced.add(segment);
      }
    }
    return priced;
  }

  /// The list that prices what is charged once on [day].
  PriceList? listFor(DateTime day) {
    final list = listOn(day);
    if (list == null) {
      report(PricingProblemReason.priceListMissing, detail: _isoDay(day));
    }
    return list;
  }

  final holds = booking.rooms ?? <BookingRoom>[];
  final rooms = {for (final hold in holds) hold.id: hold.room};
  final types = {for (final type in unitTypes) type.id: type};
  final guestPrices = {
    for (final r in roomRates)
      (r.priceListId, r.unitTypeId, r.ageGroupId): r.pricePerNight,
  };
  // The unit types whose guests pay per night, by price list.
  final pricedPerGuest = {
    for (final r in roomRates) (r.priceListId, r.unitTypeId),
  };
  final unitPriceOf = {
    for (final p in unitPrices) (p.priceListId, p.unitTypeId): p,
  };
  final mealPrices = {
    for (final r in mealRates)
      (r.priceListId, r.mealPlanId, r.ageGroupId): r.pricePerNight,
  };
  final feeAmounts = {
    for (final p in feePrices) (p.priceListId, p.feeId): p.amount,
  };

  final guestFrom = <int?, DateTime>{};
  final guestNights = <int?, int>{};
  final guestAgeGroups = <int?, AgeGroup?>{};
  for (final guest in guests) {
    final from = guest.arrivalOverride ?? arrival;
    final to = guest.departureOverride ?? departure;
    final nights = max(0, to.difference(from).inDays);
    final ageGroup = resolveAgeGroup(guest, from, ageGroups);
    guestFrom[guest.id] = from;
    guestNights[guest.id] = nights;
    guestAgeGroups[guest.id] = ageGroup;

    if (ageGroup == null) {
      report(PricingProblemReason.ageUnknown, guestId: guest.id);
      continue;
    }
    final room = rooms[guest.bookingRoomId];
    if (room == null) {
      report(PricingProblemReason.roomMissing, guestId: guest.id);
    }
    final type = types[room?.unitTypeId];

    for (final segment in segments(from, nights)) {
      final list = segment.list!;
      if (type != null) {
        final names = '${type.name} · ${ageGroup.name}';
        final price = guestPrices[(list.id, type.id, ageGroup.id)];
        // Guests may stay for free in a unit that has a price of its own,
        // but only if the list prices no guest of the unit type at all.
        final included =
            !pricedPerGuest.contains((list.id, type.id)) &&
            unitPriceOf[(list.id, type.id)]?.pricePerNight != null;
        if (price != null) {
          lines.add(
            _nights(
              ChargeType.lodging,
              names,
              segment,
              price,
              type.taxRate,
              guestId: guest.id,
            ),
          );
        } else if (!included) {
          report(PricingProblemReason.roomRateMissing, detail: names);
        }
      }
      if (mealPlan != null) {
        final names = '${mealPlan.name} · ${ageGroup.name}';
        final price = mealPrices[(list.id, mealPlan.id, ageGroup.id)];
        if (price != null) {
          lines.add(
            _nights(
              ChargeType.meal,
              names,
              segment,
              price,
              lodgingTaxRate,
              guestId: guest.id,
            ),
          );
        } else {
          report(PricingProblemReason.mealRateMissing, detail: names);
        }
      }
    }
  }

  // What the rooms cost by themselves.
  for (final hold in holds) {
    final room = hold.room;
    final type = types[room?.unitTypeId];
    if (room == null || type == null) continue;
    final name = '${type.name} · ${room.roomNumber}';

    if (bookingNights <= 0) {
      final list = listFor(arrival);
      if (list == null) continue;
      final price = unitPriceOf[(list.id, type.id)]?.dayUsePrice;
      if (price == null) {
        report(PricingProblemReason.dayUsePriceMissing, detail: type.name);
        continue;
      }
      lines.add(
        ChargeLine(
          bookingRoomId: hold.id,
          type: ChargeType.lodging,
          description: name,
          quantity: 1,
          unitPrice: price,
          total: price,
          taxRate: type.taxRate,
        ),
      );
      continue;
    }

    for (final segment in segments(arrival, bookingNights)) {
      final list = segment.list!;
      final price = unitPriceOf[(list.id, type.id)]?.pricePerNight;
      if (price == null) {
        // Fine if the guests pay for the room; they are checked above.
        if (!pricedPerGuest.contains((list.id, type.id))) {
          report(PricingProblemReason.roomRateMissing, detail: type.name);
        }
        continue;
      }
      for (final part in _shares(segment, booking, room.id!, sharedHolds)) {
        // Each booking pays its part of every cent, in the order of their
        // ids, so that the parts add up to the price.
        final share =
            price * (part.rank + 1) ~/ part.sharers -
            price * part.rank ~/ part.sharers;
        lines.add(
          _nights(
            ChargeType.lodging,
            part.sharers > 1 ? '$name · 1/${part.sharers}' : name,
            (list: list, firstNight: part.firstNight, nights: part.nights),
            share,
            type.taxRate,
            bookingRoomId: hold.id,
          ),
        );
      }
    }
  }

  /// Charges [fee] [count] times by the list of [day], if that has an
  /// amount for it.
  void once(
    Fee fee,
    DateTime day, {
    int count = 1,
    int? guestId,
    BookingRoom? hold,
  }) {
    if (count <= 0) return;
    final list = listFor(day);
    final amount = feeAmounts[(list?.id, fee.id)];
    if (list == null || amount == null) return;
    lines.add(
      ChargeLine(
        guestId: guestId,
        bookingRoomId: hold?.id,
        type: ChargeType.fee,
        description: _feeName(fee, hold),
        quantity: count,
        unitPrice: amount,
        total: amount * count,
        taxRate: fee.taxRate,
      ),
    );
  }

  /// Charges [fee] [count] times for each of the [nights] from [from] on.
  void nightly(
    Fee fee,
    DateTime from,
    int nights, {
    int count = 1,
    int? guestId,
    BookingRoom? hold,
  }) {
    if (count <= 0) return;
    for (final segment in segments(from, nights)) {
      final amount = feeAmounts[(segment.list!.id, fee.id)];
      if (amount == null) continue;
      lines.add(
        ChargeLine(
          guestId: guestId,
          bookingRoomId: hold?.id,
          type: ChargeType.fee,
          description: _feeName(fee, hold),
          quantity: count * segment.nights,
          unitPrice: amount,
          total: amount * count * segment.nights,
          taxRate: fee.taxRate,
        ),
      );
    }
  }

  // A fee for one age group is not charged to guests of unknown age; those
  // are reported above.
  bool pays(Guest guest, Fee fee) =>
      fee.ageGroupId == null || guestAgeGroups[guest.id]?.id == fee.ageGroupId;

  // The surcharges of the rooms.
  for (final hold in holds) {
    final inRoom = guests.where((guest) => guest.bookingRoomId == hold.id);
    for (final fee in fees) {
      final isSurcharge =
          !fee.autoApply &&
          (fee.rooms ?? []).any((room) => room.roomId == hold.roomId);
      if (!isSurcharge) continue;
      switch (fee.unit) {
        case FeeUnit.perBooking:
          break;
        case FeeUnit.perPerson:
          for (final guest in inRoom.where((guest) => pays(guest, fee))) {
            once(fee, guestFrom[guest.id]!, guestId: guest.id);
          }
        case FeeUnit.perPersonNight:
          for (final guest in inRoom.where((guest) => pays(guest, fee))) {
            nightly(
              fee,
              guestFrom[guest.id]!,
              guestNights[guest.id]!,
              guestId: guest.id,
            );
          }
        case FeeUnit.perRoom:
          once(fee, arrival, hold: hold);
        case FeeUnit.perRoomNight:
          nightly(fee, arrival, bookingNights, hold: hold);
      }
    }
  }

  // The fees that every booking is charged.
  for (final fee in fees.where((fee) => fee.autoApply)) {
    final payers = guests.where((guest) => pays(guest, fee));
    switch (fee.unit) {
      case FeeUnit.perBooking:
        once(fee, arrival);
      case FeeUnit.perPerson:
        for (final guest in payers) {
          once(fee, guestFrom[guest.id]!, guestId: guest.id);
        }
      case FeeUnit.perPersonNight:
        for (final guest in payers) {
          nightly(
            fee,
            guestFrom[guest.id]!,
            guestNights[guest.id]!,
            guestId: guest.id,
          );
        }
      case FeeUnit.perRoom:
        once(fee, arrival, count: holds.length);
      case FeeUnit.perRoomNight:
        nightly(fee, arrival, bookingNights, count: holds.length);
    }
  }

  return BookingPrice(
    lines: lines,
    total: lines.fold(0, (total, line) => total + line.total),
    problems: problems,
  );
}

/// Consecutive nights that the same price list prices, or none.
typedef _Segment = ({PriceList? list, DateTime firstNight, int nights});

/// Splits the [nights] from [firstNight] on by the price list in force.
List<_Segment> _segments(
  DateTime firstNight,
  int nights,
  PriceList? Function(DateTime day) listOn,
) {
  final segments = <_Segment>[];
  for (var i = 0; i < nights; i++) {
    final night = _addDays(firstNight, i);
    final list = listOn(night);
    if (segments.isNotEmpty && segments.last.list?.id == list?.id) {
      final last = segments.removeLast();
      segments.add((
        list: last.list,
        firstNight: last.firstNight,
        nights: last.nights + 1,
      ));
    } else {
      segments.add((list: list, firstNight: night, nights: 1));
    }
  }
  return segments;
}

/// Consecutive nights that a room is shared by the same number of bookings,
/// of which [rank] have a lower id than the booking that is priced.
typedef _Share = ({DateTime firstNight, int nights, int sharers, int rank});

/// Splits the nights of [segment] by who shares the room with [booking].
List<_Share> _shares(
  _Segment segment,
  Booking booking,
  int roomId,
  List<BookingRoom> sharedHolds,
) {
  final shares = <_Share>[];
  for (var i = 0; i < segment.nights; i++) {
    final night = _addDays(segment.firstNight, i);
    final others = _sharers(night, roomId, sharedHolds).toList();
    final sharers = others.length + 1;
    final rank = others.where((other) => other.id! < booking.id!).length;
    final last = shares.lastOrNull;
    if (last != null && last.sharers == sharers && last.rank == rank) {
      shares.removeLast();
      shares.add((
        firstNight: last.firstNight,
        nights: last.nights + 1,
        sharers: sharers,
        rank: rank,
      ));
    } else {
      shares.add((firstNight: night, nights: 1, sharers: sharers, rank: rank));
    }
  }
  return shares;
}

/// A line for the nights of [segment] at [price] each.
ChargeLine _nights(
  ChargeType type,
  String description,
  _Segment segment,
  int price,
  int taxRate, {
  int? guestId,
  int? bookingRoomId,
}) => ChargeLine(
  guestId: guestId,
  bookingRoomId: bookingRoomId,
  type: type,
  description: description,
  quantity: segment.nights,
  unitPrice: price,
  total: price * segment.nights,
  taxRate: taxRate,
  periodFrom: segment.firstNight,
  periodTo: _addDays(segment.firstNight, segment.nights),
);

/// A fee that is charged for a room says which one.
String _feeName(Fee fee, BookingRoom? hold) => switch (hold?.room) {
  final room? => '${fee.name} · ${room.roomNumber}',
  null => fee.name,
};

String _isoDay(DateTime day) => day.toIso8601String().substring(0, 10);

/// Dates are midnight UTC, where every day has 24 hours.
DateTime _addDays(DateTime date, int days) => date.add(Duration(days: days));
