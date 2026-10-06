import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/today.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/contacts/contact_endpoint.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';
import 'package:logbuch_server/src/guests/kitchen_overview.dart';

/// The guests of a booking, in groups such as families.
class GuestEndpoint extends AppEndpoint {
  /// The groups of the booking with their guests and the contacts of those.
  Future<List<GuestGroup>> getByBooking(Session session, int bookingId) async {
    return GuestGroup.db.find(
      session,
      where: (t) => t.bookingId.equals(bookingId),
      orderByList: (t) => [t.sortOrder.asc(), t.id.asc()],
      include: GuestGroup.include(
        payer: Contact.include(),
        guests: Guest.includeList(
          orderBy: (t) => t.id,
          include: Guest.include(contact: Contact.include()),
        ),
      ),
    );
  }

  /// The guests of the booking summed up for the kitchen: how many there
  /// are in every age group, and their dietary needs.
  Future<KitchenOverview> kitchenOverview(
    Session session,
    int bookingId,
  ) async {
    final booking = await Booking.db.findById(session, bookingId);
    if (booking == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    return buildKitchenOverview(
      booking: booking,
      groups: await getByBooking(session, bookingId),
      ageGroups: await AgeGroup.db.find(session),
      today: await todayInGermany(session),
    );
  }

  /// Adds the members of a household to the booking, as a new group named
  /// after the household. Members who are guests of the booking already are
  /// left out, so that nobody is there twice.
  Future<GuestGroup> addHousehold(
    Session session,
    int bookingId,
    int householdId,
  ) async {
    requireAdmin(session);
    return session.db.transaction((transaction) async {
      final household = await Household.db.findById(
        session,
        householdId,
        include: Household.include(
          members: HouseholdMember.includeList(orderBy: (t) => t.id),
        ),
        transaction: transaction,
      );
      if (household == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      final guests = await Guest.db.find(
        session,
        where: (t) => t.group.bookingId.equals(bookingId),
        transaction: transaction,
      );
      final present = {for (final guest in guests) guest.contactId};
      final added = [
        for (final member in household.members ?? <HouseholdMember>[])
          if (!present.contains(member.contactId)) member.contactId,
      ];
      if (added.isEmpty) {
        throw ValidationException(reason: ValidationError.alreadyGuest);
      }

      final group = await GuestGroup.db.insertRow(
        session,
        GuestGroup(bookingId: bookingId, name: household.name),
        transaction: transaction,
      );
      await Guest.db.insert(
        session,
        [
          for (final contactId in added)
            Guest(groupId: group.id!, contactId: contactId),
        ],
        transaction: transaction,
      );
      return group;
    });
  }

  Future<GuestGroup> addGroup(Session session, GuestGroup group) async {
    requireAdmin(session);
    return await GuestGroup.db.insertRow(
      session,
      group.copyWith(name: requireName(group.name)),
    );
  }

  Future<GuestGroup> updateGroup(Session session, GuestGroup group) async {
    requireAdmin(session);
    return await GuestGroup.db.updateRow(
      session,
      group.copyWith(name: requireName(group.name)),
    );
  }

  /// Also removes the guests of the group from the booking. Their contacts
  /// stay.
  Future<void> deleteGroup(Session session, int id) async {
    requireAdmin(session);
    await GuestGroup.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// Adds a contact to a group as a guest.
  Future<Guest> addGuest(Session session, Guest guest) async {
    requireAdmin(session);
    await _validate(session, guest);
    return await Guest.db.insertRow(session, guest);
  }

  /// Adds a guest who is not a contact yet. [contact] is created along with
  /// the guest.
  Future<Guest> addNewGuest(
    Session session,
    Guest guest,
    Contact contact,
  ) async {
    requireAdmin(session);
    final validated = validatedContact(contact);
    return session.db.transaction((transaction) async {
      final added = await Contact.db.insertRow(
        session,
        validated,
        transaction: transaction,
      );
      final withContact = guest.copyWith(contactId: added.id);
      await _validate(session, withContact, transaction: transaction);
      return Guest.db.insertRow(session, withContact, transaction: transaction);
    });
  }

  Future<Guest> updateGuest(Session session, Guest guest) async {
    requireAdmin(session);
    await _validate(session, guest);
    return await Guest.db.updateRow(session, guest);
  }

  /// Removes the guest from the booking. The contact stays.
  Future<void> deleteGuest(Session session, int id) async {
    requireAdmin(session);
    await Guest.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// Puts the guests into a room that their booking holds, or takes them out
  /// of their rooms if [bookingRoomId] is null.
  ///
  /// More guests than beds are accepted, as is a crib where none fits: guests
  /// are often moved around until everybody has a place, and the room shows
  /// that it is overfull meanwhile.
  Future<void> assign(
    Session session,
    List<int> guestIds,
    int? bookingRoomId,
  ) async {
    requireAdmin(session);
    if (guestIds.isEmpty) return;
    await session.db.transaction((transaction) async {
      final guests = await Guest.db.find(
        session,
        where: (t) => t.id.inSet(guestIds.toSet()),
        include: Guest.include(group: GuestGroup.include()),
        transaction: transaction,
      );
      if (bookingRoomId != null) {
        final bookingIds = {for (final guest in guests) guest.group!.bookingId};
        await _requireHeld(session, bookingRoomId, bookingIds, transaction);
      }
      await Guest.db.update(
        session,
        [
          for (final guest in guests)
            guest.copyWith(bookingRoomId: bookingRoomId),
        ],
        columns: (t) => [t.bookingRoomId],
        transaction: transaction,
      );
    });
  }

  Future<void> _validate(
    Session session,
    Guest guest, {
    Transaction? transaction,
  }) async {
    final arrival = guest.arrivalOverride;
    final departure = guest.departureOverride;
    if (arrival != null) requireDateOnly(arrival);
    if (departure != null) requireDateOnly(departure);
    if (arrival != null && departure != null && departure.isBefore(arrival)) {
      throw ValidationException(reason: ValidationError.invalidDateRange);
    }
    if (guest.bookingRoomId case final bookingRoomId?) {
      final group = await GuestGroup.db.findById(
        session,
        guest.groupId,
        transaction: transaction,
      );
      await _requireHeld(
        session,
        bookingRoomId,
        {?group?.bookingId},
        transaction,
      );
    }
  }

  /// Fails unless the room is held by the one booking of [bookingIds].
  Future<void> _requireHeld(
    Session session,
    int bookingRoomId,
    Set<int> bookingIds,
    Transaction? transaction,
  ) async {
    final hold = await BookingRoom.db.findById(
      session,
      bookingRoomId,
      transaction: transaction,
    );
    if (hold == null ||
        bookingIds.length != 1 ||
        hold.bookingId != bookingIds.single) {
      throw ValidationException(reason: ValidationError.roomNotHeld);
    }
  }
}
