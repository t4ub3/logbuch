import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/pricing/price_calculation.dart';

/// From this age on a guest pays for themselves when a booking is billed
/// per guest.
const adultAge = 18;

/// Decides who pays each of the [lines] of a booking, by its billing mode.
/// Returns the lines by the id of the paying contact.
///
/// - One payer: the lead of the booking pays everything.
/// - Per group: the payer of a group pays for its guests; the lead pays for
///   groups without a payer.
/// - Per guest: adults pay for themselves. Minors, and guests whose age is
///   not known, are paid for like under "per group".
///
/// What is charged for a room, such as the price of a bungalow or its final
/// cleaning, is split evenly between the guests in that room, and so
/// between those who pay for them. Only guests who pay something for their
/// stay count, so not a baby that stays for free. A room without such
/// guests, like a common room, is split between the paying guests of the
/// whole booking.
///
/// What is charged to neither a guest nor a room, such as a fee per
/// booking, always goes to the lead.
///
/// [groups] must come with their guests and the contacts of those.
Map<int, List<ChargeLine>> distributeLines({
  required Booking booking,
  required List<GuestGroup> groups,
  required List<AgeGroup> ageGroups,
  required List<ChargeLine> lines,
}) {
  final guests = [for (final group in groups) ...?group.guests];
  final payers = <int, int>{};
  for (final group in groups) {
    final groupPayer = group.payerId ?? booking.leadId;
    for (final guest in group.guests ?? <Guest>[]) {
      payers[guest.id!] = switch (booking.billingMode) {
        BillingMode.single => booking.leadId,
        BillingMode.perGroup => groupPayer,
        BillingMode.perGuest =>
          _isAdult(guest, booking, ageGroups) ? guest.contactId : groupPayer,
      };
    }
  }
  final paying = {
    for (final line in lines)
      if (line.guestId != null && line.total > 0) line.guestId,
  };

  /// The guests who share what is charged for a room: the first of these
  /// that there are any of.
  List<Guest> sharing(int bookingRoomId) {
    final inRoom = guests.where((g) => g.bookingRoomId == bookingRoomId);
    return [
          inRoom.where((g) => paying.contains(g.id)),
          inRoom,
          guests.where((g) => paying.contains(g.id)),
          guests,
        ]
        .map((found) => found.toList())
        .firstWhere(
          (found) => found.isNotEmpty,
          orElse: () => [],
        );
  }

  final byPayer = <int, List<ChargeLine>>{};
  for (final line in lines) {
    final roomId = line.bookingRoomId;
    final heads = <int, int>{};
    if (line.guestId == null && roomId != null) {
      for (final guest in sharing(roomId)) {
        final payer = payers[guest.id]!;
        heads[payer] = (heads[payer] ?? 0) + 1;
      }
    }
    if (heads.length < 2) {
      final payer =
          heads.keys.firstOrNull ?? payers[line.guestId] ?? booking.leadId;
      byPayer.putIfAbsent(payer, () => []).add(line);
      continue;
    }

    // Each payer gets their part of every cent, so the parts add up.
    final all = heads.values.fold(0, (sum, count) => sum + count);
    var before = 0;
    for (final MapEntry(key: payer, value: count) in heads.entries) {
      final share =
          line.total * (before + count) ~/ all - line.total * before ~/ all;
      before += count;
      byPayer
          .putIfAbsent(payer, () => [])
          .add(
            line.copyWith(
              description: '${line.description} · $count/$all',
              quantity: 1,
              unitPrice: share,
              total: share,
            ),
          );
    }
  }
  return byPayer;
}

/// Goes by the age group the guest is priced with, so that an age group set
/// for a guest without a birth date counts as well.
bool _isAdult(Guest guest, Booking booking, List<AgeGroup> ageGroups) {
  final arrival = guest.arrivalOverride ?? booking.arrival;
  if (arrival == null) return false;
  final ageGroup = resolveAgeGroup(guest, arrival, ageGroups);
  return ageGroup != null && ageGroup.minAge >= adultAge;
}
