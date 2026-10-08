import 'package:logbuch_server/src/bookings/confirmation_pdf.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'pdf_words.dart';

final _operator = Operator(
  name: 'Freizeitheim Musterhöhe e. V.',
  street: 'Bergstraße 12',
  zip: '34117',
  city: 'Kassel',
  taxOffice: '',
  taxNumber: '',
  purposes: '',
  place: '',
  confirmationNote: 'Die Zimmer stehen am Anreisetag ab 15 Uhr bereit.',
);

Room _room(String number, int beds) =>
    Room(roomNumber: number, bedAmount: beds, unitTypeId: 1);

Booking _booking({
  BookingStatus status = BookingStatus.confirmed,
  DateTime? departure,
  List<Room>? rooms,
  bool meals = true,
  DateTime? optionExpiresAt,
}) => Booking(
  title: 'Frühlingstage',
  leadId: 1,
  lead: Contact(
    firstName: 'Marie',
    lastName: 'Weber',
    street: 'Lindenstraße 5',
    zip: '34119',
    city: 'Kassel',
  ),
  arrival: DateTime.utc(2027, 5, 10),
  departure: departure ?? DateTime.utc(2027, 5, 13),
  status: status,
  optionExpiresAt: optionExpiresAt,
  mealPlan: meals ? MealPlan(name: 'Vollpension') : null,
  rooms: [
    // Not in order, as they may come from the database.
    for (final room in rooms ?? [_room('102', 2), _room('101', 4)])
      BookingRoom(bookingId: 1, roomId: 1, room: room),
  ],
);

ChargeLine _line(ChargeType type, int total) => ChargeLine(
  type: type,
  description: 'Line',
  quantity: 1,
  unitPrice: total,
  total: total,
  taxRate: 700,
);

Future<String> _text({
  required Booking booking,
  int? guestCount = 24,
  BookingPrice? price,
}) async {
  final pdf = await buildConfirmationPdf(
    operator: _operator,
    booking: booking,
    guestCount: guestCount,
    price: price,
    today: DateTime.utc(2027, 3, 1),
  );
  return wordsOf(pdf).join(' ');
}

void main() {
  test(
    'isConfirmable holds from an option on, until a booking is cancelled',
    () {
      expect(
        [
          for (final status in BookingStatus.values)
            if (isConfirmable(status)) status,
        ],
        [
          BookingStatus.option,
          BookingStatus.confirmed,
          BookingStatus.checkedIn,
          BookingStatus.completed,
        ],
      );
    },
  );

  test('Given a confirmed booking '
      'when building its confirmation '
      'then it states the stay, the rooms and the price', () async {
    final text = await _text(
      booking: _booking(),
      price: BookingPrice(
        lines: [
          _line(ChargeType.lodging, 10000),
          _line(ChargeType.lodging, 5000),
          _line(ChargeType.meal, 6000),
          _line(ChargeType.fee, 4000),
        ],
        total: 25000,
        problems: [],
      ),
    );

    for (final expected in [
      'Freizeitheim Musterhöhe e. V.',
      'Marie Weber Lindenstraße 5 34119 Kassel',
      'Datum: 01.03.2027',
      'Buchungsbestätigung',
      'Guten Tag Marie Weber,',
      'Wir bestätigen Ihren Aufenthalt wie folgt:',
      'Buchung Frühlingstage',
      'Anreise 10.05.2027',
      'Abreise 13.05.2027 (3 Nächte)',
      'Zimmer (2) 101, 102 (6 Betten)',
      'Gäste 24',
      'Verpflegung Vollpension',
      'Voraussichtlicher Preis',
      'Übernachtung 150,00 EUR',
      'Verpflegung 60,00 EUR',
      'Gebühren 40,00 EUR',
      'Gesamt 250,00 EUR',
      'Die Zimmer stehen am Anreisetag ab 15 Uhr bereit.',
      'Mit freundlichen Grüßen',
    ]) {
      expect(text, contains(expected));
    }
    expect(text, isNot(contains('Reservierung')));
  });

  test('Given an option '
      'when building its confirmation '
      'then it is a reservation that says until when it holds', () async {
    final text = await _text(
      booking: _booking(
        status: BookingStatus.option,
        optionExpiresAt: DateTime.utc(2027, 4, 1),
      ),
    );

    expect(text, contains('Reservierungsbestätigung'));
    expect(text, contains('Aufenthalt für Sie reserviert:'));
    expect(text, contains('Die Reservierung gilt bis zum 01.04.2027.'));
    expect(text, isNot(contains('Buchungsbestätigung')));
  });

  test('Given a booking that cannot be priced yet '
      'when building its confirmation '
      'then it names no price', () async {
    final text = await _text(booking: _booking());

    expect(text, isNot(contains('Voraussichtlicher Preis')));
    expect(text, isNot(contains('EUR')));
  });

  test('Given one night in one room without meals or guests so far '
      'when building its confirmation '
      'then the wording follows', () async {
    final text = await _text(
      booking: _booking(
        departure: DateTime.utc(2027, 5, 11),
        rooms: [_room('101', 1)],
        meals: false,
      ),
      guestCount: null,
    );

    expect(text, contains('Abreise 11.05.2027 (1 Nacht)'));
    expect(text, contains('Zimmer 101 (1 Bett)'));
    expect(text, contains('Verpflegung keine'));
    expect(text, isNot(contains('Gäste')));
  });
}
