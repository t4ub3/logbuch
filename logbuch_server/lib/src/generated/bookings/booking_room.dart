/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../bookings/bookings.dart' as _i2jbfzmp;
import '../rooms/room.dart' as _ij8xg2ak;

/// A room that a booking holds for all of its nights.
abstract class BookingRoom
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookingRoom._({
    this.id,
    required this.bookingId,
    this.booking,
    required this.roomId,
    this.room,
  });

  factory BookingRoom({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int roomId,
    _ij8xg2ak.Room? room,
  }) = _BookingRoomImpl;

  factory BookingRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingRoom(
      id: jsonSerialization['id'] as int?,
      bookingId: jsonSerialization['bookingId'] as int,
      booking: jsonSerialization['booking'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i2jbfzmp.Booking>(
              jsonSerialization['booking'],
            ),
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_ij8xg2ak.Room>(
              jsonSerialization['room'],
            ),
    );
  }

  static final t = BookingRoomTable();

  static const db = BookingRoomRepository._();

  @override
  int? id;

  int bookingId;

  _i2jbfzmp.Booking? booking;

  int roomId;

  _ij8xg2ak.Room? room;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookingRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingRoom copyWith({
    int? id,
    int? bookingId,
    _i2jbfzmp.Booking? booking,
    int? roomId,
    _ij8xg2ak.Room? room,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingRoom',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJson(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingRoom',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJsonForProtocol(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
    };
  }

  static BookingRoomInclude include({
    _i2jbfzmp.BookingInclude? booking,
    _ij8xg2ak.RoomInclude? room,
  }) {
    return BookingRoomInclude._(
      booking: booking,
      room: room,
    );
  }

  static BookingRoomIncludeList includeList({
    _is.WhereExpressionBuilder<BookingRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingRoomTable>? orderBy,
    _is.OrderByListBuilder<BookingRoomTable>? orderByList,
    BookingRoomInclude? include,
  }) {
    return BookingRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookingRoom.t),
      orderByList: orderByList?.call(BookingRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingRoomImpl extends BookingRoom {
  _BookingRoomImpl({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int roomId,
    _ij8xg2ak.Room? room,
  }) : super._(
         id: id,
         bookingId: bookingId,
         booking: booking,
         roomId: roomId,
         room: room,
       );

  /// Returns a shallow copy of this [BookingRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingRoom copyWith({
    Object? id = _Undefined,
    int? bookingId,
    Object? booking = _Undefined,
    int? roomId,
    Object? room = _Undefined,
  }) {
    return BookingRoom(
      id: id is int? ? id : this.id,
      bookingId: bookingId ?? this.bookingId,
      booking: booking is _i2jbfzmp.Booking?
          ? booking
          : this.booking?.copyWith(),
      roomId: roomId ?? this.roomId,
      room: room is _ij8xg2ak.Room? ? room : this.room?.copyWith(),
    );
  }
}

class BookingRoomUpdateTable extends _is.UpdateTable<BookingRoomTable> {
  BookingRoomUpdateTable(super.table);

  _is.ColumnValue<int, int> bookingId(int value) => _is.ColumnValue(
    table.bookingId,
    value,
  );

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );
}

class BookingRoomTable extends _is.Table<int?> {
  BookingRoomTable({super.tableRelation}) : super(tableName: 'booking_rooms') {
    updateTable = BookingRoomUpdateTable(this);
    bookingId = _is.ColumnInt(
      'bookingId',
      this,
    );
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
  }

  late final BookingRoomUpdateTable updateTable;

  late final _is.ColumnInt bookingId;

  _i2jbfzmp.BookingTable? _booking;

  late final _is.ColumnInt roomId;

  _ij8xg2ak.RoomTable? _room;

  _i2jbfzmp.BookingTable get booking {
    if (_booking != null) return _booking!;
    _booking = _is.createRelationTable(
      relationFieldName: 'booking',
      field: BookingRoom.t.bookingId,
      foreignField: _i2jbfzmp.Booking.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2jbfzmp.BookingTable(tableRelation: foreignTableRelation),
    );
    return _booking!;
  }

  _ij8xg2ak.RoomTable get room {
    if (_room != null) return _room!;
    _room = _is.createRelationTable(
      relationFieldName: 'room',
      field: BookingRoom.t.roomId,
      foreignField: _ij8xg2ak.Room.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ij8xg2ak.RoomTable(tableRelation: foreignTableRelation),
    );
    return _room!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    bookingId,
    roomId,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'booking') {
      return booking;
    }
    if (relationField == 'room') {
      return room;
    }
    return null;
  }
}

class BookingRoomInclude extends _is.IncludeObject {
  BookingRoomInclude._({
    _i2jbfzmp.BookingInclude? booking,
    _ij8xg2ak.RoomInclude? room,
  }) {
    _booking = booking;
    _room = room;
  }

  _i2jbfzmp.BookingInclude? _booking;

  _ij8xg2ak.RoomInclude? _room;

  @override
  Map<String, _is.Include?> get includes => {
    'booking': _booking,
    'room': _room,
  };

  @override
  _is.Table<int?> get table => BookingRoom.t;
}

class BookingRoomIncludeList extends _is.IncludeList {
  BookingRoomIncludeList._({
    _is.WhereExpressionBuilder<BookingRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookingRoom.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookingRoom.t;
}

class BookingRoomRepository {
  const BookingRoomRepository._();

  final attachRow = const BookingRoomAttachRowRepository._();

  /// Returns a list of [BookingRoom]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<BookingRoom>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingRoomTable>? orderBy,
    _is.OrderByListBuilder<BookingRoomTable>? orderByList,
    _is.Transaction? transaction,
    BookingRoomInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookingRoom>(
      where: where?.call(BookingRoom.t),
      orderBy: orderBy?.call(BookingRoom.t),
      orderByList: orderByList?.call(BookingRoom.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookingRoom] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<BookingRoom?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingRoomTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingRoomTable>? orderBy,
    _is.OrderByListBuilder<BookingRoomTable>? orderByList,
    _is.Transaction? transaction,
    BookingRoomInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookingRoom>(
      where: where?.call(BookingRoom.t),
      orderBy: orderBy?.call(BookingRoom.t),
      orderByList: orderByList?.call(BookingRoom.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookingRoom] by its [id] or null if no such row exists.
  Future<BookingRoom?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    BookingRoomInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookingRoom>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookingRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [BookingRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingRoom>> insert(
    _is.DatabaseSession session,
    List<BookingRoom> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookingRoom>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookingRoom] and returns the inserted row.
  ///
  /// The returned [BookingRoom] will have its `id` field set.
  Future<BookingRoom> insertRow(
    _is.DatabaseSession session,
    BookingRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookingRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BookingRoom]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [BookingRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingRoom>> upsert(
    _is.DatabaseSession session,
    List<BookingRoom> rows, {
    required _is.ColumnSelections<BookingRoomTable> conflictColumns,
    _is.ColumnSelections<BookingRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingRoomTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookingRoom>(
      rows,
      conflictColumns: conflictColumns(BookingRoom.t),
      updateColumns: updateColumns?.call(BookingRoom.t),
      updateWhere: updateWhere?.call(BookingRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookingRoom] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [BookingRoom] will have its `id` field set.
  Future<BookingRoom?> upsertRow(
    _is.DatabaseSession session,
    BookingRoom row, {
    required _is.ColumnSelections<BookingRoomTable> conflictColumns,
    _is.ColumnSelections<BookingRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingRoomTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookingRoom>(
      row,
      conflictColumns: conflictColumns(BookingRoom.t),
      updateColumns: updateColumns?.call(BookingRoom.t),
      updateWhere: updateWhere?.call(BookingRoom.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookingRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingRoom>> update(
    _is.DatabaseSession session,
    List<BookingRoom> rows, {
    _is.ColumnSelections<BookingRoomTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookingRoom>(
      rows,
      columns: columns?.call(BookingRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookingRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookingRoom> updateRow(
    _is.DatabaseSession session,
    BookingRoom row, {
    _is.ColumnSelections<BookingRoomTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookingRoom>(
      row,
      columns: columns?.call(BookingRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookingRoom] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookingRoom?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingRoomUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookingRoom>(
      id,
      columnValues: columnValues(BookingRoom.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookingRoom]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingRoom>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingRoomUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookingRoomTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingRoomTable>? orderBy,
    _is.OrderByListBuilder<BookingRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookingRoom>(
      columnValues: columnValues(BookingRoom.t.updateTable),
      where: where(BookingRoom.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookingRoom.t),
      orderByList: orderByList?.call(BookingRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookingRoom]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingRoom>> delete(
    _is.DatabaseSession session,
    List<BookingRoom> rows, {
    _is.OrderByBuilder<BookingRoomTable>? orderBy,
    _is.OrderByListBuilder<BookingRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookingRoom>(
      rows,
      orderBy: orderBy?.call(BookingRoom.t),
      orderByList: orderByList?.call(BookingRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookingRoom].
  Future<BookingRoom> deleteRow(
    _is.DatabaseSession session,
    BookingRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookingRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingRoom>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingRoomTable> where,
    _is.OrderByBuilder<BookingRoomTable>? orderBy,
    _is.OrderByListBuilder<BookingRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookingRoom>(
      where: where(BookingRoom.t),
      orderBy: orderBy?.call(BookingRoom.t),
      orderByList: orderByList?.call(BookingRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingRoomTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookingRoom>(
      where: where?.call(BookingRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookingRoom] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingRoomTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookingRoom>(
      where: where(BookingRoom.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BookingRoomAttachRowRepository {
  const BookingRoomAttachRowRepository._();

  /// Creates a relation between the given [BookingRoom] and [Booking]
  /// by setting the [BookingRoom]'s foreign key `bookingId` to refer to the [Booking].
  Future<void> booking(
    _is.DatabaseSession session,
    BookingRoom bookingRoom,
    _i2jbfzmp.Booking booking, {
    _is.Transaction? transaction,
  }) async {
    if (bookingRoom.id == null) {
      throw ArgumentError.notNull('bookingRoom.id');
    }
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $bookingRoom = bookingRoom.copyWith(bookingId: booking.id);
    await session.db.updateRow<BookingRoom>(
      $bookingRoom,
      columns: [BookingRoom.t.bookingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BookingRoom] and [Room]
  /// by setting the [BookingRoom]'s foreign key `roomId` to refer to the [Room].
  Future<void> room(
    _is.DatabaseSession session,
    BookingRoom bookingRoom,
    _ij8xg2ak.Room room, {
    _is.Transaction? transaction,
  }) async {
    if (bookingRoom.id == null) {
      throw ArgumentError.notNull('bookingRoom.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $bookingRoom = bookingRoom.copyWith(roomId: room.id);
    await session.db.updateRow<BookingRoom>(
      $bookingRoom,
      columns: [BookingRoom.t.roomId],
      transaction: transaction,
    );
  }
}
