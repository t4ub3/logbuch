import 'package:logbuch_server/src/generated/protocol.dart';

/// The rooms of a booking, by the ids of its `BookingRoom`s, that an invoice
/// charges for another split between bookings than the one in force now.
///
/// [invoiced] are the charges of the invoice and [current] the lines its
/// payer would be charged today. Only the nights and the number of bookings
/// that split them are compared, not the amounts, so a price that changed
/// since does not count. A room that only one of the two charges is left
/// out as well: it was taken or given up after the invoice, which is not
/// about sharing.
Set<int> outdatedHolds({
  required List<Charge> invoiced,
  required List<ChargeLine> current,
}) {
  final before = <int, Set<_Split>>{};
  for (final charge in invoiced) {
    final hold = charge.bookingRoomId;
    if (hold == null || charge.guestId != null) continue;
    if (charge.type != ChargeType.lodging) continue;
    before.putIfAbsent(hold, () => {}).add((
      from: charge.periodFrom,
      to: charge.periodTo,
      sharers: charge.sharers ?? 1,
    ));
  }
  final now = <int, Set<_Split>>{};
  for (final line in current) {
    final hold = line.bookingRoomId;
    if (hold == null || line.guestId != null) continue;
    if (line.type != ChargeType.lodging) continue;
    now.putIfAbsent(hold, () => {}).add((
      from: line.periodFrom,
      to: line.periodTo,
      sharers: line.sharers ?? 1,
    ));
  }

  return {
    for (final MapEntry(key: hold, value: splits) in before.entries)
      if (now[hold] case final wanted?)
        if (_shared(splits) || _shared(wanted))
          if (splits.length != wanted.length || !splits.containsAll(wanted))
            hold,
  };
}

/// Nights of a room and how many bookings split their price.
typedef _Split = ({DateTime? from, DateTime? to, int sharers});

bool _shared(Set<_Split> splits) => splits.any((split) => split.sharers > 1);
