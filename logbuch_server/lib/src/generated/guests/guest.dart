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
import '../bookings/booking_room.dart' as _icgf4f53;
import '../contacts/contact.dart' as _imbxrfja;
import '../guests/guest_group.dart' as _it76xumr;
import '../pricing/age_group.dart' as _iwfwnbly;

/// A contact staying with a booking, in one of the rooms it holds.
abstract class Guest implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Guest._({
    this.id,
    required this.groupId,
    this.group,
    required this.contactId,
    this.contact,
    this.bookingRoomId,
    this.bookingRoom,
    bool? needsCrib,
    this.ageGroupOverrideId,
    this.ageGroupOverride,
    this.arrivalOverride,
    this.departureOverride,
    this.dietaryNotes,
  }) : needsCrib = needsCrib ?? false;

  factory Guest({
    int? id,
    required int groupId,
    _it76xumr.GuestGroup? group,
    required int contactId,
    _imbxrfja.Contact? contact,
    int? bookingRoomId,
    _icgf4f53.BookingRoom? bookingRoom,
    bool? needsCrib,
    int? ageGroupOverrideId,
    _iwfwnbly.AgeGroup? ageGroupOverride,
    DateTime? arrivalOverride,
    DateTime? departureOverride,
    String? dietaryNotes,
  }) = _GuestImpl;

  factory Guest.fromJson(Map<String, dynamic> jsonSerialization) {
    return Guest(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      group: jsonSerialization['group'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_it76xumr.GuestGroup>(
              jsonSerialization['group'],
            ),
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
      bookingRoomId: jsonSerialization['bookingRoomId'] as int?,
      bookingRoom: jsonSerialization['bookingRoom'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_icgf4f53.BookingRoom>(
              jsonSerialization['bookingRoom'],
            ),
      needsCrib: jsonSerialization['needsCrib'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['needsCrib']),
      ageGroupOverrideId: jsonSerialization['ageGroupOverrideId'] as int?,
      ageGroupOverride: jsonSerialization['ageGroupOverride'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_iwfwnbly.AgeGroup>(
              jsonSerialization['ageGroupOverride'],
            ),
      arrivalOverride: jsonSerialization['arrivalOverride'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['arrivalOverride'],
            ),
      departureOverride: jsonSerialization['departureOverride'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['departureOverride'],
            ),
      dietaryNotes: jsonSerialization['dietaryNotes'] as String?,
    );
  }

  static final t = GuestTable();

  static const db = GuestRepository._();

  @override
  int? id;

  int groupId;

  _it76xumr.GuestGroup? group;

  int contactId;

  _imbxrfja.Contact? contact;

  int? bookingRoomId;

  /// Null while the guest is not assigned to a room yet.
  _icgf4f53.BookingRoom? bookingRoom;

  bool needsCrib;

  int? ageGroupOverrideId;

  /// Used instead of the age from the birth date of the contact.
  _iwfwnbly.AgeGroup? ageGroupOverride;

  /// Set for the rare guest who arrives later or departs earlier than the
  /// booking.
  DateTime? arrivalOverride;

  DateTime? departureOverride;

  String? dietaryNotes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Guest copyWith({
    int? id,
    int? groupId,
    _it76xumr.GuestGroup? group,
    int? contactId,
    _imbxrfja.Contact? contact,
    int? bookingRoomId,
    _icgf4f53.BookingRoom? bookingRoom,
    bool? needsCrib,
    int? ageGroupOverrideId,
    _iwfwnbly.AgeGroup? ageGroupOverride,
    DateTime? arrivalOverride,
    DateTime? departureOverride,
    String? dietaryNotes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'groupId': groupId,
      if (group != null) 'group': group?.toJson(),
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
      if (bookingRoomId != null) 'bookingRoomId': bookingRoomId,
      if (bookingRoom != null) 'bookingRoom': bookingRoom?.toJson(),
      'needsCrib': needsCrib,
      if (ageGroupOverrideId != null) 'ageGroupOverrideId': ageGroupOverrideId,
      if (ageGroupOverride != null)
        'ageGroupOverride': ageGroupOverride?.toJson(),
      if (arrivalOverride != null) 'arrivalOverride': arrivalOverride?.toJson(),
      if (departureOverride != null)
        'departureOverride': departureOverride?.toJson(),
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'groupId': groupId,
      if (group != null) 'group': group?.toJsonForProtocol(),
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
      if (bookingRoomId != null) 'bookingRoomId': bookingRoomId,
      if (bookingRoom != null) 'bookingRoom': bookingRoom?.toJsonForProtocol(),
      'needsCrib': needsCrib,
      if (ageGroupOverrideId != null) 'ageGroupOverrideId': ageGroupOverrideId,
      if (ageGroupOverride != null)
        'ageGroupOverride': ageGroupOverride?.toJsonForProtocol(),
      if (arrivalOverride != null) 'arrivalOverride': arrivalOverride?.toJson(),
      if (departureOverride != null)
        'departureOverride': departureOverride?.toJson(),
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
    };
  }

  static GuestInclude include({
    _it76xumr.GuestGroupInclude? group,
    _imbxrfja.ContactInclude? contact,
    _icgf4f53.BookingRoomInclude? bookingRoom,
    _iwfwnbly.AgeGroupInclude? ageGroupOverride,
  }) {
    return GuestInclude._(
      group: group,
      contact: contact,
      bookingRoom: bookingRoom,
      ageGroupOverride: ageGroupOverride,
    );
  }

  static GuestIncludeList includeList({
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    GuestInclude? include,
  }) {
    return GuestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required int groupId,
    _it76xumr.GuestGroup? group,
    required int contactId,
    _imbxrfja.Contact? contact,
    int? bookingRoomId,
    _icgf4f53.BookingRoom? bookingRoom,
    bool? needsCrib,
    int? ageGroupOverrideId,
    _iwfwnbly.AgeGroup? ageGroupOverride,
    DateTime? arrivalOverride,
    DateTime? departureOverride,
    String? dietaryNotes,
  }) : super._(
         id: id,
         groupId: groupId,
         group: group,
         contactId: contactId,
         contact: contact,
         bookingRoomId: bookingRoomId,
         bookingRoom: bookingRoom,
         needsCrib: needsCrib,
         ageGroupOverrideId: ageGroupOverrideId,
         ageGroupOverride: ageGroupOverride,
         arrivalOverride: arrivalOverride,
         departureOverride: departureOverride,
         dietaryNotes: dietaryNotes,
       );

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Guest copyWith({
    Object? id = _Undefined,
    int? groupId,
    Object? group = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
    Object? bookingRoomId = _Undefined,
    Object? bookingRoom = _Undefined,
    bool? needsCrib,
    Object? ageGroupOverrideId = _Undefined,
    Object? ageGroupOverride = _Undefined,
    Object? arrivalOverride = _Undefined,
    Object? departureOverride = _Undefined,
    Object? dietaryNotes = _Undefined,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      group: group is _it76xumr.GuestGroup? ? group : this.group?.copyWith(),
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
      bookingRoomId: bookingRoomId is int? ? bookingRoomId : this.bookingRoomId,
      bookingRoom: bookingRoom is _icgf4f53.BookingRoom?
          ? bookingRoom
          : this.bookingRoom?.copyWith(),
      needsCrib: needsCrib ?? this.needsCrib,
      ageGroupOverrideId: ageGroupOverrideId is int?
          ? ageGroupOverrideId
          : this.ageGroupOverrideId,
      ageGroupOverride: ageGroupOverride is _iwfwnbly.AgeGroup?
          ? ageGroupOverride
          : this.ageGroupOverride?.copyWith(),
      arrivalOverride: arrivalOverride is DateTime?
          ? arrivalOverride
          : this.arrivalOverride,
      departureOverride: departureOverride is DateTime?
          ? departureOverride
          : this.departureOverride,
      dietaryNotes: dietaryNotes is String? ? dietaryNotes : this.dietaryNotes,
    );
  }
}

class GuestUpdateTable extends _is.UpdateTable<GuestTable> {
  GuestUpdateTable(super.table);

  _is.ColumnValue<int, int> groupId(int value) => _is.ColumnValue(
    table.groupId,
    value,
  );

  _is.ColumnValue<int, int> contactId(int value) => _is.ColumnValue(
    table.contactId,
    value,
  );

  _is.ColumnValue<int, int> bookingRoomId(int? value) => _is.ColumnValue(
    table.bookingRoomId,
    value,
  );

  _is.ColumnValue<bool, bool> needsCrib(bool value) => _is.ColumnValue(
    table.needsCrib,
    value,
  );

  _is.ColumnValue<int, int> ageGroupOverrideId(int? value) => _is.ColumnValue(
    table.ageGroupOverrideId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> arrivalOverride(DateTime? value) =>
      _is.ColumnValue(
        table.arrivalOverride,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> departureOverride(DateTime? value) =>
      _is.ColumnValue(
        table.departureOverride,
        value,
      );

  _is.ColumnValue<String, String> dietaryNotes(String? value) =>
      _is.ColumnValue(
        table.dietaryNotes,
        value,
      );
}

class GuestTable extends _is.Table<int?> {
  GuestTable({super.tableRelation}) : super(tableName: 'guests') {
    updateTable = GuestUpdateTable(this);
    groupId = _is.ColumnInt(
      'groupId',
      this,
    );
    contactId = _is.ColumnInt(
      'contactId',
      this,
    );
    bookingRoomId = _is.ColumnInt(
      'bookingRoomId',
      this,
    );
    needsCrib = _is.ColumnBool(
      'needsCrib',
      this,
      hasDefault: true,
    );
    ageGroupOverrideId = _is.ColumnInt(
      'ageGroupOverrideId',
      this,
    );
    arrivalOverride = _is.ColumnDateTime(
      'arrivalOverride',
      this,
    );
    departureOverride = _is.ColumnDateTime(
      'departureOverride',
      this,
    );
    dietaryNotes = _is.ColumnString(
      'dietaryNotes',
      this,
    );
  }

  late final GuestUpdateTable updateTable;

  late final _is.ColumnInt groupId;

  _it76xumr.GuestGroupTable? _group;

  late final _is.ColumnInt contactId;

  _imbxrfja.ContactTable? _contact;

  late final _is.ColumnInt bookingRoomId;

  /// Null while the guest is not assigned to a room yet.
  _icgf4f53.BookingRoomTable? _bookingRoom;

  late final _is.ColumnBool needsCrib;

  late final _is.ColumnInt ageGroupOverrideId;

  /// Used instead of the age from the birth date of the contact.
  _iwfwnbly.AgeGroupTable? _ageGroupOverride;

  /// Set for the rare guest who arrives later or departs earlier than the
  /// booking.
  late final _is.ColumnDateTime arrivalOverride;

  late final _is.ColumnDateTime departureOverride;

  late final _is.ColumnString dietaryNotes;

  _it76xumr.GuestGroupTable get group {
    if (_group != null) return _group!;
    _group = _is.createRelationTable(
      relationFieldName: 'group',
      field: Guest.t.groupId,
      foreignField: _it76xumr.GuestGroup.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _it76xumr.GuestGroupTable(tableRelation: foreignTableRelation),
    );
    return _group!;
  }

  _imbxrfja.ContactTable get contact {
    if (_contact != null) return _contact!;
    _contact = _is.createRelationTable(
      relationFieldName: 'contact',
      field: Guest.t.contactId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _contact!;
  }

  _icgf4f53.BookingRoomTable get bookingRoom {
    if (_bookingRoom != null) return _bookingRoom!;
    _bookingRoom = _is.createRelationTable(
      relationFieldName: 'bookingRoom',
      field: Guest.t.bookingRoomId,
      foreignField: _icgf4f53.BookingRoom.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _icgf4f53.BookingRoomTable(tableRelation: foreignTableRelation),
    );
    return _bookingRoom!;
  }

  _iwfwnbly.AgeGroupTable get ageGroupOverride {
    if (_ageGroupOverride != null) return _ageGroupOverride!;
    _ageGroupOverride = _is.createRelationTable(
      relationFieldName: 'ageGroupOverride',
      field: Guest.t.ageGroupOverrideId,
      foreignField: _iwfwnbly.AgeGroup.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwfwnbly.AgeGroupTable(tableRelation: foreignTableRelation),
    );
    return _ageGroupOverride!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    groupId,
    contactId,
    bookingRoomId,
    needsCrib,
    ageGroupOverrideId,
    arrivalOverride,
    departureOverride,
    dietaryNotes,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'group') {
      return group;
    }
    if (relationField == 'contact') {
      return contact;
    }
    if (relationField == 'bookingRoom') {
      return bookingRoom;
    }
    if (relationField == 'ageGroupOverride') {
      return ageGroupOverride;
    }
    return null;
  }
}

class GuestInclude extends _is.IncludeObject {
  GuestInclude._({
    _it76xumr.GuestGroupInclude? group,
    _imbxrfja.ContactInclude? contact,
    _icgf4f53.BookingRoomInclude? bookingRoom,
    _iwfwnbly.AgeGroupInclude? ageGroupOverride,
  }) {
    _group = group;
    _contact = contact;
    _bookingRoom = bookingRoom;
    _ageGroupOverride = ageGroupOverride;
  }

  _it76xumr.GuestGroupInclude? _group;

  _imbxrfja.ContactInclude? _contact;

  _icgf4f53.BookingRoomInclude? _bookingRoom;

  _iwfwnbly.AgeGroupInclude? _ageGroupOverride;

  @override
  Map<String, _is.Include?> get includes => {
    'group': _group,
    'contact': _contact,
    'bookingRoom': _bookingRoom,
    'ageGroupOverride': _ageGroupOverride,
  };

  @override
  _is.Table<int?> get table => Guest.t;
}

class GuestIncludeList extends _is.IncludeList {
  GuestIncludeList._({
    _is.WhereExpressionBuilder<GuestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Guest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Guest.t;
}

class GuestRepository {
  const GuestRepository._();

  final attachRow = const GuestAttachRowRepository._();

  final detachRow = const GuestDetachRowRepository._();

  /// Returns a list of [Guest]s matching the given query parameters.
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
  Future<List<Guest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    GuestInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Guest] matching the given query parameters.
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
  Future<Guest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    GuestInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Guest] by its [id] or null if no such row exists.
  Future<Guest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    GuestInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Guest>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Guest]s in the list and returns the inserted rows.
  ///
  /// The returned [Guest]s will have their `id` fields set.
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
  Future<List<Guest>> insert(
    _is.DatabaseSession session,
    List<Guest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Guest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Guest] and returns the inserted row.
  ///
  /// The returned [Guest] will have its `id` field set.
  Future<Guest> insertRow(
    _is.DatabaseSession session,
    Guest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Guest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Guest]s in the list and returns the resulting rows.
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
  /// The returned [Guest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Guest>> upsert(
    _is.DatabaseSession session,
    List<Guest> rows, {
    required _is.ColumnSelections<GuestTable> conflictColumns,
    _is.ColumnSelections<GuestTable>? updateColumns,
    _is.WhereExpressionBuilder<GuestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Guest>(
      rows,
      conflictColumns: conflictColumns(Guest.t),
      updateColumns: updateColumns?.call(Guest.t),
      updateWhere: updateWhere?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Guest] and returns the resulting row.
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
  /// The returned [Guest] will have its `id` field set.
  Future<Guest?> upsertRow(
    _is.DatabaseSession session,
    Guest row, {
    required _is.ColumnSelections<GuestTable> conflictColumns,
    _is.ColumnSelections<GuestTable>? updateColumns,
    _is.WhereExpressionBuilder<GuestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Guest>(
      row,
      conflictColumns: conflictColumns(Guest.t),
      updateColumns: updateColumns?.call(Guest.t),
      updateWhere: updateWhere?.call(Guest.t),
      transaction: transaction,
    );
  }

  /// Updates all [Guest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Guest>> update(
    _is.DatabaseSession session,
    List<Guest> rows, {
    _is.ColumnSelections<GuestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Guest>(
      rows,
      columns: columns?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Guest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Guest> updateRow(
    _is.DatabaseSession session,
    Guest row, {
    _is.ColumnSelections<GuestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Guest>(
      row,
      columns: columns?.call(Guest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Guest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Guest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<GuestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Guest>(
      id,
      columnValues: columnValues(Guest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Guest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Guest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<GuestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<GuestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Guest>(
      columnValues: columnValues(Guest.t.updateTable),
      where: where(Guest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Guest]s in the list and returns the deleted rows.
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
  Future<List<Guest>> delete(
    _is.DatabaseSession session,
    List<Guest> rows, {
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Guest>(
      rows,
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Guest].
  Future<Guest> deleteRow(
    _is.DatabaseSession session,
    Guest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Guest>(
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
  Future<List<Guest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GuestTable> where,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Guest>(
      where: where(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Guest>(
      where: where?.call(Guest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Guest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GuestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Guest>(
      where: where(Guest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class GuestAttachRowRepository {
  const GuestAttachRowRepository._();

  /// Creates a relation between the given [Guest] and [GuestGroup]
  /// by setting the [Guest]'s foreign key `groupId` to refer to the [GuestGroup].
  Future<void> group(
    _is.DatabaseSession session,
    Guest guest,
    _it76xumr.GuestGroup group, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (group.id == null) {
      throw ArgumentError.notNull('group.id');
    }

    var $guest = guest.copyWith(groupId: group.id);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.groupId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Guest] and [Contact]
  /// by setting the [Guest]'s foreign key `contactId` to refer to the [Contact].
  Future<void> contact(
    _is.DatabaseSession session,
    Guest guest,
    _imbxrfja.Contact contact, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (contact.id == null) {
      throw ArgumentError.notNull('contact.id');
    }

    var $guest = guest.copyWith(contactId: contact.id);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.contactId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Guest] and [BookingRoom]
  /// by setting the [Guest]'s foreign key `bookingRoomId` to refer to the [BookingRoom].
  Future<void> bookingRoom(
    _is.DatabaseSession session,
    Guest guest,
    _icgf4f53.BookingRoom bookingRoom, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (bookingRoom.id == null) {
      throw ArgumentError.notNull('bookingRoom.id');
    }

    var $guest = guest.copyWith(bookingRoomId: bookingRoom.id);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.bookingRoomId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Guest] and [AgeGroup]
  /// by setting the [Guest]'s foreign key `ageGroupOverrideId` to refer to the [AgeGroup].
  Future<void> ageGroupOverride(
    _is.DatabaseSession session,
    Guest guest,
    _iwfwnbly.AgeGroup ageGroupOverride, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (ageGroupOverride.id == null) {
      throw ArgumentError.notNull('ageGroupOverride.id');
    }

    var $guest = guest.copyWith(ageGroupOverrideId: ageGroupOverride.id);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.ageGroupOverrideId],
      transaction: transaction,
    );
  }
}

class GuestDetachRowRepository {
  const GuestDetachRowRepository._();

  /// Detaches the relation between this [Guest] and the [BookingRoom] set in `bookingRoom`
  /// by setting the [Guest]'s foreign key `bookingRoomId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> bookingRoom(
    _is.DatabaseSession session,
    Guest guest, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest.copyWith(bookingRoomId: null);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.bookingRoomId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Guest] and the [AgeGroup] set in `ageGroupOverride`
  /// by setting the [Guest]'s foreign key `ageGroupOverrideId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> ageGroupOverride(
    _is.DatabaseSession session,
    Guest guest, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest.copyWith(ageGroupOverrideId: null);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.ageGroupOverrideId],
      transaction: transaction,
    );
  }
}
