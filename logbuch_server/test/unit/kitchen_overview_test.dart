import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/guests/kitchen_overview.dart';
import 'package:test/test.dart';

final _adult = AgeGroup(id: 1, name: 'Adult', minAge: 18);
final _child = AgeGroup(id: 2, name: 'Child', minAge: 3, maxAge: 17);
final _toddler = AgeGroup(id: 3, name: 'Toddler', minAge: 0, maxAge: 2);

Guest _guest(
  String firstName, {
  DateTime? born,
  AgeGroup? ageGroup,
  String? dietaryNotes,
  DateTime? arrival,
}) => Guest(
  groupId: 1,
  contactId: 1,
  contact: Contact(firstName: firstName, lastName: 'Weber', birthDate: born),
  ageGroupOverrideId: ageGroup?.id,
  dietaryNotes: dietaryNotes,
  arrivalOverride: arrival,
);

KitchenOverview _overview(
  List<GuestGroup> groups, {
  bool dated = true,
}) => buildKitchenOverview(
  booking: Booking(
    title: 'Camp',
    leadId: 1,
    arrival: dated ? DateTime.utc(2027, 5, 10) : null,
    departure: dated ? DateTime.utc(2027, 5, 13) : null,
  ),
  groups: groups,
  // Not in order of age, as they may come from the database.
  ageGroups: [_adult, _toddler, _child],
  today: DateTime.utc(2030, 1, 1),
);

GuestGroup _group(String name, List<Guest> guests) =>
    GuestGroup(bookingId: 1, name: name, guests: guests);

Map<String, int> _counts(KitchenOverview overview) => {
  for (final entry in overview.ageGroups) entry.ageGroup.name: entry.count,
};

void main() {
  test('Given guests of several ages '
      'when summing up then every age group is listed, youngest first', () {
    final overview = _overview([
      _group('Weber', [
        _guest('Marie', born: DateTime.utc(1984, 5, 17)),
        _guest('Felix', born: DateTime.utc(1980, 1, 1)),
        _guest('Jonas', born: DateTime.utc(2019, 3, 3)),
      ]),
    ]);

    expect(overview.guestCount, 3);
    expect(overview.ageGroups.map((entry) => entry.ageGroup.name), [
      'Toddler',
      'Child',
      'Adult',
    ]);
    expect(_counts(overview), {'Toddler': 0, 'Child': 1, 'Adult': 2});
    expect(overview.unknownAge, 0);
  });

  test('Given a guest who comes of age during the stay '
      'when summing up then the age on arrival counts', () {
    final overview = _overview([
      _group('Weber', [
        _guest('Almost', born: DateTime.utc(2009, 5, 11)),
        _guest('Just', born: DateTime.utc(2009, 5, 10)),
        // Arrives a day later, on the eighteenth birthday.
        _guest(
          'Late',
          born: DateTime.utc(2009, 5, 11),
          arrival: DateTime.utc(2027, 5, 11),
        ),
      ]),
    ]);

    expect(_counts(overview), {'Toddler': 0, 'Child': 1, 'Adult': 2});
  });

  test('Given guests with an age group or with nothing about their age '
      'when summing up then the age group wins and the rest is unknown', () {
    final overview = _overview([
      _group('Weber', [
        _guest('Set', born: DateTime.utc(2019, 3, 3), ageGroup: _adult),
        _guest('Only set', ageGroup: _toddler),
        _guest('Nothing'),
      ]),
    ]);

    expect(overview.guestCount, 3);
    expect(_counts(overview), {'Toddler': 1, 'Child': 0, 'Adult': 1});
    expect(overview.unknownAge, 1);
  });

  test('Given a booking without dates '
      'when summing up then ages are those of today', () {
    final overview = _overview([
      _group('Weber', [_guest('Jonas', born: DateTime.utc(2019, 3, 3))]),
    ], dated: false);

    // Ten years old on the first of January 2030.
    expect(_counts(overview), {'Toddler': 0, 'Child': 1, 'Adult': 0});
  });

  test('Given guests with dietary needs '
      'when summing up then they are listed with group and age group', () {
    final overview = _overview([
      _group('Weber', [
        _guest('Marie', born: DateTime.utc(1984, 5, 17)),
        _guest(
          'Jonas',
          born: DateTime.utc(2019, 3, 3),
          dietaryNotes: ' No nuts ',
        ),
        _guest('Blank', born: DateTime.utc(2019, 3, 3), dietaryNotes: '  '),
      ]),
      _group('Wagner', [_guest('Felix', dietaryNotes: 'Vegetarian')]),
    ]);

    expect(
      overview.dietaryNeeds.map(
        (need) =>
            (need.guestName, need.groupName, need.ageGroupName, need.notes),
      ),
      [
        ('Jonas Weber', 'Weber', 'Child', 'No nuts'),
        ('Felix Weber', 'Wagner', null, 'Vegetarian'),
      ],
    );
  });

  test('Given a booking without guests '
      'when summing up then everything is zero', () {
    final overview = _overview([]);

    expect(overview.guestCount, 0);
    expect(_counts(overview), {'Toddler': 0, 'Child': 0, 'Adult': 0});
    expect(overview.dietaryNeeds, isEmpty);
  });
}
