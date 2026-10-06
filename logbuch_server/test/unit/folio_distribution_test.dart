import 'package:logbuch_server/src/billing/folio_distribution.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

// The lead of the booking is contact 1. The Webers have a payer, contact 2;
// the Wagners have none.
const _lead = 1;
const _weberPayer = 2;

final _ageGroups = [
  AgeGroup(id: 1, name: 'Child', minAge: 0, maxAge: 17),
  AgeGroup(id: 2, name: 'Adult', minAge: 18),
];

Guest _guest(int id, {DateTime? born, int? ageGroup}) => Guest(
  id: id,
  groupId: 1,
  // Every guest is their own contact, with an id ten times their own.
  contactId: id * 10,
  contact: Contact(firstName: 'G', lastName: '$id', birthDate: born),
  ageGroupOverrideId: ageGroup,
);

final _mother = _guest(1, born: DateTime.utc(1984, 5, 17));
final _son = _guest(2, born: DateTime.utc(2019, 3, 3));
final _aunt = _guest(3, ageGroup: 2);
final _stranger = _guest(4);
final _uncle = _guest(5, born: DateTime.utc(1975, 1, 1));

ChargeLine _line(int? guestId) => ChargeLine(
  guestId: guestId,
  type: guestId == null ? ChargeType.fee : ChargeType.lodging,
  description: 'Line',
  quantity: 1,
  unitPrice: 100,
  total: 100,
  taxRate: 700,
);

/// The ids of the guests whose lines each payer gets; null is a line of the
/// whole booking.
Map<int, List<int?>> _distribute(BillingMode mode) {
  final byPayer = distributeLines(
    booking: Booking(
      id: 1,
      title: 'Camp',
      leadId: _lead,
      arrival: DateTime.utc(2027, 5, 10),
      departure: DateTime.utc(2027, 5, 13),
      billingMode: mode,
    ),
    groups: [
      GuestGroup(
        id: 1,
        bookingId: 1,
        name: 'Weber',
        payerId: _weberPayer,
        guests: [_mother, _son, _aunt, _stranger],
      ),
      GuestGroup(id: 2, bookingId: 1, name: 'Wagner', guests: [_uncle]),
    ],
    ageGroups: _ageGroups,
    lines: [
      for (final guest in [_mother, _son, _aunt, _stranger, _uncle])
        _line(guest.id),
      _line(null),
    ],
  );
  return {
    for (final MapEntry(key: payer, value: lines) in byPayer.entries)
      payer: [for (final line in lines) line.guestId],
  };
}

void main() {
  test('Given a booking billed to one payer '
      'when distributing then the lead pays everything', () {
    expect(_distribute(BillingMode.single), {
      _lead: [1, 2, 3, 4, 5, null],
    });
  });

  test('Given a booking billed per group '
      'when distributing then each group payer pays for the group '
      'and the lead for groups without one', () {
    expect(_distribute(BillingMode.perGroup), {
      _weberPayer: [1, 2, 3, 4],
      _lead: [5, null],
    });
  });

  test('Given a booking billed per guest '
      'when distributing then adults pay for themselves '
      'and the others are paid for like their group', () {
    expect(_distribute(BillingMode.perGuest), {
      // The mother by her age and the aunt by her age group.
      _mother.contactId: [1],
      _aunt.contactId: [3],
      // The son is a minor, and nobody knows the age of the stranger.
      _weberPayer: [2, 4],
      _uncle.contactId: [5],
      _lead: [null],
    });
  });
}
