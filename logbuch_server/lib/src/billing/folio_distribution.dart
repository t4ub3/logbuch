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
/// What is not charged to a guest, such as a fee per booking, always goes to
/// the lead.
///
/// [groups] must come with their guests and the contacts of those.
Map<int, List<ChargeLine>> distributeLines({
  required Booking booking,
  required List<GuestGroup> groups,
  required List<AgeGroup> ageGroups,
  required List<ChargeLine> lines,
}) {
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

  final byPayer = <int, List<ChargeLine>>{};
  for (final line in lines) {
    final payer = payers[line.guestId] ?? booking.leadId;
    byPayer.putIfAbsent(payer, () => []).add(line);
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
