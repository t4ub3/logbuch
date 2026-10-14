import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/bookings/deleted_bookings.dart';
import 'package:logbuch_server/src/common/today.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/contacts/contact_endpoint.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';
import 'package:logbuch_server/src/guests/individual_guests.dart';
import 'package:logbuch_server/src/guests/kitchen_overview.dart';

/// The guests of a booking, in groups such as families. Guests who were
/// added without a group are in a group of their own kind, which is
/// [GuestGroup.individual].
class GuestEndpoint extends AppEndpoint {
  /// The groups of the booking with their guests and the contacts of those.
  /// The guests without a group come first.
  Future<List<GuestGroup>> getByBooking(Session session, int bookingId) async {
    return GuestGroup.db.find(
      session,
      where: (t) => t.bookingId.equals(bookingId),
      orderByList: (t) => [
        t.individual.desc(),
        t.sortOrder.asc(),
        t.id.asc(),
      ],
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
    final booking = await findBooking(session, bookingId);
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
  /// after the household. Members who are guests of the booking without a
  /// group join it; those who are in another group are left out, so that
  /// nobody is there twice.
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
        include: Guest.include(group: GuestGroup.include()),
        transaction: transaction,
      );
      final present = {for (final guest in guests) guest.contactId: guest};
      final members = [
        for (final member in household.members ?? <HouseholdMember>[])
          member.contactId,
      ];
      final added = [
        for (final contactId in members)
          if (!present.containsKey(contactId)) contactId,
      ];
      final joining = [
        for (final contactId in members)
          if (present[contactId] case final guest? when guest.group!.individual)
            guest,
      ];
      if (added.isEmpty && joining.isEmpty) {
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
      await Guest.db.update(
        session,
        [for (final guest in joining) guest.copyWith(groupId: group.id)],
        columns: (t) => [t.groupId],
        transaction: transaction,
      );
      for (final groupId in {for (final guest in joining) guest.groupId}) {
        await deleteIfEmptyIndividual(session, groupId, transaction);
      }
      return group;
    });
  }

  /// Adds a group. The group of the guests without one is only made by
  /// [addWithoutGroup].
  Future<GuestGroup> addGroup(Session session, GuestGroup group) async {
    requireAdmin(session);
    return await GuestGroup.db.insertRow(
      session,
      group.copyWith(name: requireName(group.name), individual: false),
    );
  }

  /// Changes a group. The group of the guests without one stays that and
  /// keeps its empty name.
  Future<GuestGroup> updateGroup(Session session, GuestGroup group) async {
    requireAdmin(session);
    final stored = await GuestGroup.db.findById(session, group.id!);
    if (stored == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    return await GuestGroup.db.updateRow(
      session,
      group.copyWith(
        name: stored.individual ? '' : requireName(group.name),
        individual: stored.individual,
      ),
    );
  }

  /// Also removes the guests of the group from the booking. Their contacts
  /// stay.
  Future<void> deleteGroup(Session session, int id) async {
    requireAdmin(session);
    await GuestGroup.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// Adds a contact to a group as a guest. A contact who is a guest of the
  /// booking without a group, such as its lead, joins the group instead and
  /// keeps what is known about them where [guest] says nothing else. A
  /// contact is never a guest of a booking twice.
  Future<Guest> addGuest(Session session, Guest guest) async {
    requireAdmin(session);
    return session.db.transaction((transaction) async {
      final group = await GuestGroup.db.findById(
        session,
        guest.groupId,
        transaction: transaction,
      );
      if (group == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      final present = await guestOfBooking(
        session,
        group.bookingId,
        guest.contactId,
        transaction,
      );
      if (present == null) {
        await _validate(session, guest, transaction: transaction);
        return Guest.db.insertRow(session, guest, transaction: transaction);
      }
      if (!present.group!.individual || group.individual) {
        throw ValidationException(reason: ValidationError.alreadyGuest);
      }
      final joined = Guest(
        id: present.id,
        groupId: group.id!,
        contactId: present.contactId,
        bookingRoomId: guest.bookingRoomId ?? present.bookingRoomId,
        needsCrib: guest.needsCrib || present.needsCrib,
        ageGroupOverrideId:
            guest.ageGroupOverrideId ?? present.ageGroupOverrideId,
        arrivalOverride: guest.arrivalOverride ?? present.arrivalOverride,
        departureOverride: guest.departureOverride ?? present.departureOverride,
        dietaryNotes: guest.dietaryNotes ?? present.dietaryNotes,
      );
      await _validate(session, joined, transaction: transaction);
      final updated = await Guest.db.updateRow(
        session,
        joined,
        transaction: transaction,
      );
      await deleteIfEmptyIndividual(session, present.groupId, transaction);
      return updated;
    });
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

  /// Adds a guest to the booking without a group, into the group of the
  /// booking for such guests, which comes with the first of them. With
  /// [newContact] the guest is not a contact yet, and [newContact] is
  /// created along with the guest; otherwise [Guest.contactId] names the
  /// contact, who must not be a guest of the booking yet.
  Future<Guest> addWithoutGroup(
    Session session,
    int bookingId,
    Guest guest,
    Contact? newContact,
  ) async {
    requireAdmin(session);
    final validated = newContact == null ? null : validatedContact(newContact);
    return session.db.transaction((transaction) async {
      final booking = await findBooking(
        session,
        bookingId,
        transaction: transaction,
      );
      if (booking == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      if (validated == null &&
          await guestOfBooking(
                session,
                bookingId,
                guest.contactId,
                transaction,
              ) !=
              null) {
        throw ValidationException(reason: ValidationError.alreadyGuest);
      }
      final group = await individualGroup(session, bookingId, transaction);
      var added = guest.copyWith(groupId: group.id);
      if (validated != null) {
        final contact = await Contact.db.insertRow(
          session,
          validated,
          transaction: transaction,
        );
        added = added.copyWith(contactId: contact.id);
      }
      await _validate(session, added, transaction: transaction);
      return Guest.db.insertRow(session, added, transaction: transaction);
    });
  }

  Future<Guest> updateGuest(Session session, Guest guest) async {
    requireAdmin(session);
    await _validate(session, guest);
    return await Guest.db.updateRow(session, guest);
  }

  /// Removes the guest from the booking. The contact stays. The group of
  /// the guests without one goes with the last of them.
  Future<void> deleteGuest(Session session, int id) async {
    requireAdmin(session);
    await session.db.transaction((transaction) async {
      final deleted = await Guest.db.deleteWhere(
        session,
        where: (t) => t.id.equals(id),
        transaction: transaction,
      );
      for (final guest in deleted) {
        await deleteIfEmptyIndividual(session, guest.groupId, transaction);
      }
    });
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
