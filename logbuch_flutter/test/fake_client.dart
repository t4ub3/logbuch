import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaru/yaru.dart';

/// A client whose endpoints work on lists in memory. The signed-in user has
/// the given [role].
class FakeClient extends Fake implements Client {
  FakeClient({UserRole? role = UserRole.admin}) : user = FakeUsers(role);

  @override
  final FakeUsers user;
  @override
  final FakeRooms room = FakeRooms();
  @override
  final FakePriceCategories priceCategory = FakePriceCategories();
  @override
  final FakeAgeGroups ageGroup = FakeAgeGroups();
  @override
  final FakeSeasons season = FakeSeasons();
  @override
  final FakeMealPlans mealPlan = FakeMealPlans();
  @override
  final FakeRoomRates roomRate = FakeRoomRates();
  @override
  final FakeMealRates mealRate = FakeMealRates();
  @override
  final FakeFees fee = FakeFees();
  @override
  final FakeContacts contact = FakeContacts();
  @override
  final FakeOrganizations organization = FakeOrganizations();
  @override
  late final FakeBookings booking = FakeBookings(room);
  @override
  final FakeGuests guest = FakeGuests();
  @override
  final FakePricing pricing = FakePricing();
  @override
  final FakeBilling billing = FakeBilling();
}

class FakeUsers extends Fake implements EndpointUser {
  FakeUsers(UserRole? role)
    : users = [
        AppUser(
          authUserId: UuidValue.fromString(
            '550e8400-e29b-41d4-a716-446655440001',
          ),
          email: 'me@example.com',
          role: role,
        ),
        AppUser(
          authUserId: UuidValue.fromString(
            '550e8400-e29b-41d4-a716-446655440002',
          ),
          email: 'new@example.com',
        ),
      ];

  /// The signed-in user comes first.
  List<AppUser> users;

  @override
  Future<AppUser> me() async => users.first;

  @override
  Future<List<AppUser>> getAll() async => users;

  @override
  Future<AppUser> setRole(UuidValue authUserId, UserRole? role) async {
    users = [
      for (final user in users)
        user.authUserId == authUserId ? user.copyWith(role: role) : user,
    ];
    return users.firstWhere((user) => user.authUserId == authUserId);
  }
}

class FakeRooms extends Fake implements EndpointRoom {
  var rooms = <Room>[];

  @override
  Future<List<Room>> getAll() async => rooms;

  @override
  Future<Room> add(Room room) async {
    final added = room.copyWith(id: rooms.length + 1);
    rooms = [...rooms, added];
    return added;
  }
}

class FakePriceCategories extends Fake implements EndpointPriceCategory {
  var categories = <PriceCategory>[];

  @override
  Future<List<PriceCategory>> getAll() async => categories;

  @override
  Future<void> delete(int id) async =>
      throw ValidationException(reason: ValidationError.inUse);
}

class FakeAgeGroups extends Fake implements EndpointAgeGroup {
  var groups = <AgeGroup>[];

  @override
  Future<List<AgeGroup>> getAll() async => groups;

  @override
  Future<AgeGroup> add(AgeGroup group) async => throw ValidationException(
    reason: ValidationError.ageGroupOverlap,
    detail: groups.first.name,
  );
}

class FakeSeasons extends Fake implements EndpointSeason {
  var seasons = <Season>[];

  @override
  Future<List<Season>> getAll() async => seasons;
}

class FakeMealPlans extends Fake implements EndpointMealPlan {
  var plans = <MealPlan>[];

  @override
  Future<List<MealPlan>> getAll() async => plans;
}

class FakeRoomRates extends Fake implements EndpointRoomRate {
  final bySeason = <int, List<RoomRate>>{};

  @override
  Future<List<RoomRate>> getBySeason(int seasonId) async =>
      bySeason[seasonId] ?? [];

  @override
  Future<List<RoomRate>> saveForSeason(
    int seasonId,
    List<RoomRate> rates,
  ) async => bySeason[seasonId] = rates;
}

class FakeMealRates extends Fake implements EndpointMealRate {
  @override
  Future<List<MealRate>> getBySeason(int seasonId) async => [];
}

class FakeFees extends Fake implements EndpointFee {
  var fees = <Fee>[];

  @override
  Future<List<Fee>> getAll() async => fees;

  @override
  Future<Fee> add(Fee fee) async {
    final added = fee.copyWith(id: fees.length + 1);
    fees = [...fees, added];
    return added;
  }
}

class FakeContacts extends Fake implements EndpointContact {
  var contacts = <Contact>[];

  @override
  Future<List<Contact>> getAll() async => contacts;

  @override
  Future<Contact> add(Contact contact) async {
    final added = contact.copyWith(id: contacts.length + 1);
    contacts = [...contacts, added];
    return added;
  }
}

class FakeOrganizations extends Fake implements EndpointOrganization {
  var organizations = <Organization>[];

  @override
  Future<List<Organization>> getAll() async => organizations;
}

class FakeBookings extends Fake implements EndpointBooking {
  FakeBookings(this._rooms);

  final FakeRooms _rooms;
  var bookings = <Booking>[];

  /// The rooms that count as free, whatever the dates.
  var available = <Room>[];

  /// The bookings passed to [update].
  final updated = <Booking>[];

  @override
  Future<List<Booking>> getAll() async => bookings;

  @override
  Future<Booking> update(Booking booking) async {
    updated.add(booking);
    return booking;
  }

  @override
  Future<List<Room>> availableRooms(
    DateTime arrival,
    DateTime departure, {
    int? exceptBookingId,
  }) async => available;

  @override
  Future<Booking> setRooms(int bookingId, List<int> roomIds) async {
    final saved = bookings
        .firstWhere((booking) => booking.id == bookingId)
        .copyWith(
          rooms: [
            for (final room in _rooms.rooms)
              if (roomIds.contains(room.id))
                BookingRoom(bookingId: bookingId, roomId: room.id!, room: room),
          ],
        );
    bookings = [
      for (final booking in bookings) booking.id == bookingId ? saved : booking,
    ];
    return saved;
  }
}

class FakeGuests extends Fake implements EndpointGuest {
  var groups = <GuestGroup>[];

  /// The contacts that were created with [addNewGuest].
  final newContacts = <Contact>[];
  var _nextId = 100;

  @override
  Future<List<GuestGroup>> getByBooking(int bookingId) async => [
    for (final group in groups)
      if (group.bookingId == bookingId) group,
  ];

  @override
  Future<GuestGroup> addGroup(GuestGroup group) async {
    final added = group.copyWith(id: _nextId++, guests: []);
    groups = [...groups, added];
    return added;
  }

  @override
  Future<Guest> addNewGuest(Guest guest, Contact contact) async {
    newContacts.add(contact);
    final added = guest.copyWith(
      id: _nextId++,
      contact: contact.copyWith(id: _nextId++),
    );
    groups = [
      for (final group in groups)
        group.id == guest.groupId
            ? group.copyWith(guests: [...?group.guests, added])
            : group,
    ];
    return added;
  }

  @override
  Future<void> assign(List<int> guestIds, int? bookingRoomId) async {
    groups = [
      for (final group in groups)
        group.copyWith(
          guests: [
            for (final guest in group.guests ?? <Guest>[])
              guestIds.contains(guest.id)
                  ? guest.copyWith(bookingRoomId: bookingRoomId)
                  : guest,
          ],
        ),
    ];
  }

  /// The guests of all groups.
  List<Guest> get guests => [for (final group in groups) ...?group.guests];
}

class FakePricing extends Fake implements EndpointPricing {
  var price = BookingPrice(lines: [], total: 0, problems: []);

  @override
  Future<BookingPrice> calculate(int bookingId) async => price;
}

class FakeBilling extends Fake implements EndpointBilling {
  var folios = <Folio>[];
  var _nextId = 500;

  Folio _folio(int id) => folios.firstWhere((folio) => folio.id == id);

  void _replace(Folio changed) {
    folios = [
      for (final folio in folios) folio.id == changed.id ? changed : folio,
    ];
  }

  @override
  Future<List<Folio>> getFolios(int bookingId) async => [
    for (final folio in folios)
      if (folio.bookingId == bookingId) folio,
  ];

  @override
  Future<Charge> addCharge(Charge charge) async {
    final added = charge.copyWith(
      id: _nextId++,
      total: charge.quantity * charge.unitPrice,
    );
    final folio = _folio(charge.folioId);
    _replace(folio.copyWith(charges: [...?folio.charges, added]));
    return added;
  }

  @override
  Future<Folio> invoice(int folioId) async {
    final invoiced = _folio(folioId).copyWith(
      invoiceNumber: '2026-0001',
      invoicedAt: DateTime.utc(2026, 10, 16),
      status: FolioStatus.invoiced,
    );
    _replace(invoiced);
    return invoiced;
  }

  @override
  Future<Payment> addPayment(Payment payment) async {
    final added = payment.copyWith(id: _nextId++, donations: []);
    final folio = _folio(payment.folioId);
    _replace(folio.copyWith(payments: [...?folio.payments, added]));
    return added;
  }

  @override
  Future<Donation> donate(int paymentId, int amount) async {
    final donation = Donation(
      id: _nextId++,
      contactId: 1,
      amount: amount,
      date: DateTime.utc(2026, 10, 16),
      paymentId: paymentId,
      source: DonationSource.overpayment,
    );
    folios = [
      for (final folio in folios)
        folio.copyWith(
          payments: [
            for (final payment in folio.payments ?? <Payment>[])
              payment.id == paymentId
                  ? payment.copyWith(
                      donations: [...?payment.donations, donation],
                    )
                  : payment,
          ],
        ),
    ];
    return donation;
  }
}

/// A client with a small but complete setup: two rooms with prices and
/// fees, two contacts, and bookings in October 2026.
FakeClient filledClient({UserRole? role = UserRole.admin}) {
  final client = FakeClient(role: role);
  client.priceCategory.categories = [
    PriceCategory(id: 1, name: 'Standard', sortOrder: 0),
    PriceCategory(id: 2, name: 'Comfort', sortOrder: 1),
  ];
  final room101 = Room(
    id: 1,
    roomNumber: '101',
    bedAmount: 4,
    priceCategoryId: 1,
    priceCategory: client.priceCategory.categories.first,
    cribPossible: true,
  );
  final room102 = Room(
    id: 2,
    roomNumber: '102',
    bedAmount: 1,
    priceCategoryId: 2,
    priceCategory: client.priceCategory.categories.last,
    active: false,
    building: 'Annex',
  );
  final room103 = Room(
    id: 3,
    roomNumber: '103',
    bedAmount: 2,
    priceCategoryId: 1,
    priceCategory: client.priceCategory.categories.first,
  );
  client.room.rooms = [room101, room102];
  client.ageGroup.groups = [
    AgeGroup(id: 1, name: 'Child', minAge: 0, maxAge: 17),
    AgeGroup(id: 2, name: 'Adult', minAge: 18),
  ];
  client.season.seasons = [
    Season(
      id: 1,
      name: 'Spring',
      validFrom: DateTime.utc(2027, 3, 1),
      validTo: DateTime.utc(2027, 5, 31),
    ),
    Season(
      id: 2,
      name: 'Autumn',
      validFrom: DateTime.utc(2027, 9, 1),
      validTo: DateTime.utc(2027, 10, 31),
    ),
  ];
  client.mealPlan.plans = [MealPlan(id: 1, name: 'Full board')];
  client.roomRate.bySeason[1] = [
    RoomRate(
      seasonId: 1,
      priceCategoryId: 1,
      ageGroupId: 2,
      pricePerNight: 2500,
    ),
  ];
  client.fee.fees = [
    Fee(
      id: 1,
      name: 'Tourist tax',
      amount: 200,
      unit: FeeUnit.perPersonNight,
      ageGroupId: 2,
      taxRate: 700,
      autoApply: true,
    ),
  ];

  final school = Organization(id: 1, name: 'Lindenschule', city: 'Kassel');
  client.organization.organizations = [school];
  final teacher = Contact(
    id: 1,
    firstName: 'Marie',
    lastName: 'Weber',
    mail: 'marie.weber@example.com',
    organizationId: 1,
    organization: school,
  );
  client.contact.contacts = [
    Contact(id: 2, firstName: 'Felix', lastName: 'Wagner', city: 'Erfurt'),
    teacher,
  ];

  Booking booking(
    int id,
    String title,
    int arrival,
    int departure,
    BookingStatus status,
    List<Room> rooms,
  ) => Booking(
    id: id,
    title: title,
    arrival: DateTime.utc(2026, 10, arrival),
    departure: DateTime.utc(2026, 10, departure),
    leadId: 1,
    lead: teacher,
    status: status,
    expectedGuestCount: 5,
    rooms: [
      for (final room in rooms)
        BookingRoom(
          id: id * 10 + room.id!,
          bookingId: id,
          roomId: room.id!,
          room: room,
        ),
    ],
  );
  client.booking.bookings = [
    booking(1, 'Class trip', 12, 16, BookingStatus.confirmed, [room101]),
    booking(2, 'Choir weekend', 16, 18, BookingStatus.option, [room101]),
    booking(3, 'Called off', 20, 22, BookingStatus.cancelled, [room101]),
  ];
  client.booking.available = [room101, room103];

  // The class trip has a family of three. Only the mother has a room yet,
  // the one the booking holds.
  Guest guest(
    int id,
    Contact contact, {
    int? hold,
    bool needsCrib = false,
    int? ageGroup,
    String? dietaryNotes,
  }) => Guest(
    id: id,
    groupId: 1,
    contactId: contact.id!,
    contact: contact,
    bookingRoomId: hold,
    needsCrib: needsCrib,
    ageGroupOverrideId: ageGroup,
    dietaryNotes: dietaryNotes,
  );
  client.guest.groups = [
    GuestGroup(
      id: 1,
      bookingId: 1,
      name: 'Weber family',
      guests: [
        guest(1, teacher, hold: 11),
        guest(
          2,
          Contact(
            id: 3,
            firstName: 'Jonas',
            lastName: 'Weber',
            birthDate: DateTime.utc(2019, 3, 3),
          ),
          dietaryNotes: 'No nuts',
        ),
        guest(
          3,
          Contact(id: 4, firstName: 'Baby', lastName: 'Weber'),
          needsCrib: true,
          ageGroup: 1,
        ),
      ],
    ),
  ];
  // The lead of the class trip is charged 140 euros and has not paid yet.
  client.billing.folios = [
    Folio(
      id: 1,
      bookingId: 1,
      payerId: 1,
      payer: teacher,
      charges: [
        Charge(
          id: 1,
          folioId: 1,
          guestId: 1,
          type: ChargeType.lodging,
          description: 'Standard · Adult · Spring',
          quantity: 4,
          unitPrice: 2500,
          total: 10000,
          taxRate: 700,
        ),
        Charge(
          id: 2,
          folioId: 1,
          type: ChargeType.fee,
          description: 'Final cleaning',
          quantity: 1,
          unitPrice: 4000,
          total: 4000,
          taxRate: 700,
        ),
      ],
      payments: [],
    ),
  ];
  client.pricing.price = BookingPrice(
    lines: [
      ChargeLine(
        guestId: 1,
        type: ChargeType.lodging,
        description: 'Standard · Adult · Spring',
        quantity: 4,
        unitPrice: 2500,
        total: 10000,
        taxRate: 700,
      ),
      ChargeLine(
        type: ChargeType.fee,
        description: 'Final cleaning',
        quantity: 1,
        unitPrice: 4000,
        total: 4000,
        taxRate: 700,
      ),
    ],
    total: 14000,
    problems: [
      PricingProblem(reason: PricingProblemReason.ageUnknown, guestId: 2),
      PricingProblem(
        reason: PricingProblemReason.seasonMissing,
        detail: '2026-10-15',
      ),
    ],
  );
  return client;
}

/// Shows [home] in an app that talks to [client].
Future<void> pumpApp(
  WidgetTester tester,
  Widget home,
  FakeClient client, {
  Size size = const Size(1200, 800),
  AppLocale locale = AppLocale.en,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  LocaleSettings.setLocaleSync(locale);
  SharedPreferences.setMockInitialValues({'settings.locale': locale.name});
  final preferences = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        serverpodClientProvider.overrideWithValue(client),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          theme: yaruLight,
          locale: locale.flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: Scaffold(body: home),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder field(String label) => find.widgetWithText(TextFormField, label);

/// Taps a button that may be scrolled out of view, such as one of the
/// sections of the admin panel.
Future<void> open(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}
