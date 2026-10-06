import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/pricing/price_calculation.dart';
import 'package:test/test.dart';

// Two seasons that follow each other, two age groups, two price categories
// and one meal plan, with a rate for everything unless a test removes one.
final _low = Season(
  id: 1,
  name: 'Low',
  validFrom: DateTime.utc(2027, 1, 1),
  validTo: DateTime.utc(2027, 6, 30),
);
final _high = Season(
  id: 2,
  name: 'High',
  validFrom: DateTime.utc(2027, 7, 1),
  validTo: DateTime.utc(2027, 8, 31),
);
final _child = AgeGroup(id: 1, name: 'Child', minAge: 0, maxAge: 17);
final _adult = AgeGroup(id: 2, name: 'Adult', minAge: 18);
final _standard = PriceCategory(id: 1, name: 'Standard');
final _comfort = PriceCategory(id: 2, name: 'Comfort');
final _fullBoard = MealPlan(id: 1, name: 'Full board');

/// A room of the booking by the id of its hold: 11 is standard, 12 comfort.
final _holds = [
  BookingRoom(
    id: 11,
    bookingId: 1,
    roomId: 1,
    room: Room(id: 1, roomNumber: '101', bedAmount: 4, priceCategoryId: 1),
  ),
  BookingRoom(
    id: 12,
    bookingId: 1,
    roomId: 2,
    room: Room(id: 2, roomNumber: '201', bedAmount: 2, priceCategoryId: 2),
  ),
];

RoomRate _roomRate(
  Season season,
  PriceCategory category,
  AgeGroup age,
  int price,
) => RoomRate(
  seasonId: season.id!,
  priceCategoryId: category.id!,
  ageGroupId: age.id!,
  pricePerNight: price,
);

MealRate _mealRate(Season season, AgeGroup age, int price) => MealRate(
  seasonId: season.id!,
  mealPlanId: _fullBoard.id!,
  ageGroupId: age.id!,
  pricePerNight: price,
);

final _roomRates = [
  _roomRate(_low, _standard, _child, 1000),
  _roomRate(_low, _standard, _adult, 2000),
  _roomRate(_low, _comfort, _adult, 2600),
  _roomRate(_high, _standard, _child, 1500),
  _roomRate(_high, _standard, _adult, 3000),
];
final _mealRates = [
  _mealRate(_low, _child, 800),
  _mealRate(_low, _adult, 1600),
  _mealRate(_high, _adult, 1800),
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

BookingPrice _price(
  List<Guest> guests, {
  DateTime? arrival,
  DateTime? departure,
  bool dated = true,
  bool meals = false,
  List<RoomRate>? roomRates,
  List<Fee> fees = const [],
}) => calculatePrice(
  booking: Booking(
    id: 1,
    title: 'Camp',
    leadId: 1,
    arrival: dated ? arrival ?? DateTime.utc(2027, 5, 10) : null,
    departure: dated ? departure ?? DateTime.utc(2027, 5, 13) : null,
    rooms: _holds,
  ),
  guests: guests,
  seasons: [_low, _high],
  ageGroups: [_child, _adult],
  priceCategories: [_standard, _comfort],
  mealPlan: meals ? _fullBoard : null,
  roomRates: roomRates ?? _roomRates,
  mealRates: _mealRates,
  fees: fees,
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
      expect(line.type, ChargeType.lodging);
      expect(line.description, 'Standard · Adult · Low');
      expect(line.quantity, 3);
      expect(line.unitPrice, 2000);
      expect(line.total, 6000);
      expect(line.taxRate, 700);
      expect(line.periodFrom, DateTime.utc(2027, 5, 10));
      expect(line.periodTo, DateTime.utc(2027, 5, 13));
      expect(price.total, 6000);
    });

    test('when the room is in another price category '
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
      expect(price.lines.last.description, 'Full board · Child · Low');
      expect(price.total, 5400);
    });
  });

  test('Given a stay across two seasons '
      'when pricing then every night has the rate of its season', () {
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

  group('Given guests of different ages', () {
    test('when a guest comes of age during the stay '
        'then the age on arrival counts', () {
      final price = _price(
        [_guest(born: DateTime.utc(2009, 5, 11))],
      );

      expect(price.lines.single.description, 'Standard · Child · Low');
    });

    test('when a guest comes of age on the day of arrival '
        'then the guest is an adult', () {
      final price = _price(
        [_guest(born: DateTime.utc(2009, 5, 10))],
      );

      expect(price.lines.single.description, 'Standard · Adult · Low');
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

    test('when nights lie outside of all seasons '
        'then the first of them is reported and the rest is priced', () {
      final price = _price(
        [_guest(born: _adultBorn), _guest(born: _adultBorn)],
        arrival: DateTime.utc(2027, 8, 30),
        departure: DateTime.utc(2027, 9, 3),
      );

      final problem = price.problems.single;
      expect(problem.reason, PricingProblemReason.seasonMissing);
      expect(problem.detail, '2027-09-01');
      expect(price.lines.map((l) => l.quantity), [2, 2]);
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
      expect(problem.detail, 'Comfort · Child · Low');
      expect(price.lines.map((l) => l.type).toSet(), {ChargeType.meal});
    });

    test('when a rate is zero then it is a price and not a problem', () {
      final price = _price(
        [_guest(born: _childBorn)],
        roomRates: [_roomRate(_low, _standard, _child, 0)],
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

  group('Given fees that are added to every booking', () {
    Fee fee(String name, FeeUnit unit, {AgeGroup? only, bool auto = true}) =>
        Fee(
          name: name,
          amount: 100,
          unit: unit,
          ageGroupId: only?.id,
          taxRate: 1900,
          autoApply: auto,
        );

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
        fee('Cleaning', FeeUnit.perBooking),
        fee('Linen', FeeUnit.perPerson),
        fee('Heating', FeeUnit.perPersonNight),
        fee('Keys', FeeUnit.perRoom),
        fee('Minibar', FeeUnit.perRoomNight),
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
        fee('Tourist tax', FeeUnit.perPersonNight, only: _adult),
      ]);

      expect(lines, {
        'Tourist tax': [(adult.id, 3)],
      });
    });

    test('when a fee is added by hand then it is left out', () {
      expect(
        feeLines([fee('Sauna', FeeUnit.perBooking, auto: false)]),
        isEmpty,
      );
    });

    test('when pricing then a fee keeps its own tax rate', () {
      final price = _price(
        [adult],
        fees: [fee('Cleaning', FeeUnit.perBooking)],
      );

      final line = price.lines.last;
      expect(line.taxRate, 1900);
      expect(line.total, 100);
      expect(price.total, 6100);
    });
  });
}
