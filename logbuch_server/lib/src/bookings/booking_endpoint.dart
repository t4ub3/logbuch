import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class BookingEndpoint extends AppEndpoint {
  Future<List<Booking>> getAll(Session session) async {
    return Booking.db.find(session, include: _details());
  }

  Future<Booking?> getById(Session session, int id) async {
    return Booking.db.findById(session, id, include: _details());
  }

  /// Creates a booking without rooms; those are set with [setRooms].
  Future<Booking> add(Session session, Booking booking) async {
    requireAdmin(session);
    final added = await Booking.db.insertRow(session, _validated(booking));
    return (await getById(session, added.id!))!;
  }

  /// Updates a booking. The rooms it holds must also be free for its new
  /// dates and status. Who is billed cannot change anymore once one of
  /// its folios is invoiced.
  Future<Booking> update(Session session, Booking booking) async {
    requireAdmin(session);
    final validated = _validated(booking);
    await session.db.transaction((transaction) async {
      final stored = await Booking.db.findById(
        session,
        booking.id!,
        transaction: transaction,
      );
      if (stored != null && stored.billingMode != validated.billingMode) {
        final invoiced = await Folio.db.count(
          session,
          where: (t) =>
              t.bookingId.equals(booking.id) & t.invoiceNumber.notEquals(null),
          transaction: transaction,
        );
        if (invoiced > 0) {
          throw ValidationException(reason: ValidationError.alreadyInvoiced);
        }
      }
      final held = await BookingRoom.db.find(
        session,
        where: (t) => t.bookingId.equals(booking.id),
        transaction: transaction,
      );
      await _requireFree(
        session,
        validated,
        {for (final hold in held) hold.roomId},
        transaction,
      );
      await Booking.db.updateRow(session, validated, transaction: transaction);
    });
    return (await getById(session, booking.id!))!;
  }

  /// The active rooms that no booking holds during the nights from [arrival]
  /// to [departure]. The rooms of [exceptBookingId] count as free, so that
  /// the booking can keep them.
  Future<List<Room>> availableRooms(
    Session session,
    DateTime arrival,
    DateTime departure, {
    int? exceptBookingId,
  }) async {
    requireDateOnly(arrival);
    requireDateOnly(departure);
    final taken = await _takenRooms(
      session,
      arrival,
      departure,
      exceptBookingId: exceptBookingId,
    );
    final rooms = await Room.db.find(
      session,
      where: (t) => t.active.equals(true),
      orderBy: (t) => t.roomNumber,
      include: Room.include(priceCategory: PriceCategory.include()),
    );
    return [
      for (final room in rooms)
        if (!taken.containsKey(room.id)) room,
    ];
  }

  /// Replaces the rooms that the booking holds. Fails if one of them is
  /// held by another booking during its nights.
  Future<Booking> setRooms(
    Session session,
    int bookingId,
    List<int> roomIds,
  ) async {
    requireAdmin(session);
    final wanted = roomIds.toSet();
    await session.db.transaction((transaction) async {
      final booking = await Booking.db.findById(
        session,
        bookingId,
        transaction: transaction,
      );
      if (booking == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      await _requireFree(session, booking, wanted, transaction);

      final held = await BookingRoom.db.find(
        session,
        where: (t) => t.bookingId.equals(bookingId),
        transaction: transaction,
      );
      final heldIds = {for (final hold in held) hold.roomId};
      // Rooms that stay keep their row, as guests are assigned to it.
      final removed = heldIds.difference(wanted);
      final added = wanted.difference(heldIds);
      if (removed.isNotEmpty) {
        await BookingRoom.db.deleteWhere(
          session,
          where: (t) => t.bookingId.equals(bookingId) & t.roomId.inSet(removed),
          transaction: transaction,
        );
      }
      if (added.isNotEmpty) {
        await _requireActive(session, added, transaction);
        await BookingRoom.db.insert(
          session,
          [
            for (final roomId in added)
              BookingRoom(bookingId: bookingId, roomId: roomId),
          ],
          transaction: transaction,
        );
      }
    });
    return (await getById(session, bookingId))!;
  }

  Booking _validated(Booking booking) {
    final title = requireName(booking.title);
    final arrival = booking.arrival;
    final departure = booking.departure;
    if ((arrival == null) != (departure == null)) {
      throw ValidationException(reason: ValidationError.invalidDateRange);
    }
    if (arrival != null && departure != null) {
      requireDateOnly(arrival);
      requireDateOnly(departure);
      if (departure.isBefore(arrival)) {
        throw ValidationException(reason: ValidationError.invalidDateRange);
      }
    }
    if (booking.optionExpiresAt case final expiry?) requireDateOnly(expiry);
    if (booking.expectedGuestCount case final guests? when guests < 0) {
      throw ValidationException(reason: ValidationError.invalidGuestCount);
    }
    return booking.copyWith(title: title);
  }

  /// Fails unless the rooms are free during the nights of [booking]. The
  /// rooms are locked first, so that two bookings that are saved at the same
  /// time cannot both get a room. A cancelled booking takes no rooms from
  /// others and is not checked.
  Future<void> _requireFree(
    Session session,
    Booking booking,
    Set<int> roomIds,
    Transaction transaction,
  ) async {
    if (roomIds.isEmpty || booking.status == BookingStatus.cancelled) return;
    final arrival = booking.arrival;
    final departure = booking.departure;
    if (arrival == null || departure == null) {
      throw ValidationException(reason: ValidationError.datesRequired);
    }

    await Room.db.lockRows(
      session,
      where: (t) => t.id.inSet(roomIds),
      lockMode: LockMode.forUpdate,
      transaction: transaction,
    );
    final taken = await _takenRooms(
      session,
      arrival,
      departure,
      exceptBookingId: booking.id,
      roomIds: roomIds,
      transaction: transaction,
    );
    if (taken.isNotEmpty) {
      throw ValidationException(
        reason: ValidationError.roomUnavailable,
        detail: _roomNumbers(taken.values),
      );
    }
  }

  /// Fails if one of the rooms does not exist or was set inactive.
  Future<void> _requireActive(
    Session session,
    Set<int> roomIds,
    Transaction transaction,
  ) async {
    final rooms = await Room.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
      transaction: transaction,
    );
    if (rooms.length != roomIds.length) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    final inactive = rooms.where((room) => !room.active);
    if (inactive.isNotEmpty) {
      throw ValidationException(
        reason: ValidationError.roomUnavailable,
        detail: _roomNumbers(inactive),
      );
    }
  }

  /// The rooms, by id, that bookings hold during the nights from [arrival]
  /// to [departure]. A room is free again on the day its guests depart, and
  /// cancelled bookings hold nothing.
  Future<Map<int, Room>> _takenRooms(
    Session session,
    DateTime arrival,
    DateTime departure, {
    int? exceptBookingId,
    Set<int>? roomIds,
    Transaction? transaction,
  }) async {
    final holds = await BookingRoom.db.find(
      session,
      where: (t) {
        var taken =
            t.booking.status.notEquals(BookingStatus.cancelled) &
            (t.booking.arrival < departure) &
            (t.booking.departure > arrival);
        if (exceptBookingId != null) {
          taken = taken & t.bookingId.notEquals(exceptBookingId);
        }
        if (roomIds != null) taken = taken & t.roomId.inSet(roomIds);
        return taken;
      },
      include: BookingRoom.include(room: Room.include()),
      transaction: transaction,
    );
    return {for (final hold in holds) hold.roomId: hold.room!};
  }
}

BookingInclude _details() => Booking.include(
  lead: Contact.include(),
  organization: Organization.include(),
  mealPlan: MealPlan.include(),
  rooms: BookingRoom.includeList(
    include: BookingRoom.include(
      room: Room.include(priceCategory: PriceCategory.include()),
    ),
  ),
);

String _roomNumbers(Iterable<Room> rooms) =>
    (rooms.map((room) => room.roomNumber).toList()..sort()).join(', ');
