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

Guest _guest(int id, {DateTime? born, int? ageGroup, int? room}) => Guest(
  id: id,
  groupId: 1,
  // Every guest is their own contact, with an id ten times their own.
  contactId: id * 10,
  contact: Contact(firstName: 'G', lastName: '$id', birthDate: born),
  ageGroupOverrideId: ageGroup,
  bookingRoomId: room,
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

  group('Given something that is charged for a room', () {
    // A bungalow with two adults of the Webers, their baby and an adult of
    // the Wagners, and a common room that nobody sleeps in.
    const bungalow = 31;
    const commonRoom = 32;
    final mother = _guest(1, born: DateTime.utc(1984, 5, 17), room: bungalow);
    final father = _guest(2, born: DateTime.utc(1982, 1, 9), room: bungalow);
    final baby = _guest(3, born: DateTime.utc(2027, 1, 1), room: bungalow);
    final uncle = _guest(5, born: DateTime.utc(1975, 1, 1), room: bungalow);
    final elsewhere = _guest(6, born: DateTime.utc(1970, 1, 1), room: 33);

    ChargeLine stay(Guest guest, int total) => ChargeLine(
      guestId: guest.id,
      type: ChargeType.lodging,
      description: 'Stay',
      quantity: 1,
      unitPrice: total,
      total: total,
      taxRate: 700,
    );

    /// What each payer is charged for a line of [total] for [room].
    Map<int, List<(String, int, int)>> split(
      BillingMode mode,
      int room,
      int total,
    ) {
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
            guests: [mother, father, baby],
          ),
          GuestGroup(
            id: 2,
            bookingId: 1,
            name: 'Wagner',
            guests: [uncle, elsewhere],
          ),
        ],
        ageGroups: _ageGroups,
        lines: [
          stay(mother, 100),
          stay(father, 100),
          // The baby stays for free.
          stay(baby, 0),
          stay(uncle, 100),
          stay(elsewhere, 100),
          ChargeLine(
            bookingRoomId: room,
            type: ChargeType.lodging,
            description: 'Bungalow',
            quantity: 2,
            unitPrice: total ~/ 2,
            total: total,
            taxRate: 700,
          ),
        ],
      );
      return {
        for (final MapEntry(key: payer, value: lines) in byPayer.entries)
          if (lines.any((line) => line.bookingRoomId != null))
            payer: [
              for (final line in lines)
                if (line.bookingRoomId != null)
                  (line.description, line.quantity, line.total),
            ],
      };
    }

    test('when the booking is billed to one payer '
        'then the lead pays it as it is', () {
      expect(split(BillingMode.single, bungalow, 9000), {
        _lead: [('Bungalow', 2, 9000)],
      });
    });

    test('when the booking is billed per group '
        'then each payer pays for the paying guests of theirs in the room', () {
      expect(split(BillingMode.perGroup, bungalow, 9000), {
        _weberPayer: [('Bungalow · 2/3', 1, 6000)],
        _lead: [('Bungalow · 1/3', 1, 3000)],
      });
    });

    test('when the booking is billed per guest '
        'then the paying guests in the room share it evenly '
        'and the parts add up', () {
      expect(split(BillingMode.perGuest, bungalow, 10000), {
        mother.contactId: [('Bungalow · 1/3', 1, 3333)],
        father.contactId: [('Bungalow · 1/3', 1, 3333)],
        uncle.contactId: [('Bungalow · 1/3', 1, 3334)],
      });
    });

    test('when nobody sleeps in the room '
        'then the paying guests of the booking share it', () {
      expect(split(BillingMode.perGroup, commonRoom, 8000), {
        _weberPayer: [('Bungalow · 2/4', 1, 4000)],
        _lead: [('Bungalow · 2/4', 1, 4000)],
      });
    });
  });
}
