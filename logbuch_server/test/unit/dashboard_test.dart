import 'package:logbuch_server/src/dashboard/dashboard.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

/// Today is Tuesday, the 10th of May 2027.
final _today = DateTime.utc(2027, 5, 10);

DateTime _may(int day) => DateTime.utc(2027, 5, day);

final _child = AgeGroup(id: 1, name: 'Child', minAge: 0, maxAge: 17);
final _adult = AgeGroup(id: 2, name: 'Adult', minAge: 18);

var _nextId = 1;

Booking _booking(
  String title,
  int arrival,
  int departure, {
  BookingStatus status = BookingStatus.confirmed,
  List<int> rooms = const [],
  int? expected,
  String? mealPlan,
  DateTime? optionExpiresAt,
}) {
  final id = _nextId++;
  return Booking(
    id: id,
    title: title,
    leadId: 1,
    lead: Contact(firstName: 'Marie', lastName: 'Weber'),
    arrival: _may(arrival),
    departure: _may(departure),
    status: status,
    expectedGuestCount: expected,
    optionExpiresAt: optionExpiresAt,
    mealPlan: mealPlan == null ? null : MealPlan(name: mealPlan),
    rooms: [
      for (final roomId in rooms) BookingRoom(bookingId: id, roomId: roomId),
    ],
  );
}

Guest _guest({bool adult = true, bool known = true, int? from, int? to}) =>
    Guest(
      groupId: 1,
      contactId: 1,
      contact: Contact(
        firstName: 'A',
        lastName: 'Guest',
        birthDate: known
            ? (adult ? DateTime.utc(1980, 1, 1) : DateTime.utc(2019, 3, 3))
            : null,
      ),
      arrivalOverride: from == null ? null : _may(from),
      departureOverride: to == null ? null : _may(to),
    );

Dashboard _dashboard(
  List<Booking> bookings, {
  Map<Booking, List<Guest>> guests = const {},
  List<Folio> folios = const [],
}) => buildDashboard(
  today: _today,
  bookings: bookings,
  guests: {
    for (final MapEntry(key: booking, value: list) in guests.entries)
      booking.id!: list,
  },
  ageGroups: [_adult, _child],
  activeRooms: 10,
  invoicedFolios: folios,
);

Map<String, int> _counts(List<AgeGroupCount> counts) => {
  for (final entry in counts) entry.ageGroup.name: entry.count,
};

void main() {
  group('Given bookings around today', () {
    final past = _booking('Past', 1, 9);
    final leaving = _booking('Leaving today', 7, 10, rooms: [1]);
    final staying = _booking('Staying', 8, 14, rooms: [2, 3], expected: 12);
    final arriving = _booking('Arriving today', 10, 12, rooms: [4]);
    final inAWeek = _booking('In six days', 16, 20);
    final later = _booking('In seven days', 17, 20);
    final cancelled = _booking(
      'Cancelled',
      10,
      12,
      status: BookingStatus.cancelled,
      rooms: [5],
    );
    final all = [later, cancelled, inAWeek, arriving, staying, leaving, past];

    test('when building the dashboard '
        'then arrivals are those of today and the six days after', () {
      final dashboard = _dashboard(all);

      expect(dashboard.arrivals.map((stay) => (stay.title, stay.date)), [
        ('Arriving today', _may(10)),
        ('In six days', _may(16)),
      ]);
    });

    test('when building the dashboard '
        'then departures are those of today and the six days after', () {
      final dashboard = _dashboard(all);

      expect(dashboard.departures.map((stay) => (stay.title, stay.date)), [
        ('Leaving today', _may(10)),
        ('Arriving today', _may(12)),
        ('Staying', _may(14)),
      ]);
    });

    test('when building the dashboard '
        'then a stay comes with its lead, its guests and its rooms', () {
      final dashboard = _dashboard(
        all,
        guests: {
          arriving: [_guest(), _guest()],
        },
      );

      final arrival = dashboard.arrivals.first;
      expect(arrival.bookingId, arriving.id);
      expect(arrival.leadName, 'Marie Weber');
      expect(arrival.guestCount, 2);
      expect(arrival.roomCount, 1);
      // Without a guest list the expected number stands in.
      final departure = dashboard.departures.last;
      expect(departure.guestCount, 12);
      expect(departure.roomCount, 2);
    });

    test('when building the dashboard '
        'then tonight counts who has arrived and does not leave today', () {
      final dashboard = _dashboard(
        all,
        guests: {
          arriving: [
            _guest(),
            _guest(),
            // Comes a day later, and one who left this morning.
            _guest(from: 11),
            _guest(to: 10),
          ],
        },
      );

      // The rooms of "Staying" and "Arriving today".
      expect(dashboard.roomsOccupied, 3);
      expect(dashboard.roomsTotal, 10);
      expect(dashboard.guestsTonight, 12 + 2);
    });
  });

  group('Given options', () {
    Booking option(String title, DateTime? expiry) => _booking(
      title,
      20,
      25,
      status: BookingStatus.option,
      optionExpiresAt: expiry,
    );

    test('when building the dashboard '
        'then those expiring within two weeks or expired are listed', () {
      final dashboard = _dashboard([
        option('In two weeks', _may(24)),
        option('In fifteen days', _may(25)),
        option('Expired', _may(3)),
        option('No expiry', null),
        _booking('Confirmed', 20, 25, optionExpiresAt: _may(12)),
      ]);

      expect(
        dashboard.expiringOptions.map((o) => (o.title, o.expiresAt)),
        [('Expired', _may(3)), ('In two weeks', _may(24))],
      );
      expect(dashboard.expiringOptions.first.arrival, _may(20));
    });
  });

  test('Given invoices '
      'when building the dashboard '
      'then those with money still owed are listed with what is owed', () {
    Folio folio(String number, int charged, List<Payment> payments) => Folio(
      bookingId: 7,
      payerId: 1,
      invoiceNumber: number,
      status: FolioStatus.invoiced,
      payer: Contact(firstName: 'Felix', lastName: 'Wagner'),
      booking: Booking(title: 'Camp', leadId: 1),
      charges: [
        Charge(
          folioId: 1,
          type: ChargeType.lodging,
          description: 'Lodging',
          quantity: 1,
          unitPrice: charged,
          total: charged,
          taxRate: 700,
        ),
      ],
      payments: payments,
    );
    Payment payment(int amount, {int donated = 0}) => Payment(
      folioId: 1,
      payerId: 1,
      amount: amount,
      date: _today,
      method: PaymentMethod.cash,
      donations: [
        if (donated > 0)
          Donation(
            contactId: 1,
            amount: donated,
            date: _today,
            source: DonationSource.overpayment,
          ),
      ],
    );

    final dashboard = _dashboard(
      [],
      folios: [
        folio('2027-0003', 15000, [payment(5000), payment(2000)]),
        folio('2027-0001', 15000, []),
        folio('2027-0002', 15000, [payment(16000, donated: 1000)]),
      ],
    );

    expect(
      dashboard.openBalances.map(
        (b) => (b.invoiceNumber, b.payerName, b.bookingTitle, b.owed),
      ),
      [
        ('2027-0001', 'Felix Wagner', 'Camp', 15000),
        ('2027-0003', 'Felix Wagner', 'Camp', 8000),
      ],
    );
    expect(dashboard.openBalances.first.bookingId, 7);
  });

  group('Given guests in the house', () {
    final camp = _booking('Camp', 8, 11, mealPlan: 'Full board');
    final choir = _booking('Choir', 11, 13, expected: 20);
    final empty = _booking('Empty', 9, 12);
    final dashboard = _dashboard(
      [choir, empty, camp],
      guests: {
        camp: [
          _guest(),
          _guest(adult: false),
          _guest(known: false),
          // Left yesterday.
          _guest(to: 9),
          // Arrives tomorrow, which is also the day the others leave.
          _guest(adult: false, from: 11),
        ],
      },
    );
    final today = dashboard.meals.first;
    final tomorrow = dashboard.meals.last;

    test('when building the dashboard '
        'then today lists who is there, by booking and age group', () {
      expect(today.date, _may(10));
      final entry = today.bookings.single;
      expect(entry.title, 'Camp');
      expect(entry.bookingId, camp.id);
      expect(entry.mealPlan, 'Full board');
      expect(entry.guestCount, 3);
      expect(_counts(entry.ageGroups), {'Child': 1, 'Adult': 1});
      expect(entry.unknownAge, 1);

      expect(today.guestCount, 3);
      expect(_counts(today.ageGroups), {'Child': 1, 'Adult': 1});
      expect(today.unknownAge, 1);
    });

    test('when building the dashboard '
        'then tomorrow counts those who arrive and those who leave', () {
      expect(tomorrow.date, _may(11));
      expect(tomorrow.bookings.map((b) => (b.title, b.guestCount)), [
        // Everybody but the guest who left on the 9th.
        ('Camp', 4),
        // No guest list yet, so the expected number of unknown age.
        ('Choir', 20),
      ]);
      expect(tomorrow.bookings.last.mealPlan, isNull);
      expect(tomorrow.bookings.last.unknownAge, 20);
      expect(tomorrow.bookings.last.ageGroups, isEmpty);

      expect(tomorrow.guestCount, 24);
      // Every age group is in the total, youngest first.
      expect(tomorrow.ageGroups.map((entry) => entry.ageGroup.name), [
        'Child',
        'Adult',
      ]);
      expect(_counts(tomorrow.ageGroups), {'Child': 2, 'Adult': 1});
      expect(tomorrow.unknownAge, 21);
    });
  });

  test('Given nothing at all '
      'when building the dashboard then everything is empty', () {
    final dashboard = _dashboard([]);

    expect(dashboard.today, _today);
    expect(dashboard.arrivals, isEmpty);
    expect(dashboard.departures, isEmpty);
    expect(dashboard.roomsOccupied, 0);
    expect(dashboard.guestsTonight, 0);
    expect(dashboard.expiringOptions, isEmpty);
    expect(dashboard.openBalances, isEmpty);
    expect(dashboard.meals.map((day) => day.guestCount), [0, 0]);
  });
}
