import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/pricing/price_calculation.dart';
import 'package:test/test.dart';

// Two price lists that follow each other, two age groups, one meal plan and
// four unit types: rooms whose guests pay, bungalows that cost by themselves
// and per guest, and a hall that bookings share.
final _old = PriceList(id: 1, name: '2027', validFrom: DateTime.utc(2027));
final _new = PriceList(
  id: 2,
  name: 'From July',
  validFrom: DateTime.utc(2027, 7, 1),
);
final _child = AgeGroup(id: 1, name: 'Child', minAge: 0, maxAge: 17);
final _adult = AgeGroup(id: 2, name: 'Adult', minAge: 18);
final _standard = UnitType(id: 1, name: 'Standard');
final _comfort = UnitType(id: 2, name: 'Comfort');
final _bungalow = UnitType(id: 3, name: 'Bungalow', taxRate: 1900);
final _hall = UnitType(id: 4, name: 'Hall', shared: true);
final _fullBoard = MealPlan(id: 1, name: 'Full board');

BookingRoom _hold(int id, String number, UnitType type, {int bookingId = 1}) =>
    BookingRoom(
      id: id,
      bookingId: bookingId,
      // The room of hold 11 has the id 1, and so on.
      roomId: id - 10,
      room: Room(
        id: id - 10,
        roomNumber: number,
        bedAmount: 4,
        unitTypeId: type.id!,
      ),
    );

/// The rooms of the booking by the id of their hold.
final _room101 = _hold(11, '101', _standard);
final _room201 = _hold(12, '201', _comfort);
final _bungalow1 = _hold(13, 'B1', _bungalow);
final _hall1 = _hold(14, 'H1', _hall);

RoomRate _roomRate(PriceList list, UnitType type, AgeGroup age, int price) =>
    RoomRate(
      priceListId: list.id!,
      unitTypeId: type.id!,
      ageGroupId: age.id!,
      pricePerNight: price,
    );

MealRate _mealRate(PriceList list, AgeGroup age, int price) => MealRate(
  priceListId: list.id!,
  mealPlanId: _fullBoard.id!,
  ageGroupId: age.id!,
  pricePerNight: price,
);

final _roomRates = [
  _roomRate(_old, _standard, _child, 1000),
  _roomRate(_old, _standard, _adult, 2000),
  _roomRate(_old, _comfort, _adult, 2600),
  _roomRate(_old, _bungalow, _child, 0),
  _roomRate(_old, _bungalow, _adult, 500),
  _roomRate(_new, _standard, _child, 1500),
  _roomRate(_new, _standard, _adult, 3000),
];
final _unitPrices = [
  UnitPrice(priceListId: 1, unitTypeId: 3, pricePerNight: 9000),
  UnitPrice(
    priceListId: 1,
    unitTypeId: 4,
    pricePerNight: 5000,
    dayUsePrice: 12000,
  ),
  UnitPrice(priceListId: 2, unitTypeId: 3, pricePerNight: 9500),
];
final _mealRates = [
  _mealRate(_old, _child, 800),
  _mealRate(_old, _adult, 1600),
  _mealRate(_new, _adult, 1800),
];

var _nextGuestId = 1;

Guest _guest({
  DateTime? born,
  int? room = 11,
  AgeGroup? ageGroup,
  bool needsCrib = false,
  DateTime? arrival,
  DateTime? departure,
}) => Guest(
  id: _nextGuestId++,
  groupId: 1,
  contactId: 1,
  contact: Contact(firstName: 'A', lastName: 'Guest', birthDate: born),
  bookingRoomId: room,
  ageGroupOverrideId: ageGroup?.id,
  needsCrib: needsCrib,
  arrivalOverride: arrival,
  departureOverride: departure,
);

final _adultBorn = DateTime.utc(1980, 3, 3);
final _childBorn = DateTime.utc(2019, 3, 3);

/// A fee, as a surcharge of the rooms with the ids [rooms] if given.
Fee _fee(
  int id,
  String name,
  FeeUnit unit, {
  AgeGroup? only,
  bool auto = true,
  List<int> rooms = const [],
}) => Fee(
  id: id,
  name: name,
  unit: unit,
  ageGroupId: only?.id,
  taxRate: 1900,
  autoApply: auto && rooms.isEmpty,
  rooms: [for (final room in rooms) RoomFee(roomId: room, feeId: id)],
);

/// Every fee costs 100 by the old list.
List<FeePrice> _feePrices(List<Fee> fees) => [
  for (final fee in fees)
    FeePrice(priceListId: _old.id!, feeId: fee.id!, amount: 100),
];

BookingPrice _price(
  List<Guest> guests, {
  int id = 1,
  DateTime? arrival,
  DateTime? departure,
  bool dated = true,
  bool meals = false,
  List<BookingRoom>? rooms,
  List<RoomRate>? roomRates,
  List<UnitPrice>? unitPrices,
  List<Fee> fees = const [],
  List<FeePrice>? feePrices,
  List<BookingRoom> sharedHolds = const [],
}) => calculatePrice(
  booking: Booking(
    id: id,
    title: 'Camp',
    leadId: 1,
    arrival: dated ? arrival ?? DateTime.utc(2027, 5, 10) : null,
    departure: dated ? departure ?? DateTime.utc(2027, 5, 13) : null,
    rooms: rooms ?? [_room101, _room201],
  ),
  guests: guests,
  priceLists: [_new, _old],
  ageGroups: [_child, _adult],
  unitTypes: [_standard, _comfort, _bungalow, _hall],
  mealPlan: meals ? _fullBoard : null,
  roomRates: roomRates ?? _roomRates,
  unitPrices: unitPrices ?? _unitPrices,
  mealRates: _mealRates,
  fees: fees,
  feePrices: feePrices ?? _feePrices(fees),
  sharedHolds: sharedHolds,
);

/// The hold of another booking on the hall.
BookingRoom _otherHold(int bookingId, DateTime arrival, DateTime departure) =>
    BookingRoom(
      bookingId: bookingId,
      roomId: _hall1.roomId,
      booking: Booking(
        id: bookingId,
        title: 'Other',
        leadId: 1,
        arrival: arrival,
        departure: departure,
      ),
    );

void main() {
  group('ageOn', () {
    final born = DateTime.utc(2009, 7, 15);

    test('counts a birthday from the day itself', () {
      expect(ageOn(born, DateTime.utc(2027, 7, 14)), 17);
      expect(ageOn(born, DateTime.utc(2027, 7, 15)), 18);
      expect(ageOn(born, DateTime.utc(2027, 12, 31)), 18);
      expect(ageOn(born, DateTime.utc(2028, 1, 1)), 18);
    });
  });

  group('Given a guest in a standard room for three nights', () {
    test('when pricing then lodging is one line for the nights', () {
      final guest = _guest(born: _adultBorn);

      final price = _price([guest]);

      expect(price.problems, isEmpty);
      final line = price.lines.single;
      expect(line.guestId, guest.id);
      expect(line.bookingRoomId, isNull);
      expect(line.type, ChargeType.lodging);
      expect(line.description, 'Standard · Adult');
      expect(line.quantity, 3);
      expect(line.unitPrice, 2000);
      expect(line.total, 6000);
      expect(line.taxRate, 700);
      expect(line.periodFrom, DateTime.utc(2027, 5, 10));
      expect(line.periodTo, DateTime.utc(2027, 5, 13));
      expect(price.total, 6000);
    });

    test('when the room is of another unit type '
        'then its rate is used', () {
      final price = _price([_guest(born: _adultBorn, room: 12)]);

      expect(price.lines.single.unitPrice, 2600);
    });

    test('when the booking has a meal plan '
        'then meals are a line of their own', () {
      final price = _price([_guest(born: _childBorn)], meals: true);

      expect(price.lines.map((l) => (l.type, l.quantity, l.total)), [
        (ChargeType.lodging, 3, 3000),
        (ChargeType.meal, 3, 2400),
      ]);
      expect(price.lines.last.description, 'Full board · Child');
      expect(price.total, 5400);
    });
  });

  group('Given two price lists', () {
    test('when a stay goes across the first day of the new list '
        'then every night has the price of the list in force', () {
      final price = _price(
        [_guest(born: _adultBorn)],
        arrival: DateTime.utc(2027, 6, 29),
        departure: DateTime.utc(2027, 7, 2),
      );

      expect(
        price.lines.map(
          (l) => (l.quantity, l.unitPrice, l.periodFrom, l.periodTo),
        ),
        [
          (2, 2000, DateTime.utc(2027, 6, 29), DateTime.utc(2027, 7, 1)),
          (1, 3000, DateTime.utc(2027, 7, 1), DateTime.utc(2027, 7, 2)),
        ],
      );
      expect(price.total, 7000);
    });

    test('when a stay is long after the last list began '
        'then that list still prices it', () {
      final price = _price(
        [_guest(born: _adultBorn)],
        rooms: [_room101],
        arrival: DateTime.utc(2031, 2, 1),
        departure: DateTime.utc(2031, 2, 2),
      );

      expect(price.problems, isEmpty);
      expect(price.lines.single.unitPrice, 3000);
    });

    test('when nights lie before the first list '
        'then the first of them is reported and the rest is priced', () {
      final price = _price(
        [_guest(born: _adultBorn), _guest(born: _adultBorn)],
        arrival: DateTime.utc(2026, 12, 30),
        departure: DateTime.utc(2027, 1, 3),
      );

      final problem = price.problems.single;
      expect(problem.reason, PricingProblemReason.priceListMissing);
      expect(problem.detail, '2026-12-30');
      expect(price.lines.map((l) => l.quantity), [2, 2]);
    });
  });

  group('Given guests of different ages', () {
    test('when a guest comes of age during the stay '
        'then the age on arrival counts', () {
      final price = _price(
        [_guest(born: DateTime.utc(2009, 5, 11))],
      );

      expect(price.lines.single.description, 'Standard · Child');
    });

    test('when a guest comes of age on the day of arrival '
        'then the guest is an adult', () {
      final price = _price(
        [_guest(born: DateTime.utc(2009, 5, 10))],
      );

      expect(price.lines.single.description, 'Standard · Adult');
    });

    test('when a guest has an age group set '
        'then it wins over the birth date', () {
      final price = _price([_guest(born: _childBorn, ageGroup: _adult)]);

      expect(price.lines.single.unitPrice, 2000);
    });

    test('when a guest has neither birth date nor age group '
        'then the guest is reported instead of priced', () {
      final unknown = _guest();
      final known = _guest(born: _adultBorn);

      final price = _price([unknown, known], meals: true);

      expect(price.problems.single.reason, PricingProblemReason.ageUnknown);
      expect(price.problems.single.guestId, unknown.id);
      expect(price.lines.map((l) => l.guestId).toSet(), {known.id});
    });

    test('when a baby sleeps in a crib '
        'then it is priced by its age group like everybody else', () {
      final price = _price(
        [_guest(born: DateTime.utc(2026, 9, 1), needsCrib: true)],
      );

      expect(price.lines.single.unitPrice, 1000);
    });
  });

  group('Given something that pricing needs is missing', () {
    test('when a guest has no room '
        'then lodging is reported and meals are still priced', () {
      final guest = _guest(born: _adultBorn, room: null);

      final price = _price([guest], meals: true);

      expect(price.problems.single.reason, PricingProblemReason.roomMissing);
      expect(price.problems.single.guestId, guest.id);
      expect(price.lines.single.type, ChargeType.meal);
    });

    test('when a rate is missing '
        'then it is reported once with what it is missing for', () {
      final price = _price(
        [
          _guest(born: _childBorn, room: 12),
          _guest(born: _childBorn, room: 12),
        ],
        meals: true,
      );

      final problem = price.problems.single;
      expect(problem.reason, PricingProblemReason.roomRateMissing);
      expect(problem.detail, 'Comfort · Child');
      expect(price.lines.map((l) => l.type).toSet(), {ChargeType.meal});
    });

    test('when a rate is zero then it is a price and not a problem', () {
      final price = _price(
        [_guest(born: _childBorn)],
        rooms: [_room101],
        roomRates: [_roomRate(_old, _standard, _child, 0)],
      );

      expect(price.problems, isEmpty);
      expect(price.lines.single.total, 0);
    });

    test('when the booking has no dates '
        'then only that is reported', () {
      final price = _price([_guest()], dated: false);

      expect(price.problems.single.reason, PricingProblemReason.datesMissing);
      expect(price.lines, isEmpty);
      expect(price.total, 0);
    });

    test('when a held room has no price of any kind '
        'then its unit type is reported', () {
      final price = _price([], rooms: [_room101], roomRates: []);

      final problem = price.problems.single;
      expect(problem.reason, PricingProblemReason.roomRateMissing);
      expect(problem.detail, 'Standard');
    });
  });

  test('Given a guest who arrives a day later '
      'when pricing then only the nights of the guest are charged', () {
    final late = _guest(born: _adultBorn, arrival: DateTime.utc(2027, 5, 11));
    final early = _guest(
      born: _adultBorn,
      departure: DateTime.utc(2027, 5, 11),
    );

    final price = _price([late, early]);

    expect(price.lines.map((l) => (l.guestId, l.quantity, l.periodFrom)), [
      (late.id, 2, DateTime.utc(2027, 5, 11)),
      (early.id, 1, DateTime.utc(2027, 5, 10)),
    ]);
  });

  group('Given a bungalow with a price of its own', () {
    test('when pricing then the bungalow costs per night '
        'and its guests on top, taxed like the unit type', () {
      final adult = _guest(born: _adultBorn, room: 13);
      final child = _guest(born: _childBorn, room: 13);

      final price = _price([adult, child], rooms: [_bungalow1]);

      expect(price.problems, isEmpty);
      expect(
        price.lines.map(
          (l) => (l.guestId, l.bookingRoomId, l.description, l.total),
        ),
        [
          (adult.id, null, 'Bungalow · Adult', 1500),
          (child.id, null, 'Bungalow · Child', 0),
          (null, 13, 'Bungalow · B1', 27000),
        ],
      );
      expect(price.lines.map((l) => l.taxRate).toSet(), {1900});
    });

    test('when nobody stays in it then it costs the same', () {
      final price = _price([], rooms: [_bungalow1]);

      expect(price.problems, isEmpty);
      expect(price.total, 27000);
    });

    test('when the price changes during the stay '
        'then each night costs what its list says', () {
      final price = _price(
        [],
        rooms: [_bungalow1],
        arrival: DateTime.utc(2027, 6, 30),
        departure: DateTime.utc(2027, 7, 2),
      );

      expect(price.lines.map((l) => (l.quantity, l.unitPrice)), [
        (1, 9000),
        (1, 9500),
      ]);
    });

    test('when the list prices no guest of the unit type '
        'then guests stay in it for free', () {
      final price = _price(
        [_guest(born: _adultBorn, room: 13)],
        rooms: [_bungalow1],
        roomRates: [],
      );

      expect(price.problems, isEmpty);
      expect(price.lines.single.bookingRoomId, 13);
    });

    test('when the list prices some guests of the unit type '
        'then a guest without a rate is reported', () {
      final price = _price(
        [_guest(born: _childBorn, room: 13)],
        rooms: [_bungalow1],
        roomRates: [_roomRate(_old, _bungalow, _adult, 500)],
      );

      expect(price.problems.single.detail, 'Bungalow · Child');
    });
  });

  group('Given a booking that arrives and departs on the same day', () {
    final day = DateTime.utc(2027, 5, 10);

    test('when a room has a price for day use then that is charged', () {
      final price = _price([], rooms: [_hall1], arrival: day, departure: day);

      expect(price.problems, isEmpty);
      final line = price.lines.single;
      expect(
        (line.description, line.quantity, line.total),
        (
          'Hall · H1',
          1,
          12000,
        ),
      );
    });

    test('when a room has none then that is reported', () {
      final price = _price(
        [],
        rooms: [_bungalow1],
        arrival: day,
        departure: day,
      );

      final problem = price.problems.single;
      expect(problem.reason, PricingProblemReason.dayUsePriceMissing);
      expect(problem.detail, 'Bungalow');
      expect(price.lines, isEmpty);
    });
  });

  group('Given a room that bookings share', () {
    final arrival = DateTime.utc(2027, 5, 10);
    final departure = DateTime.utc(2027, 5, 13);

    test('when another booking holds it for some of the nights '
        'then those nights cost half', () {
      final price = _price(
        [],
        rooms: [_hall1],
        sharedHolds: [
          _otherHold(2, DateTime.utc(2027, 5, 11), DateTime.utc(2027, 5, 20)),
        ],
      );

      expect(
        price.lines.map((l) => (l.description, l.quantity, l.unitPrice)),
        [
          ('Hall · H1', 1, 5000),
          ('Hall · H1 · 1/2', 2, 2500),
        ],
      );
    });

    test('when three bookings share it '
        'then their parts add up to the price', () {
      BookingRoom other(int id) => _otherHold(id, arrival, departure);
      final parts = [
        _price([], id: 1, rooms: [_hall1], sharedHolds: [other(2), other(3)]),
        _price([], id: 2, rooms: [_hall1], sharedHolds: [other(1), other(3)]),
        _price([], id: 3, rooms: [_hall1], sharedHolds: [other(1), other(2)]),
      ];

      expect(parts.map((p) => p.lines.single.unitPrice), [1666, 1667, 1667]);
      expect(parts.map((p) => p.lines.single.description).toSet(), {
        'Hall · H1 · 1/3',
      });
    });

    test('when counting who shares it '
        'then the fullest night of the booking counts', () {
      final booking = Booking(
        id: 1,
        title: 'Camp',
        leadId: 1,
        arrival: arrival,
        departure: departure,
      );
      final others = [
        _otherHold(2, DateTime.utc(2027, 5, 1), DateTime.utc(2027, 5, 11)),
        _otherHold(3, DateTime.utc(2027, 5, 12), DateTime.utc(2027, 5, 14)),
        // Arrives on the day the booking departs.
        _otherHold(4, departure, DateTime.utc(2027, 5, 20)),
      ];

      expect(mostSharing(booking, _hall1.roomId, others), 2);
      expect(mostSharing(booking, _hall1.roomId, []), 1);
    });
  });

  group('Given surcharges of rooms', () {
    final adult = _guest(born: _adultBorn);
    final child = _guest(born: _childBorn);
    final neighbour = _guest(born: _adultBorn, room: 12);

    List<(String, int?, int?, int)> feeLines(List<Fee> fees) => [
      for (final line in _price([adult, child, neighbour], fees: fees).lines)
        if (line.type == ChargeType.fee)
          (line.description, line.guestId, line.bookingRoomId, line.quantity),
    ];

    test('when pricing then only the rooms that have one are charged, '
        'each by the unit of the surcharge', () {
      final lines = feeLines([
        _fee(1, 'Bathroom', FeeUnit.perPersonNight, rooms: [1]),
        _fee(2, 'Balcony', FeeUnit.perRoomNight, rooms: [1]),
        _fee(3, 'Cleaning', FeeUnit.perRoom, rooms: [1, 2]),
        _fee(4, 'Linen', FeeUnit.perPerson, rooms: [2]),
      ]);

      expect(lines, [
        ('Bathroom', adult.id, null, 3),
        ('Bathroom', child.id, null, 3),
        ('Balcony · 101', null, 11, 3),
        ('Cleaning · 101', null, 11, 1),
        ('Cleaning · 201', null, 12, 1),
        ('Linen', neighbour.id, null, 1),
      ]);
    });

    test('when the price list has no amount for a surcharge '
        'then it is not charged', () {
      final fee = _fee(1, 'Bathroom', FeeUnit.perPersonNight, rooms: [1]);

      final price = _price([adult], fees: [fee], feePrices: []);

      expect(price.problems, isEmpty);
      expect(price.lines.map((l) => l.type), [ChargeType.lodging]);
    });

    test('when the amount changes during the stay '
        'then each night costs what its list says', () {
      final fee = _fee(1, 'Balcony', FeeUnit.perRoomNight, rooms: [1]);

      final price = _price(
        [],
        rooms: [_room101],
        fees: [fee],
        feePrices: [
          FeePrice(priceListId: 1, feeId: 1, amount: 100),
          FeePrice(priceListId: 2, feeId: 1, amount: 150),
        ],
        arrival: DateTime.utc(2027, 6, 29),
        departure: DateTime.utc(2027, 7, 2),
      );

      expect(price.lines.map((l) => (l.quantity, l.unitPrice)), [
        (2, 100),
        (1, 150),
      ]);
    });
  });

  group('Given fees that are added to every booking', () {
    final adult = _guest(born: _adultBorn);
    final child = _guest(born: _childBorn);
    final unknown = _guest();

    Map<String, List<(int?, int)>> feeLines(List<Fee> fees) {
      final price = _price([adult, child, unknown], fees: fees);
      final lines = <String, List<(int?, int)>>{};
      for (final line in price.lines.where((l) => l.type == ChargeType.fee)) {
        lines.putIfAbsent(line.description, () => []).add((
          line.guestId,
          line.quantity,
        ));
      }
      return lines;
    }

    test('when pricing then each is charged by its unit', () {
      final lines = feeLines([
        _fee(1, 'Cleaning', FeeUnit.perBooking),
        _fee(2, 'Linen', FeeUnit.perPerson),
        _fee(3, 'Heating', FeeUnit.perPersonNight),
        _fee(4, 'Keys', FeeUnit.perRoom),
        _fee(5, 'Minibar', FeeUnit.perRoomNight),
      ]);

      expect(lines, {
        'Cleaning': [(null, 1)],
        'Linen': [(adult.id, 1), (child.id, 1), (unknown.id, 1)],
        'Heating': [(adult.id, 3), (child.id, 3), (unknown.id, 3)],
        'Keys': [(null, 2)],
        'Minibar': [(null, 6)],
      });
    });

    test('when a fee is for one age group '
        'then only guests known to be in it pay', () {
      final lines = feeLines([
        _fee(1, 'Tourist tax', FeeUnit.perPersonNight, only: _adult),
      ]);

      expect(lines, {
        'Tourist tax': [(adult.id, 3)],
      });
    });

    test('when a fee is neither for every booking nor for a room '
        'then it is left out', () {
      expect(
        feeLines([_fee(1, 'Sauna', FeeUnit.perBooking, auto: false)]),
        isEmpty,
      );
    });

    test('when pricing then a fee keeps its own tax rate', () {
      final price = _price(
        [adult],
        fees: [_fee(1, 'Cleaning', FeeUnit.perBooking)],
      );

      final line = price.lines.last;
      expect(line.taxRate, 1900);
      expect(line.bookingRoomId, isNull);
      expect(line.total, 100);
      expect(price.total, 6100);
    });
  });
}
