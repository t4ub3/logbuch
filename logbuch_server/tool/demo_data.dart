import 'package:logbuch_server/src/generated/protocol.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

/// What a night costs an adult in a room of a price category, in cents.
const _roomPrices = {
  'Haupthaus': 4500,
  'Neubau': 5200,
  'Einzelzimmer': 6800,
  'Komfort (Du + WC)': 6200,
};

/// What a meal plan costs an adult per night, in cents.
const _mealPrices = {
  'Vollpension': 3400,
  'Halbpension': 2500,
  'Frühstück': 950,
};

/// Families that become households, with the ages of their children.
const _families = [
  (
    name: 'Hoffmann',
    adults: ['Katrin', 'Stefan'],
    children: [('Emil', 9), ('Greta', 6), ('Paul', 1)],
  ),
  (
    name: 'Demir',
    adults: ['Elif', 'Murat'],
    children: [('Deniz', 12), ('Leyla', 8)],
  ),
  (
    name: 'Petersen',
    adults: ['Jana', 'Ole'],
    children: [('Mats', 15), ('Ida', 13)],
  ),
  (name: 'Krüger', adults: ['Sabine'], children: [('Lotta', 5), ('Jonas', 3)]),
  (
    name: 'Nowak',
    adults: ['Agnieszka', 'Tomasz'],
    children: [('Zofia', 16), ('Jan', 10), ('Hanna', 4)],
  ),
  (name: 'Lindner', adults: ['Claudia', 'Markus'], children: [('Ben', 7)]),
  (
    name: 'Schäfer',
    adults: ['Miriam', 'Daniel'],
    children: [('Noah', 2), ('Ella', 0)],
  ),
  (name: 'Bauer', adults: ['Ursula', 'Heinz'], children: <(String, int)>[]),
];

const _pupils = [
  'Lena Arnold',
  'Finn Berger',
  'Mia Brandt',
  'Luca Dietrich',
  'Emma Engel',
  'Noah Franke',
  'Hannah Günther',
  'Elias Haas',
  'Sofia Horn',
  'Ben Kaiser',
  'Lina Kühn',
  'Paul Lorenz',
  'Clara Marx',
  'Leon Otto',
  'Amelie Pohl',
  'Jakob Roth',
  'Nele Sauer',
  'Tim Seidel',
  'Frieda Thiele',
  'Moritz Ullrich',
  'Ronja Voigt',
  'Anton Ziegler',
];

const _singers = [
  'Dorothea König',
  'Barbara Ernst',
  'Christa Heinrich',
  'Ingrid Lang',
  'Margit Simon',
  'Gerhard Böhm',
  'Wolfgang Fischer',
  'Norbert Hahn',
  'Dieter Jansen',
  'Manfred Kurz',
];

const _yogis = [
  'Sandra Winter',
  'Tanja Albers',
  'Nicole Beck',
  'Vanessa Conrad',
  'Carolin Dorn',
  'Svenja Ebert',
  'Florian Geiger',
  'Patrick Heller',
];

const _hikers = [
  'Thomas Richter',
  'Birgit Scholz',
  'Rainer Vogt',
  'Heike Jung',
  'Uwe Keller',
  'Monika Busch',
  // Members who also come with their families.
  'Jana Petersen',
  'Ole Petersen',
  'Claudia Lindner',
  'Markus Lindner',
  'Stefan Hoffmann',
  'Daniel Schäfer',
];

const _kitaTeam = [
  'Julia Sommer',
  'Anke Brinkmann',
  'Melanie Decker',
  'Silke Friedrich',
  'Nadine Gerlach',
  'Yvonne Hartwig',
  'Kerstin Imhof',
  'Bettina Jahn',
];

const _streets = [
  'Birkenweg',
  'Gartenstraße',
  'Am Mühlbach',
  'Lindenallee',
  'Schulstraße',
  'Bergstraße',
  'Wiesengrund',
  'Kirchplatz',
  'Bahnhofstraße',
  'Rosenweg',
];

const _towns = [
  ('34117', 'Kassel'),
  ('37073', 'Göttingen'),
  ('35037', 'Marburg'),
  ('36037', 'Fulda'),
  ('33098', 'Paderborn'),
  ('99084', 'Erfurt'),
];

const _diets = [
  'Vegetarisch',
  'Vegan',
  'Laktosefrei',
  'Glutenfrei (Zöliakie)',
  'Nussallergie',
  'Kein Schweinefleisch',
];

/// The share of the adult price that the guests of an age group pay.
double _share(AgeGroup group) => switch (group.minAge) {
  >= 18 => 1,
  >= 14 => 0.8,
  >= 7 => 0.6,
  >= 2 => 0.4,
  _ => 0,
};

/// The main season costs more than the rest of the year.
double _seasonFactor(Season season) => switch (season.name) {
  final name when name.startsWith('Hauptsaison') => 1.1,
  final name when name.startsWith('Nebensaison') => 0.9,
  _ => 1,
};

/// A price in cents, rounded to 50 cents.
int _price(int adult, double factor) => (adult * factor / 50).round() * 50;

String _fullName(Contact contact) =>
    '${contact.firstName} ${contact.lastName}'.trim();

/// Rooms of a price category that a booking wants to hold.
typedef _Wish = ({String category, int count, int minBeds});

/// The categories of bookings, each with its icon, its color and the words
/// in the title of a booking that put it into the category.
const _bookingCategories = [
  (
    'Familien',
    BookingCategoryIcon.family,
    BookingCategoryColor.sage,
    ['Familien'],
  ),
  (
    'Schule und Jugend',
    BookingCategoryIcon.education,
    BookingCategoryColor.blue,
    ['Klassenfahrt', 'Sommerlager'],
  ),
  (
    'Musik',
    BookingCategoryIcon.music,
    BookingCategoryColor.purple,
    ['Probenwochenende', 'Orchester'],
  ),
  (
    'Seminare und Klausuren',
    BookingCategoryIcon.presentation,
    BookingCategoryColor.orange,
    ['Seminar', 'Teamtage', 'Firmenklausur', 'Retreat'],
  ),
  (
    'Sport und Freizeit',
    BookingCategoryIcon.compass,
    BookingCategoryColor.viridian,
    ['Wanderwochenende', 'Ausflug'],
  ),
];

/// Demo data for showing the app: a house with rooms in every price
/// category and prices for them, contacts, organizations and households,
/// and bookings in every stage around [today], some of them invoiced and
/// paid, as well as donations and receipts.
///
/// Everything is created through the endpoints, the way the app does it, so
/// that prices, invoice numbers and receipts follow the same rules. What is
/// in the database already is kept: records are looked up by their name
/// before they are created, and a booking whose title exists is left as it
/// is. Running this twice therefore adds nothing the second time.
class DemoData {
  DemoData(
    this.session,
    this.endpoints, {
    required this.today,
    this.log = print,
  });

  /// Signed in as an admin.
  final TestSessionBuilder session;
  final TestEndpoints endpoints;

  /// The day the bookings are placed around, at midnight UTC.
  final DateTime today;
  final void Function(String line) log;

  final _contacts = <String, Contact>{};
  final _organizations = <String, Organization>{};
  final _households = <String, Household>{};
  final _mealPlans = <String, MealPlan>{};
  final _categories = <String, BookingCategory>{};
  var _ageGroups = <AgeGroup>[];
  var _bookings = <String, Booking>{};
  var _people = 0;

  /// The day [offset] days after [today].
  DateTime _day(int offset) => today.add(Duration(days: offset));

  /// The next time it is the given day of a year, at least two months
  /// from [today].
  DateTime _next(int month, int day) {
    final thisYear = DateTime.utc(today.year, month, day);
    return thisYear.isAfter(_day(60))
        ? thisYear
        : DateTime.utc(today.year + 1, month, day);
  }

  Future<void> seed() async {
    await _addOperator();
    await _addPrices();
    await _addRooms();
    await _addContacts();
    await _addBookings();
    await _addDonations();
  }

  // The house and its prices.

  /// The details of a made-up operator, unless some were entered.
  Future<void> _addOperator() async {
    if (await endpoints.operator.load(session) != null) return;
    await endpoints.operator.save(
      session,
      Operator(
        name: 'Gruppenhaus Lindenhof e. V.',
        street: 'Am Lindenhof 1',
        zip: '34123',
        city: 'Musterstadt',
        taxOffice: 'Musterstadt',
        taxNumber: '026 250 12345',
        noticeDate: DateTime.utc(today.year - 1, 3, 12),
        purposes: 'der Jugendhilfe',
        purposesObject: 'die Jugendhilfe',
        place: 'Musterstadt',
        signatory: 'Karin Vogt, Vorsitzende',
        accountHolder: 'Gruppenhaus Lindenhof e. V.',
        iban: 'DE02 1203 0000 0000 2020 51',
        bic: 'BYLADEM1001',
        bankName: 'Musterbank',
        paymentTerms: 'Zahlbar innerhalb von 14 Tagen ohne Abzug.',
        confirmationNote:
            'Anreise ab 15 Uhr, Abreise bis 10 Uhr. Bitte bringen Sie '
            'Handtücher und Hausschuhe mit.',
      ),
    );
    log('+ operator');
  }

  Future<void> _addPrices() async {
    final e = endpoints;

    final categories = [...await e.priceCategory.getAll(session)];
    for (final (index, name) in _roomPrices.keys.indexed) {
      if (categories.any((category) => category.name == name)) continue;
      categories.add(
        await e.priceCategory.add(
          session,
          PriceCategory(name: name, sortOrder: index),
        ),
      );
    }

    // Age groups must not overlap, so existing ones are kept as they are.
    _ageGroups = [...await e.ageGroup.getAll(session)];
    if (_ageGroups.isEmpty) {
      for (final (name, minAge, maxAge) in [
        ('Baby', 0, 1),
        ('Kleinkind', 2, 6),
        ('Kind', 7, 13),
        ('Teen', 14, 17),
        ('Erwachsene', 18, null),
      ]) {
        _ageGroups.add(
          await e.ageGroup.add(
            session,
            AgeGroup(name: name, minAge: minAge, maxAge: maxAge),
          ),
        );
      }
    }

    for (final plan in await e.mealPlan.getAll(session)) {
      _mealPlans[plan.name] = plan;
    }
    for (final name in _mealPrices.keys) {
      _mealPlans[name] ??= await e.mealPlan.add(session, MealPlan(name: name));
    }

    for (final category in await e.bookingCategory.getAll(session)) {
      _categories[category.name] = category;
    }
    for (final (name, icon, color, _) in _bookingCategories) {
      _categories[name] ??= await e.bookingCategory.add(
        session,
        BookingCategory(name: name, icon: icon, color: color),
      );
    }

    final fees = await e.fee.getAll(session);
    for (final fee in [
      Fee(
        name: 'Endreinigung',
        amount: 8500,
        unit: FeeUnit.perBooking,
        taxRate: 700,
        autoApply: true,
      ),
      Fee(
        name: 'Bettwäsche',
        amount: 950,
        unit: FeeUnit.perPerson,
        taxRate: 700,
        autoApply: true,
      ),
    ]) {
      if (fees.every((known) => known.name != fee.name)) {
        await e.fee.add(session, fee);
      }
    }

    // Seasons for last year, this year and the next, wherever none covers
    // the time yet.
    final seasons = [...await e.season.getAll(session)];
    for (final year in [today.year - 1, today.year, today.year + 1]) {
      for (final season in [
        Season(
          name: 'Nebensaison Frühjahr $year',
          validFrom: DateTime.utc(year),
          validTo: DateTime.utc(year, 3, 31),
        ),
        Season(
          name: 'Hauptsaison $year',
          validFrom: DateTime.utc(year, 4),
          validTo: DateTime.utc(year, 10, 31),
        ),
        Season(
          name: 'Nebensaison Winter $year',
          validFrom: DateTime.utc(year, 11),
          validTo: DateTime.utc(year, 12, 31),
        ),
      ]) {
        final overlaps = seasons.any(
          (known) =>
              !known.validFrom.isAfter(season.validTo) &&
              !known.validTo.isBefore(season.validFrom),
        );
        if (!overlaps) seasons.add(await e.season.add(session, season));
      }
    }

    // Every season gets the prices it has none for yet.
    for (final season in seasons) {
      final factor = _seasonFactor(season);

      final roomRates = await e.roomRate.getBySeason(session, season.id!);
      final pricedRooms = {
        for (final rate in roomRates) (rate.priceCategoryId, rate.ageGroupId),
      };
      final newRoomRates = [
        for (final category in categories)
          for (final ageGroup in _ageGroups)
            if (!pricedRooms.contains((category.id, ageGroup.id)))
              RoomRate(
                seasonId: season.id!,
                priceCategoryId: category.id!,
                ageGroupId: ageGroup.id!,
                pricePerNight: _price(
                  _roomPrices[category.name] ?? 4800,
                  _share(ageGroup) * factor,
                ),
              ),
      ];
      if (newRoomRates.isNotEmpty) {
        await e.roomRate.saveForSeason(session, season.id!, [
          ...roomRates,
          ...newRoomRates,
        ]);
      }

      final mealRates = await e.mealRate.getBySeason(session, season.id!);
      final pricedMeals = {
        for (final rate in mealRates) (rate.mealPlanId, rate.ageGroupId),
      };
      final newMealRates = [
        for (final plan in _mealPlans.values)
          for (final ageGroup in _ageGroups)
            if (!pricedMeals.contains((plan.id, ageGroup.id)))
              MealRate(
                seasonId: season.id!,
                mealPlanId: plan.id!,
                ageGroupId: ageGroup.id!,
                pricePerNight: _price(
                  _mealPrices[plan.name] ?? 2000,
                  _share(ageGroup),
                ),
              ),
      ];
      if (newMealRates.isNotEmpty) {
        await e.mealRate.saveForSeason(session, season.id!, [
          ...mealRates,
          ...newMealRates,
        ]);
      }
    }
    log('+ prices for ${seasons.length} seasons');
  }

  Future<void> _addRooms() async {
    final categories = {
      for (final category in await endpoints.priceCategory.getAll(session))
        category.name: category.id!,
    };
    Room newRoom(
      String number,
      int beds,
      String building,
      String floor,
      String category, {
      bool crib = false,
      bool active = true,
      String? notes,
    }) => Room(
      roomNumber: number,
      bedAmount: beds,
      building: building,
      floor: floor,
      priceCategoryId: categories[category]!,
      cribPossible: crib,
      active: active,
      notes: notes,
    );

    final wanted = [
      // Three floors of five rooms each in the old house.
      for (final (floor, name) in ['EG', '1. OG', '2. OG'].indexed)
        for (var n = 1; n <= 5; n++)
          newRoom(
            '${floor + 1}0$n',
            n % 4 + 1,
            'Haupthaus',
            name,
            'Haupthaus',
            crib: n == 1,
          ),
      for (final (index, beds) in [6, 6, 4, 4, 4, 4].indexed)
        newRoom(
          'N0${index + 1}',
          beds,
          'Neubau',
          index < 3 ? 'EG' : '1. OG',
          'Neubau',
          crib: true,
        ),
      for (var n = 1; n <= 4; n++)
        newRoom('E$n', 1, 'Haupthaus', '2. OG', 'Einzelzimmer'),
      for (var n = 1; n <= 4; n++)
        newRoom(
          'K$n',
          2,
          'Neubau',
          '1. OG',
          'Komfort (Du + WC)',
          crib: n <= 2,
        ),
      newRoom(
        'K5',
        2,
        'Neubau',
        '1. OG',
        'Komfort (Du + WC)',
        active: false,
        notes: 'Wird renoviert, voraussichtlich bis zum Jahresende.',
      ),
    ];

    final known = {
      for (final room in await endpoints.room.getAll(session))
        room.roomNumber: room,
    };
    var added = 0;
    for (final room in wanted) {
      final existing = known[room.roomNumber];
      if (existing == null) {
        await endpoints.room.add(session, room);
        added++;
      } else if (existing.building == null && existing.floor == null) {
        // Says where the room is, which was left open so far.
        await endpoints.room.update(
          session,
          existing.copyWith(building: room.building, floor: room.floor),
        );
      }
    }
    log('+ $added rooms');
  }

  // Contacts, organizations and households.

  /// A street and a town, the same for the same [n].
  ({String street, String zip, String city}) _address(int n) => (
    street: '${_streets[n % _streets.length]} ${3 + n * 7 % 60}',
    zip: _towns[n % _towns.length].$1,
    city: _towns[n % _towns.length].$2,
  );

  /// The contact with this name, which is created if there is none.
  ///
  /// [age] is how old the person is today. A person who is [reachable] has
  /// a mail address and a phone number, and has agreed to their data being
  /// kept.
  Future<Contact> _person(
    String name, {
    int? age,
    bool reachable = false,
    ({String street, String zip, String city})? address,
    Organization? organization,
  }) async {
    final known = _contacts[name];
    if (known != null) return known;

    final n = _people++;
    final split = name.lastIndexOf(' ');
    final firstName = split == -1 ? name : name.substring(0, split);
    final lastName = split == -1 ? '' : name.substring(split + 1);
    // Phone numbers from the range that is set aside for films and books.
    final phone = '+49 171 39200 ${(n % 100).toString().padLeft(2, '0')}';
    final mail = [firstName, lastName]
        .map(
          (part) => part
              .toLowerCase()
              .replaceAll('ä', 'ae')
              .replaceAll('ö', 'oe')
              .replaceAll('ü', 'ue')
              .replaceAll('ß', 'ss')
              .replaceAll(RegExp('[^a-z]'), ''),
        )
        .join('.');

    return _contacts[name] = await endpoints.contact.add(
      session,
      Contact(
        firstName: firstName,
        lastName: lastName,
        mail: reachable ? '$mail@example.com' : null,
        phone: reachable ? phone : null,
        // The birthday was two to eight months ago, so that the age holds
        // for the bookings of the coming weeks as well.
        birthDate: age == null
            ? null
            : DateTime.utc(
                today.year - age,
                today.month,
                today.day,
              ).subtract(Duration(days: 60 + n * 17 % 180)),
        street: address?.street,
        zip: address?.zip,
        city: address?.city,
        country: address == null ? null : 'Deutschland',
        organizationId: organization?.id,
        privacyConsentAt: reachable ? _day(-90 - n % 200) : null,
      ),
    );
  }

  /// An adult with an address who can be reached.
  Future<Contact> _adult(String name, {Organization? organization}) => _person(
    name,
    age: 27 + _people * 7 % 41,
    reachable: true,
    address: _address(_people),
    organization: organization,
  );

  Future<Organization> _organization(
    String name,
    String street,
    String zip,
    String city,
  ) async => _organizations[name] ??= await endpoints.organization.add(
    session,
    Organization(
      name: name,
      street: street,
      zip: zip,
      city: city,
      country: 'Deutschland',
    ),
  );

  Future<void> _addContacts() async {
    for (final contact in await endpoints.contact.getAll(session)) {
      _contacts[_fullName(contact)] = contact;
    }
    for (final organization in await endpoints.organization.getAll(session)) {
      _organizations[organization.name] = organization;
    }
    for (final household in await endpoints.household.getAll(session)) {
      _households[household.name] = household;
    }
    final before = _contacts.length;

    // A family shares its address, and its parents can be reached.
    for (final (index, family) in _families.indexed) {
      final address = _address(index + 3);
      final members = [
        for (final (n, adult) in family.adults.indexed)
          await _person(
            '$adult ${family.name}',
            age: (family.children.isEmpty ? 68 : 34) + index + n * 3,
            reachable: true,
            address: address,
          ),
        for (final (child, age) in family.children)
          await _person('$child ${family.name}', age: age, address: address),
      ];
      final name = 'Familie ${family.name}';
      _households[name] ??= await endpoints.household.save(
        session,
        Household(name: name),
        [for (final member in members) member.id!],
      );
    }
    log('+ ${_contacts.length - before} contacts in households');
  }

  // Bookings.

  /// The category whose words are in the title of a booking.
  BookingCategory? _categoryOf(String title) {
    for (final (name, _, _, words) in _bookingCategories) {
      if (words.any(title.contains)) return _categories[name];
    }
    return null;
  }

  /// Creates [booking], unless a booking with its title exists: then that
  /// is left as it is and null is returned. Only a category is added to it,
  /// if it has none, since bookings made before there were categories have
  /// none.
  Future<Booking?> _book(Booking booking) async {
    final category = _categoryOf(booking.title);
    if (_bookings[booking.title] case final existing?) {
      if (existing.categoryId == null && category != null) {
        log('~ ${booking.title} is in ${category.name} now');
        await endpoints.booking.update(
          session,
          existing.copyWith(categoryId: category.id),
        );
      } else {
        log('· ${booking.title} is there already');
      }
      return null;
    }
    log('+ ${booking.title}');
    final added = await endpoints.booking.add(
      session,
      booking.copyWith(categoryId: category?.id),
    );
    _bookings[added.title] = added;
    return added;
  }

  /// Lets [booking] hold rooms that are free during its nights: for each of
  /// the [wishes] as many rooms of a price category as there are, up to the
  /// number that is wished for.
  Future<Booking> _hold(Booking booking, List<_Wish> wishes) async {
    final free = await endpoints.booking.availableRooms(
      session,
      booking.arrival!,
      booking.departure!,
      exceptBookingId: booking.id,
    );
    final rooms = <Room>[];
    for (final wish in wishes) {
      rooms.addAll(
        free
            .where(
              (room) =>
                  room.priceCategory?.name == wish.category &&
                  room.bedAmount >= wish.minBeds &&
                  !rooms.contains(room),
            )
            .take(wish.count),
      );
    }
    return endpoints.booking.setRooms(session, booking.id!, [
      for (final room in rooms) room.id!,
    ]);
  }

  Future<GuestGroup> _group(
    Booking booking,
    String name, {
    Contact? payer,
    int sortOrder = 0,
  }) => endpoints.guest.addGroup(
    session,
    GuestGroup(
      bookingId: booking.id!,
      name: name,
      payerId: payer?.id,
      sortOrder: sortOrder,
    ),
  );

  /// Adds [contacts] to [group], each in the next free bed of [beds] if
  /// there are beds, or in a room of their own with [ownRooms], and some of
  /// them with dietary needs.
  Future<void> _guests(
    GuestGroup group,
    List<Contact> contacts, {
    _Beds? beds,
    bool ownRooms = false,
    int dietEvery = 0,
  }) async {
    for (final (index, contact) in contacts.indexed) {
      final room = ownRooms ? beds?.roomFor(1) : beds?.bed();
      await endpoints.guest.addGuest(
        session,
        Guest(
          groupId: group.id!,
          contactId: contact.id!,
          bookingRoomId: room?.id,
          dietaryNotes: dietEvery > 0 && index % dietEvery == dietEvery - 1
              ? _diets[index ~/ dietEvery % _diets.length]
              : null,
        ),
      );
    }
  }

  /// The folios of [booking], which the server works out from its guests.
  Future<List<Folio>> _folios(Booking booking) =>
      endpoints.billing.getFolios(session, booking.id!);

  int _charged(Folio folio) =>
      [...?folio.charges].fold(0, (sum, charge) => sum + charge.total);

  /// Invoices [folio]. That fails while a part of its booking cannot be
  /// priced, for example where rooms were taken by bookings that this did
  /// not create, which is noted and otherwise left alone.
  Future<bool> _invoice(Folio folio) async {
    try {
      await endpoints.billing.invoice(session, folio.id!);
      return true;
    } on ValidationException catch (error) {
      log('  ! not invoiced: ${error.reason.name}');
      return false;
    }
  }

  Future<Payment> _pay(
    Folio folio,
    int amount,
    DateTime date, {
    PaymentMethod method = PaymentMethod.bankTransfer,
    String? reference,
  }) => endpoints.billing.addPayment(
    session,
    Payment(
      folioId: folio.id!,
      payerId: folio.payerId,
      amount: amount,
      date: date,
      method: method,
      reference: reference,
    ),
  );

  Future<void> _addBookings() async {
    _bookings = {
      for (final booking in await endpoints.booking.getAll(session))
        booking.title: booking,
    };

    final school = await _organization(
      'Gesamtschule Am Lindenpark',
      'Schulstraße 12',
      '34117',
      'Kassel',
    );
    final parish = await _organization(
      'Ev. Kirchengemeinde St. Marien',
      'Kirchplatz 2',
      '37073',
      'Göttingen',
    );
    final choir = await _organization(
      'Kantorei Wiesental',
      'Am Mühlbach 8',
      '35037',
      'Marburg',
    );
    final club = await _organization(
      'TSV Lindental 1912 e. V.',
      'Sportplatzweg 1',
      '36037',
      'Fulda',
    );
    final workshop = await _organization(
      'Tischlerei Brandt GmbH',
      'Gewerbering 14',
      '33098',
      'Paderborn',
    );
    final kita = await _organization(
      'Kita Sonnenschein',
      'Rosenweg 5',
      '34117',
      'Kassel',
    );
    final musicSchool = await _organization(
      'Musikschule Klangwerk',
      'Lindenallee 21',
      '99084',
      'Erfurt',
    );
    final scouts = await _organization(
      'Pfadfinderstamm Falkenstein',
      'Bergstraße 30',
      '37073',
      'Göttingen',
    );

    await _addFamilyRetreat(parish);
    await _addClassTrip(school);
    await _addChoirWeekend(choir);
    await _addYogaRetreat();
    await _addHikingWeekend(club);
    await _addTeamDays(kita);
    await _addPlannedBookings(workshop, musicSchool, scouts);
  }

  /// In the house right now: families who each pay for themselves.
  Future<void> _addFamilyRetreat(Organization parish) async {
    final pastor = await _adult('Annette Graf', organization: parish);
    var booking = await _book(
      Booking(
        title: 'Familienfreizeit St. Marien',
        arrival: _day(-2),
        departure: _day(3),
        leadId: pastor.id!,
        organizationId: parish.id,
        status: BookingStatus.checkedIn,
        mealPlanId: _mealPlans['Vollpension']!.id,
        billingMode: BillingMode.perGroup,
        expectedGuestCount: 28,
        notes:
            'Anreise mit eigenen Pkw. Der Gruppenraum und die Kapelle sind '
            'für die ganze Zeit reserviert.',
      ),
    );
    if (booking == null) return;
    booking = await _hold(booking, [
      (category: 'Neubau', count: 6, minBeds: 1),
      (category: 'Haupthaus', count: 1, minBeds: 3),
    ]);

    // All families but the grandparents come, each as its household.
    for (final family in _families.where((f) => f.children.isNotEmpty)) {
      final group = await endpoints.guest.addHousehold(
        session,
        booking.id!,
        _households['Familie ${family.name}']!.id!,
      );
      await endpoints.guest.updateGroup(
        session,
        group.copyWith(
          payerId: _contacts['${family.adults.first} ${family.name}']!.id,
        ),
      );
    }

    // The largest families choose their rooms first. Children under two
    // sleep in a crib.
    final beds = _Beds(booking);
    final groups = [
      ...await endpoints.guest.getByBooking(session, booking.id!),
    ];
    groups.sort((a, b) => b.guests!.length.compareTo(a.guests!.length));
    for (final (index, group) in groups.indexed) {
      final guests = group.guests!;
      final babies = [
        for (final guest in guests)
          if (_age(guest.contact!) < 2) guest,
      ];
      for (final baby in babies) {
        await endpoints.guest.updateGuest(
          session,
          baby.copyWith(needsCrib: true),
        );
      }
      if (index.isOdd) {
        await endpoints.guest.updateGuest(
          session,
          guests.last.copyWith(dietaryNotes: _diets[index % _diets.length]),
        );
      }
      final room = beds.roomFor(
        guests.length - babies.length,
        crib: babies.isNotEmpty,
      );
      if (room != null) {
        await endpoints.guest.assign(session, [
          for (final guest in guests) guest.id!,
        ], room.id);
      }
    }

    // Two families paid a deposit, a third one paid in cash on arrival.
    final folios = [
      for (final folio in await _folios(booking))
        if (folio.payerId != booking.leadId) folio,
    ];
    for (final folio in folios.take(2)) {
      await _pay(folio, 15000, _day(-14), reference: 'Anzahlung');
    }
    if (folios.length > 2) {
      await _pay(
        folios[2],
        _charged(folios[2]),
        _day(-2),
        method: PaymentMethod.cash,
      );
    }
  }

  /// Arrives in two days: a class whose school pays, with a few things
  /// left to do before everything can be priced.
  Future<void> _addClassTrip(Organization school) async {
    final teacher = await _adult('Martina Vogel', organization: school);
    final colleague = await _adult('Jens Albrecht', organization: school);
    final pupils = [
      for (final (index, name) in _pupils.indexed)
        // The last one is not known well enough yet to tell the age.
        await _person(
          name,
          age: index == _pupils.length - 1 ? null : 13 + index % 2,
        ),
    ];

    var booking = await _book(
      Booking(
        title: 'Klassenfahrt 8a Am Lindenpark',
        arrival: _day(2),
        departure: _day(6),
        leadId: teacher.id!,
        organizationId: school.id,
        status: BookingStatus.confirmed,
        mealPlanId: _mealPlans['Vollpension']!.id,
        expectedGuestCount: pupils.length + 2,
        notes:
            'Anreise mit dem Reisebus gegen 11 Uhr. Lunchpakete am Abreisetag.',
      ),
    );
    if (booking == null) return;
    booking = await _hold(booking, [
      (category: 'Einzelzimmer', count: 2, minBeds: 1),
      (category: 'Haupthaus', count: 7, minBeds: 2),
    ]);

    // The teachers get the single rooms. Three pupils signed up late and
    // still need a room.
    final beds = _Beds(booking);
    await _guests(
      await _group(booking, 'Lehrkräfte'),
      [teacher, colleague],
      beds: beds,
      ownRooms: true,
    );
    final late = pupils.length - 3;
    final classGroup = await _group(booking, 'Klasse 8a', sortOrder: 1);
    await _guests(
      classGroup,
      pupils.sublist(0, late),
      beds: beds,
      dietEvery: 6,
    );
    await _guests(classGroup, pupils.sublist(late));

    final folios = await _folios(booking);
    if (folios.isNotEmpty) {
      await _pay(folios.first, 50000, _day(-7), reference: 'Anzahlung 8a');
    }
  }

  /// Arrives in five days: singers who each pay for themselves.
  Future<void> _addChoirWeekend(Organization choir) async {
    final singers = [
      for (final name in _singers) await _adult(name, organization: choir),
    ];
    var booking = await _book(
      Booking(
        title: 'Probenwochenende Kantorei Wiesental',
        arrival: _day(5),
        departure: _day(7),
        leadId: singers.first.id!,
        organizationId: choir.id,
        status: BookingStatus.confirmed,
        mealPlanId: _mealPlans['Halbpension']!.id,
        billingMode: BillingMode.perGuest,
        expectedGuestCount: singers.length,
        notes: 'Der Saal mit Flügel wird für die Proben gebraucht.',
      ),
    );
    if (booking == null) return;
    booking = await _hold(booking, [
      (category: 'Komfort (Du + WC)', count: 4, minBeds: 2),
      (category: 'Einzelzimmer', count: 2, minBeds: 1),
    ]);

    final beds = _Beds(booking);
    await _guests(
      await _group(booking, 'Sopran und Alt'),
      singers.sublist(0, 5),
      beds: beds,
      dietEvery: 4,
    );
    await _guests(
      await _group(booking, 'Tenor und Bass', sortOrder: 1),
      singers.sublist(5),
      beds: beds,
    );
  }

  /// Leaves tomorrow: invoiced already, with only a deposit paid so far.
  Future<void> _addYogaRetreat() async {
    final yogis = [for (final name in _yogis) await _adult(name)];
    var booking = await _book(
      Booking(
        title: 'Yoga-Retreat Herbstruhe',
        arrival: _day(-4),
        departure: _day(1),
        leadId: yogis.first.id!,
        status: BookingStatus.checkedIn,
        mealPlanId: _mealPlans['Vollpension']!.id,
        expectedGuestCount: yogis.length,
        notes:
            'Vegetarische Küche für die ganze Gruppe. Matten sind vorhanden.',
      ),
    );
    if (booking == null) return;
    booking = await _hold(booking, [
      (category: 'Komfort (Du + WC)', count: 4, minBeds: 2),
    ]);
    await _guests(
      await _group(booking, 'Teilnehmende'),
      yogis,
      beds: _Beds(booking),
      dietEvery: 2,
    );

    var folio = (await _folios(booking)).first;
    await endpoints.billing.addCharge(
      session,
      Charge(
        folioId: folio.id!,
        type: ChargeType.manual,
        description: 'Miete Seminarraum (Tage)',
        quantity: 5,
        unitPrice: 4000,
        total: 0,
        taxRate: 700,
      ),
    );
    folio = (await _folios(booking)).first;
    if (await _invoice(folio)) {
      await _pay(
        folio,
        _charged(folio) * 2 ~/ 500 * 100,
        _day(-10),
        reference: 'Anzahlung Yoga-Retreat',
      );
    }
  }

  /// Over for two weeks: invoiced with a discount and paid, and the club
  /// said to keep what it paid too much as a donation.
  Future<void> _addHikingWeekend(Organization club) async {
    final hikers = [
      for (final name in _hikers) await _adult(name, organization: club),
    ];
    var booking = await _book(
      Booking(
        title: 'Wanderwochenende TSV Lindental',
        arrival: _day(-20),
        departure: _day(-16),
        leadId: hikers.first.id!,
        organizationId: club.id,
        status: BookingStatus.completed,
        mealPlanId: _mealPlans['Halbpension']!.id,
        expectedGuestCount: hikers.length,
      ),
    );
    if (booking == null) return;
    booking = await _hold(booking, [
      (category: 'Haupthaus', count: 4, minBeds: 3),
    ]);
    await _guests(
      await _group(booking, 'Wanderabteilung'),
      hikers,
      beds: _Beds(booking),
      dietEvery: 5,
    );

    var folio = (await _folios(booking)).first;
    await endpoints.billing.addCharge(
      session,
      Charge(
        folioId: folio.id!,
        type: ChargeType.discount,
        description: 'Rabatt für Stammgäste',
        quantity: 1,
        unitPrice: -5000,
        total: 0,
        taxRate: 700,
      ),
    );
    folio = (await _folios(booking)).first;
    if (!await _invoice(folio)) return;

    // The club rounded up to the next 50 euros.
    final charged = _charged(folio);
    final paid = (charged ~/ 5000 + 1) * 5000;
    final payment = await _pay(
      folio,
      paid,
      _day(-9),
      reference: 'Rechnung TSV',
    );
    await endpoints.billing.donate(session, payment.id!, paid - charged);
  }

  /// Over for more than a month: invoiced, and only a part was paid.
  Future<void> _addTeamDays(Organization kita) async {
    final team = [
      for (final name in _kitaTeam) await _adult(name, organization: kita),
    ];
    var booking = await _book(
      Booking(
        title: 'Teamtage Kita Sonnenschein',
        arrival: _day(-40),
        departure: _day(-38),
        leadId: team.first.id!,
        organizationId: kita.id,
        status: BookingStatus.completed,
        mealPlanId: _mealPlans['Vollpension']!.id,
        expectedGuestCount: team.length,
      ),
    );
    if (booking == null) return;
    booking = await _hold(booking, [
      (category: 'Komfort (Du + WC)', count: 4, minBeds: 2),
    ]);
    await _guests(
      await _group(booking, 'Team'),
      team,
      beds: _Beds(booking),
      dietEvery: 4,
    );

    final folio = (await _folios(booking)).first;
    if (await _invoice(folio)) {
      await _pay(folio, 40000, _day(-30), reference: 'Abschlag Teamtage');
    }
  }

  /// Bookings that are not settled yet, or were called off.
  Future<void> _addPlannedBookings(
    Organization workshop,
    Organization musicSchool,
    Organization scouts,
  ) async {
    // An option that runs out in a few days.
    final carpenter = await _adult('Andreas Brandt', organization: workshop);
    final retreat = await _book(
      Booking(
        title: 'Firmenklausur Tischlerei Brandt',
        arrival: _day(30),
        departure: _day(32),
        leadId: carpenter.id!,
        organizationId: workshop.id,
        status: BookingStatus.option,
        optionExpiresAt: _day(5),
        mealPlanId: _mealPlans['Halbpension']!.id,
        expectedGuestCount: 14,
        notes: 'Braucht einen Beamer und einen Raum für Kleingruppen.',
      ),
    );
    if (retreat != null) {
      await _hold(retreat, [
        (category: 'Einzelzimmer', count: 4, minBeds: 1),
        (category: 'Komfort (Du + WC)', count: 4, minBeds: 2),
        (category: 'Haupthaus', count: 1, minBeds: 2),
      ]);
    }

    // An option that ran out without an answer.
    final scout = await _adult('Jonas Reuter', organization: scouts);
    final camp = await _book(
      Booking(
        title: 'Sommerlager Pfadfinderstamm Falkenstein',
        arrival: _next(8, 2),
        departure: _next(8, 2).add(const Duration(days: 10)),
        leadId: scout.id!,
        organizationId: scouts.id,
        status: BookingStatus.option,
        optionExpiresAt: _day(-2),
        mealPlanId: _mealPlans['Vollpension']!.id,
        expectedGuestCount: 40,
        notes: 'Wartet auf die Zusage der Fördermittel.',
      ),
    );
    if (camp != null) {
      await _hold(camp, [
        (category: 'Neubau', count: 6, minBeds: 1),
        (category: 'Haupthaus', count: 5, minBeds: 2),
      ]);
    }

    // Confirmed long ahead, the guest list comes later.
    final conductor = await _adult(
      'Christoph Maier',
      organization: musicSchool,
    );
    final orchestra = await _book(
      Booking(
        title: 'Orchesterfreizeit Musikschule Klangwerk',
        arrival: _next(4, 9),
        departure: _next(4, 9).add(const Duration(days: 5)),
        leadId: conductor.id!,
        organizationId: musicSchool.id,
        status: BookingStatus.confirmed,
        mealPlanId: _mealPlans['Vollpension']!.id,
        expectedGuestCount: 35,
        notes: 'Die Teilnehmerliste kommt sechs Wochen vor der Anreise.',
      ),
    );
    if (orchestra != null) {
      await _hold(orchestra, [
        (category: 'Neubau', count: 6, minBeds: 1),
        (category: 'Haupthaus', count: 4, minBeds: 2),
        (category: 'Einzelzimmer', count: 2, minBeds: 1),
      ]);
    }

    // Inquiries: one with dates, one without.
    await _book(
      Booking(
        title: 'Familientreffen Bauer',
        arrival: _day(60),
        departure: _day(62),
        leadId: _contacts['Ursula Bauer']!.id!,
        mealPlanId: _mealPlans['Frühstück']!.id,
        billingMode: BillingMode.perGroup,
        expectedGuestCount: 25,
        notes: 'Runder Geburtstag. Fragt nach einem Raum zum Feiern.',
      ),
    );
    final trainer = await _adult('Michael Kern');
    await _book(
      Booking(
        title: 'Seminar Achtsamkeit im Alltag',
        leadId: trainer.id!,
        expectedGuestCount: 12,
        notes: 'Wunschtermin: ein Wochenende im Februar oder März.',
      ),
    );

    // Called off.
    final organizer = await _adult('Renate Fuchs');
    await _book(
      Booking(
        title: 'Ausflug Seniorenkreis',
        arrival: _day(12),
        departure: _day(14),
        leadId: organizer.id!,
        status: BookingStatus.cancelled,
        mealPlanId: _mealPlans['Vollpension']!.id,
        expectedGuestCount: 18,
        notes: 'Abgesagt, es gab zu wenige Anmeldungen.',
      ),
    );
  }

  // Donations.

  /// Donations of last year, with receipts, and of this year, for which the
  /// receipts are still to be issued. Left out if there are donations that
  /// did not come from a payment already.
  Future<void> _addDonations() async {
    final year = today.year;
    for (final known in [
      ...await endpoints.donation.getByYear(session, year - 1),
      ...await endpoints.donation.getByYear(session, year),
    ]) {
      if (known.source == DonationSource.direct) return;
    }

    Future<void> donate(String name, int amount, DateTime date) async {
      await endpoints.donation.addDirect(
        session,
        Donation(
          contactId: (await _adult(name)).id!,
          amount: amount,
          date: date,
          source: DonationSource.direct,
        ),
      );
    }

    await donate('Ursula Bauer', 15000, DateTime.utc(year - 1, 3, 14));
    await donate('Michael Kern', 5000, DateTime.utc(year - 1, 6, 2));
    await donate('Ursula Bauer', 15000, DateTime.utc(year - 1, 9, 12));
    await donate('Dorothea König', 8000, DateTime.utc(year - 1, 12, 3));
    await donate('Andreas Brandt', 50000, DateTime.utc(year - 1, 12, 18));
    var receipts = <DonationReceipt>[];
    try {
      receipts = await endpoints.donation.createReceipts(session, year - 1);
    } on ValidationException catch (error) {
      log('  ! no receipts: ${error.reason.name}');
    }

    await donate('Renate Fuchs', 10000, _day(-45));
    await donate('Heinz Bauer', 20000, _day(-20));
    // Gets no receipt until her address is known.
    final neighbor = await _person('Gisela Hartmann', age: 74);
    await endpoints.donation.addDirect(
      session,
      Donation(
        contactId: neighbor.id!,
        amount: 3000,
        date: _day(-5),
        source: DonationSource.direct,
      ),
    );
    log('+ donations, ${receipts.length} receipts for ${year - 1}');
  }

  /// How old [contact] is today; babies if the birth date is not known.
  int _age(Contact contact) {
    final born = contact.birthDate;
    if (born == null) return 0;
    final hadBirthday =
        today.month > born.month ||
        (today.month == born.month && today.day >= born.day);
    return today.year - born.year - (hadBirthday ? 0 : 1);
  }
}

/// Hands out the beds of the rooms that a booking holds.
class _Beds {
  _Beds(Booking booking)
    : _free = {
        for (final hold
            in [...?booking.rooms]..sort(
              (a, b) => a.room!.roomNumber.compareTo(b.room!.roomNumber),
            ))
          hold: hold.room!.bedAmount,
      };

  /// The beds that are left in each room.
  final Map<BookingRoom, int> _free;

  /// The next free bed, filling one room after the other, or null if all
  /// beds are taken.
  BookingRoom? bed() {
    for (final MapEntry(key: hold, value: free) in _free.entries) {
      if (free == 0) continue;
      _free[hold] = free - 1;
      return hold;
    }
    return null;
  }

  /// A room of its own for a party that needs this many [beds]: the
  /// smallest one that nobody is in yet, with room for a [crib] if asked
  /// for. Null if no such room is left.
  BookingRoom? roomFor(int beds, {bool crib = false}) {
    final fitting = [
      for (final MapEntry(key: hold, value: free) in _free.entries)
        if (free == hold.room!.bedAmount &&
            free >= beds &&
            (!crib || hold.room!.cribPossible))
          hold,
    ]..sort((a, b) => a.room!.bedAmount.compareTo(b.room!.bedAmount));
    if (fitting.isEmpty) return null;
    _free[fitting.first] = 0;
    return fitting.first;
  }
}
