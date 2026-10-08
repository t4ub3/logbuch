import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
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
  final FakeBuildings building = FakeBuildings();
  @override
  final FakeUnitTypes unitType = FakeUnitTypes();
  @override
  final FakeAgeGroups ageGroup = FakeAgeGroups();
  @override
  final FakePriceLists priceList = FakePriceLists();
  @override
  final FakeMealPlans mealPlan = FakeMealPlans();
  @override
  final FakeFees fee = FakeFees();
  @override
  final FakeContacts contact = FakeContacts();
  @override
  final FakeOrganizations organization = FakeOrganizations();
  @override
  late final FakeBookings booking = FakeBookings(room);
  @override
  final FakeBookingCategories bookingCategory = FakeBookingCategories();
  @override
  final FakeGuests guest = FakeGuests();
  @override
  final FakePricing pricing = FakePricing();
  @override
  final FakeBilling billing = FakeBilling();
  @override
  final FakeDonations donation = FakeDonations();
  @override
  final FakeOperators operator = FakeOperators();
  @override
  final FakeHouseholds household = FakeHouseholds();
  @override
  final FakeDashboards dashboard = FakeDashboards();

  /// What `client.auth` is.
  @override
  final FakeAuth authKeyProvider = FakeAuth();
}

class FakeAuth extends Fake implements FlutterAuthSessionManager {
  /// How often the user signed out.
  var signOuts = 0;

  @override
  Future<bool> signOutDevice() async {
    signOuts++;
    return true;
  }
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

  /// The surcharges passed to [add] with the last room.
  var addedFeeIds = <int>[];

  @override
  Future<Room> add(Room room, List<int> feeIds) async {
    addedFeeIds = feeIds;
    final added = room.copyWith(id: rooms.length + 1);
    rooms = [...rooms, added];
    return added;
  }
}

class FakeBuildings extends Fake implements EndpointBuilding {
  var buildings = <Building>[];

  @override
  Future<List<Building>> getAll() async => buildings;
}

class FakeUnitTypes extends Fake implements EndpointUnitType {
  var types = <UnitType>[];

  @override
  Future<List<UnitType>> getAll() async => types;

  @override
  Future<UnitType> add(UnitType type) async {
    final added = type.copyWith(id: types.length + 1);
    types = [...types, added];
    return added;
  }

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

class FakePriceLists extends Fake implements EndpointPriceList {
  var lists = <PriceList>[];

  /// The prices by the id of their list.
  final prices = <int, PriceListPrices>{};

  @override
  Future<List<PriceList>> getAll() async => lists;

  @override
  Future<PriceList> add(PriceList list) async {
    final added = list.copyWith(id: lists.length + 1);
    lists = [...lists, added]
      ..sort((a, b) => a.validFrom.compareTo(b.validFrom));
    return added;
  }

  @override
  Future<PriceListPrices> getPrices(int priceListId) async =>
      prices[priceListId] ??
      PriceListPrices(
        roomRates: [],
        unitPrices: [],
        mealRates: [],
        feePrices: [],
      );

  @override
  Future<PriceListPrices> savePrices(
    int priceListId,
    PriceListPrices prices,
  ) async => this.prices[priceListId] = prices;
}

class FakeMealPlans extends Fake implements EndpointMealPlan {
  var plans = <MealPlan>[];

  @override
  Future<List<MealPlan>> getAll() async => plans;
}

class FakeFees extends Fake implements EndpointFee {
  var fees = <Fee>[];

  @override
  Future<List<Fee>> getAll() async => fees;

  /// The rooms passed to [add] with the last fee.
  var addedRoomIds = <int>[];

  @override
  Future<Fee> add(Fee fee, List<int> roomIds) async {
    addedRoomIds = roomIds;
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
  Future<Contact> update(Contact contact) async {
    contacts = [
      for (final other in contacts) other.id == contact.id ? contact : other,
    ];
    return contact;
  }

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

  /// The shared rooms that count as crowded, whatever the booking.
  var crowded = <Room>[];

  @override
  Future<List<Room>> crowdedRooms(int bookingId) async => crowded;

  /// The bookings passed to [add].
  final added = <Booking>[];

  /// The bookings passed to [update].
  final updated = <Booking>[];

  @override
  Future<Booking> add(Booking booking) async {
    added.add(booking);
    final saved = booking.copyWith(id: 100 + added.length);
    bookings = [...bookings, saved];
    return saved;
  }

  @override
  Future<List<Booking>> getAll() async => bookings;

  @override
  Future<Booking?> getById(int id) async =>
      bookings.where((booking) => booking.id == id).firstOrNull;

  @override
  Future<Booking> update(Booking booking) async {
    updated.add(booking);
    return booking;
  }

  @override
  Future<ByteData> getConfirmationPdf(int bookingId) async =>
      ByteData.sublistView(
        Uint8List.fromList('%PDF-confirmation'.codeUnits),
      );

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

class FakeBookingCategories extends Fake implements EndpointBookingCategory {
  var categories = <BookingCategory>[];

  @override
  Future<List<BookingCategory>> getAll() async => categories;

  @override
  Future<BookingCategory> add(BookingCategory category) async {
    final added = category.copyWith(id: 300 + categories.length);
    categories = [...categories, added];
    return added;
  }

  @override
  Future<BookingCategory> update(BookingCategory category) async {
    categories = [
      for (final other in categories)
        other.id == category.id ? category : other,
    ];
    return category;
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

  /// The households that were added to a booking, by their id.
  final addedHouseholds = <int>[];

  @override
  Future<GuestGroup> addHousehold(int bookingId, int householdId) async {
    addedHouseholds.add(householdId);
    final group = GuestGroup(
      id: _nextId++,
      bookingId: bookingId,
      name: 'Household $householdId',
      guests: [],
    );
    groups = [...groups, group];
    return group;
  }

  /// What the kitchen is told, whatever the booking.
  var kitchen = KitchenOverview(
    guestCount: 0,
    ageGroups: [],
    unknownAge: 0,
    dietaryNeeds: [],
  );

  @override
  Future<KitchenOverview> kitchenOverview(int bookingId) async => kitchen;

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
  Future<ByteData> getInvoicePdf(int folioId) async =>
      ByteData.sublistView(Uint8List.fromList('%PDF-invoice'.codeUnits));

  @override
  Future<ByteData> renewInvoicePdf(int folioId) async =>
      ByteData.sublistView(Uint8List.fromList('%PDF-renewed'.codeUnits));

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

class FakeDonations extends Fake implements EndpointDonation {
  var donations = <Donation>[];
  var receipts = <DonationReceipt>[];

  /// The receipts that are waiting to be issued.
  var previews = <ReceiptPreview>[];

  /// What [createReceipts] issues.
  var toCreate = <DonationReceipt>[];

  @override
  Future<List<Donation>> getByYear(int year) async => [
    for (final donation in donations)
      if (donation.date.year == year) donation,
  ];

  @override
  Future<List<DonationReceipt>> getReceipts(int year) async => [
    for (final receipt in receipts)
      if (receipt.year == year) receipt,
  ];

  @override
  Future<List<ReceiptPreview>> previewReceipts(int year) async => previews;

  @override
  Future<List<DonationReceipt>> createReceipts(int year) async {
    final created = toCreate;
    receipts = [...receipts, ...created];
    previews = [];
    toCreate = [];
    return created;
  }

  @override
  Future<Donation> addDirect(Donation donation) async {
    final added = donation.copyWith(id: 900 + donations.length);
    donations = [...donations, added];
    return added;
  }

  @override
  Future<ByteData> getReceiptPdf(int receiptId) async =>
      ByteData.sublistView(Uint8List.fromList('%PDF-fake'.codeUnits));
}

class FakeHouseholds extends Fake implements EndpointHousehold {
  var households = <Household>[];

  /// The contacts that members are made of when a household is saved.
  var contacts = <Contact>[];

  @override
  Future<List<Household>> getAll() async => households;

  @override
  Future<Household> save(Household household, List<int> memberIds) async {
    final id = household.id ?? 700 + households.length;
    final saved = household.copyWith(
      id: id,
      members: [
        for (final contact in contacts)
          if (memberIds.contains(contact.id))
            HouseholdMember(
              householdId: id,
              contactId: contact.id!,
              contact: contact,
            ),
      ],
    );
    households = [
      for (final other in households)
        if (other.id != id) other,
      saved,
    ];
    return saved;
  }
}

class FakeDashboards extends Fake implements EndpointDashboard {
  /// A day with nothing going on.
  var shown = Dashboard(
    today: DateTime.utc(2026, 10, 12),
    arrivals: [],
    departures: [],
    roomsOccupied: 0,
    roomsTotal: 0,
    guestsTonight: 0,
    expiringOptions: [],
    openBalances: [],
    meals: [
      for (final day in [12, 13])
        MealDay(
          date: DateTime.utc(2026, 10, day),
          bookings: [],
          guestCount: 0,
          ageGroups: [],
          unknownAge: 0,
        ),
    ],
  );

  @override
  Future<Dashboard> load() async => shown;
}

class FakeOperators extends Fake implements EndpointOperator {
  Operator? operator;

  @override
  Future<Operator?> load() async => operator;

  @override
  Future<Operator> save(Operator operator) async =>
      this.operator = operator.copyWith(id: 1);
}

/// A client with a small but complete setup: two rooms, two price lists
/// with prices and a fee, two contacts, and bookings in October 2026.
FakeClient filledClient({UserRole? role = UserRole.admin}) {
  final client = FakeClient(role: role);
  client.unitType.types = [
    UnitType(id: 1, name: 'Standard', sortOrder: 0),
    UnitType(id: 2, name: 'Comfort', sortOrder: 1),
  ];
  final annex = Building(id: 1, name: 'Annex');
  client.building.buildings = [annex];
  final room101 = Room(
    id: 1,
    roomNumber: '101',
    bedAmount: 4,
    unitTypeId: 1,
    unitType: client.unitType.types.first,
    cribPossible: true,
    fees: [],
  );
  final room102 = Room(
    id: 2,
    roomNumber: '102',
    bedAmount: 1,
    unitTypeId: 2,
    unitType: client.unitType.types.last,
    active: false,
    buildingId: 1,
    building: annex,
    fees: [],
  );
  final room103 = Room(
    id: 3,
    roomNumber: '103',
    bedAmount: 2,
    unitTypeId: 1,
    unitType: client.unitType.types.first,
  );
  client.room.rooms = [room101, room102];
  client.ageGroup.groups = [
    AgeGroup(id: 1, name: 'Child', minAge: 0, maxAge: 17),
    AgeGroup(id: 2, name: 'Adult', minAge: 18),
  ];
  // Both price lists begin after today, so the first one is shown.
  client.priceList.lists = [
    PriceList(id: 1, name: 'Prices 2127', validFrom: DateTime.utc(2127)),
    PriceList(id: 2, name: 'Prices 2128', validFrom: DateTime.utc(2128)),
  ];
  client.mealPlan.plans = [MealPlan(id: 1, name: 'Full board')];
  client.fee.fees = [
    Fee(
      id: 1,
      name: 'Tourist tax',
      unit: FeeUnit.perPersonNight,
      ageGroupId: 2,
      taxRate: 700,
      autoApply: true,
      rooms: [],
    ),
  ];
  client.priceList.prices[1] = PriceListPrices(
    roomRates: [
      RoomRate(
        priceListId: 1,
        unitTypeId: 1,
        ageGroupId: 2,
        pricePerNight: 2500,
      ),
    ],
    unitPrices: [],
    mealRates: [],
    feePrices: [FeePrice(priceListId: 1, feeId: 1, amount: 200)],
  );

  final lindenschule = Organization(
    id: 1,
    name: 'Lindenschule',
    city: 'Kassel',
  );
  client.organization.organizations = [lindenschule];
  final teacher = Contact(
    id: 1,
    firstName: 'Marie',
    lastName: 'Weber',
    mail: 'marie.weber@example.com',
    organizationId: 1,
    organization: lindenschule,
  );
  client.contact.contacts = [
    Contact(id: 2, firstName: 'Felix', lastName: 'Wagner', city: 'Erfurt'),
    teacher,
  ];

  final school = BookingCategory(
    id: 1,
    name: 'School',
    icon: BookingCategoryIcon.education,
    color: BookingCategoryColor.blue,
  );
  client.bookingCategory.categories = [school];

  Booking booking(
    int id,
    String title,
    int arrival,
    int departure,
    BookingStatus status,
    List<Room> rooms, {
    BookingCategory? category,
  }) => Booking(
    id: id,
    title: title,
    categoryId: category?.id,
    category: category,
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
    booking(
      1,
      'Class trip',
      12,
      16,
      BookingStatus.confirmed,
      [room101],
      category: school,
    ),
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
  client.guest.kitchen = KitchenOverview(
    guestCount: 3,
    ageGroups: [
      AgeGroupCount(ageGroup: client.ageGroup.groups.first, count: 2),
      AgeGroupCount(ageGroup: client.ageGroup.groups.last, count: 0),
    ],
    unknownAge: 1,
    dietaryNeeds: [
      DietaryNeed(
        guestName: 'Jonas Weber',
        groupName: 'Weber family',
        ageGroupName: 'Child',
        notes: 'No nuts',
      ),
    ],
  );

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
          description: 'Standard · Adult',
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
  // The 12th of October 2026, the day the class trip arrives.
  final child = client.ageGroup.groups.first;
  final adult = client.ageGroup.groups.last;
  client.dashboard.shown = Dashboard(
    today: DateTime.utc(2026, 10, 12),
    arrivals: [
      DashboardStay(
        bookingId: 1,
        title: 'Class trip',
        status: BookingStatus.confirmed,
        date: DateTime.utc(2026, 10, 12),
        leadName: 'Marie Weber',
        guestCount: 3,
        roomCount: 1,
      ),
      DashboardStay(
        bookingId: 2,
        title: 'Choir weekend',
        status: BookingStatus.option,
        date: DateTime.utc(2026, 10, 16),
        leadName: 'Marie Weber',
        roomCount: 0,
      ),
    ],
    departures: [
      DashboardStay(
        bookingId: 1,
        title: 'Class trip',
        status: BookingStatus.confirmed,
        date: DateTime.utc(2026, 10, 16),
        leadName: 'Marie Weber',
        guestCount: 3,
        roomCount: 1,
      ),
    ],
    roomsOccupied: 1,
    roomsTotal: 4,
    guestsTonight: 3,
    expiringOptions: [
      ExpiringOption(
        bookingId: 2,
        title: 'Choir weekend',
        expiresAt: DateTime.utc(2026, 10, 10),
      ),
      ExpiringOption(
        bookingId: 2,
        title: 'Autumn retreat',
        expiresAt: DateTime.utc(2026, 10, 20),
      ),
    ],
    openBalances: [
      OpenBalance(
        bookingId: 1,
        bookingTitle: 'Class trip',
        invoiceNumber: '2026-0007',
        payerName: 'Marie Weber',
        owed: 14000,
      ),
    ],
    meals: [
      MealDay(
        date: DateTime.utc(2026, 10, 12),
        bookings: [
          MealBooking(
            bookingId: 1,
            title: 'Class trip',
            mealPlan: 'Full board',
            guestCount: 3,
            ageGroups: [
              AgeGroupCount(ageGroup: child, count: 2),
              AgeGroupCount(ageGroup: adult, count: 1),
            ],
            unknownAge: 0,
          ),
        ],
        guestCount: 3,
        ageGroups: [
          AgeGroupCount(ageGroup: child, count: 2),
          AgeGroupCount(ageGroup: adult, count: 1),
        ],
        unknownAge: 0,
      ),
      MealDay(
        date: DateTime.utc(2026, 10, 13),
        bookings: [],
        guestCount: 0,
        ageGroups: [
          AgeGroupCount(ageGroup: child, count: 0),
          AgeGroupCount(ageGroup: adult, count: 0),
        ],
        unknownAge: 0,
      ),
    ],
  );

  // Felix lives alone in a household of his own.
  client.household.contacts = client.contact.contacts;
  client.household.households = [
    Household(
      id: 1,
      name: 'Wagner household',
      members: [
        HouseholdMember(
          householdId: 1,
          contactId: 2,
          contact: client.contact.contacts.first,
        ),
      ],
    ),
  ];

  // This year one donation is on a receipt and one is waiting for its own.
  final year = DateTime.now().year;
  final felix = client.contact.contacts.first;
  final issued = DonationReceipt(
    id: 1,
    contactId: felix.id!,
    contact: felix,
    year: year,
    number: 'SB-$year-0001',
    total: 5000,
    issuedAt: DateTime.utc(year, 4, 1),
  );
  client.donation.receipts = [issued];
  client.donation.donations = [
    Donation(
      id: 1,
      contactId: felix.id!,
      contact: felix,
      amount: 5000,
      date: DateTime.utc(year, 3, 1),
      source: DonationSource.direct,
      receiptId: issued.id,
      receipt: issued,
    ),
    Donation(
      id: 2,
      contactId: teacher.id!,
      contact: teacher,
      amount: 1000,
      date: DateTime.utc(year, 10, 16),
      source: DonationSource.overpayment,
    ),
  ];
  client.donation.previews = [
    ReceiptPreview(
      contact: teacher,
      donationCount: 1,
      total: 1000,
      addressComplete: true,
    ),
  ];
  client.donation.toCreate = [
    DonationReceipt(
      id: 2,
      contactId: teacher.id!,
      contact: teacher,
      year: year,
      number: 'SB-$year-0002',
      total: 1000,
      issuedAt: DateTime.utc(year, 12, 31),
    ),
  ];
  client.pricing.price = BookingPrice(
    lines: [
      ChargeLine(
        guestId: 1,
        type: ChargeType.lodging,
        description: 'Standard · Adult',
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
        reason: PricingProblemReason.priceListMissing,
        detail: '2026-10-15',
      ),
    ],
  );
  return client;
}

/// Shows [home] in an app that talks to [client]. Without [settle] it does
/// not wait for animations to end, which one that shows loading never does.
Future<void> pumpApp(
  WidgetTester tester,
  Widget home,
  FakeClient client, {
  Size size = const Size(1200, 800),
  AppLocale locale = AppLocale.en,
  List<Override> overrides = const [],
  bool settle = true,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  LocaleSettings.setLocaleSync(locale);
  SharedPreferences.setMockInitialValues({'settings.locale': locale.name});
  final preferences = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      observers: [StatusObserver()],
      overrides: [
        serverpodClientProvider.overrideWithValue(client),
        sharedPreferencesProvider.overrideWithValue(preferences),
        ...overrides,
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
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
  }
}

/// What the status bar says, which the panels are shown without.
StatusMessage? statusMessage(WidgetTester tester) => ProviderScope.containerOf(
  tester.element(find.byType(Scaffold).first),
).read(statusProvider).message;

Finder field(String label) => find.widgetWithText(TextFormField, label);

/// Taps a button that may be scrolled out of view, such as one of the
/// sections of the admin panel.
Future<void> open(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

/// The card of the page of a booking that has [title], such as "Rooms".
Finder card(String title) =>
    find.ancestor(of: find.text(title), matching: find.byType(BookingCard));

/// What [finder] finds in the card that has [title].
Finder inCard(String title, Finder finder) =>
    find.descendant(of: card(title), matching: finder);

/// What [finder] finds in the overlay that was opened from a card. The page
/// stays below the overlay, so a text of a card may be there twice.
Finder inOverlay(Finder finder) =>
    find.descendant(of: find.byType(BookingOverlay), matching: finder);

/// Opens the overlay that changes what the card with [title] shows.
Future<void> editCard(WidgetTester tester, String title) async {
  final button = inCard(title, find.byTooltip('Edit'));
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}
