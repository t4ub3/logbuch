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
import '../contacts/contact.dart' as _imbxrfja;
import '../guests/guest.dart' as _inwk3jth;

/// Guests of a booking who belong together, such as a family.
abstract class GuestGroup
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  GuestGroup._({
    this.id,
    required this.bookingId,
    this.booking,
    required this.name,
    this.payerId,
    this.payer,
    int? sortOrder,
    this.guests,
  }) : sortOrder = sortOrder ?? 0;

  factory GuestGroup({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required String name,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? sortOrder,
    List<_inwk3jth.Guest>? guests,
  }) = _GuestGroupImpl;

  factory GuestGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuestGroup(
      id: jsonSerialization['id'] as int?,
      bookingId: jsonSerialization['bookingId'] as int,
      booking: jsonSerialization['booking'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i2jbfzmp.Booking>(
              jsonSerialization['booking'],
            ),
      name: jsonSerialization['name'] as String,
      payerId: jsonSerialization['payerId'] as int?,
      payer: jsonSerialization['payer'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['payer'],
            ),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      guests: jsonSerialization['guests'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_inwk3jth.Guest>>(
              jsonSerialization['guests'],
            ),
    );
  }

  static final t = GuestGroupTable();

  static const db = GuestGroupRepository._();

  @override
  int? id;

  int bookingId;

  _i2jbfzmp.Booking? booking;

  String name;

  int? payerId;

  /// Pays for the group if the booking is billed per group.
  _imbxrfja.Contact? payer;

  int sortOrder;

  List<_inwk3jth.Guest>? guests;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [GuestGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  GuestGroup copyWith({
    int? id,
    int? bookingId,
    _i2jbfzmp.Booking? booking,
    String? name,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? sortOrder,
    List<_inwk3jth.Guest>? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GuestGroup',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJson(),
      'name': name,
      if (payerId != null) 'payerId': payerId,
      if (payer != null) 'payer': payer?.toJson(),
      'sortOrder': sortOrder,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GuestGroup',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJsonForProtocol(),
      'name': name,
      if (payerId != null) 'payerId': payerId,
      if (payer != null) 'payer': payer?.toJsonForProtocol(),
      'sortOrder': sortOrder,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static GuestGroupInclude include({
    _i2jbfzmp.BookingInclude? booking,
    _imbxrfja.ContactInclude? payer,
    _inwk3jth.GuestIncludeList? guests,
  }) {
    return GuestGroupInclude._(
      booking: booking,
      payer: payer,
      guests: guests,
    );
  }

  static GuestGroupIncludeList includeList({
    _is.WhereExpressionBuilder<GuestGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestGroupTable>? orderBy,
    _is.OrderByListBuilder<GuestGroupTable>? orderByList,
    GuestGroupInclude? include,
  }) {
    return GuestGroupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GuestGroup.t),
      orderByList: orderByList?.call(GuestGroup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestGroupImpl extends GuestGroup {
  _GuestGroupImpl({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required String name,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? sortOrder,
    List<_inwk3jth.Guest>? guests,
  }) : super._(
         id: id,
         bookingId: bookingId,
         booking: booking,
         name: name,
         payerId: payerId,
         payer: payer,
         sortOrder: sortOrder,
         guests: guests,
       );

  /// Returns a shallow copy of this [GuestGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  GuestGroup copyWith({
    Object? id = _Undefined,
    int? bookingId,
    Object? booking = _Undefined,
    String? name,
    Object? payerId = _Undefined,
    Object? payer = _Undefined,
    int? sortOrder,
    Object? guests = _Undefined,
  }) {
    return GuestGroup(
      id: id is int? ? id : this.id,
      bookingId: bookingId ?? this.bookingId,
      booking: booking is _i2jbfzmp.Booking?
          ? booking
          : this.booking?.copyWith(),
      name: name ?? this.name,
      payerId: payerId is int? ? payerId : this.payerId,
      payer: payer is _imbxrfja.Contact? ? payer : this.payer?.copyWith(),
      sortOrder: sortOrder ?? this.sortOrder,
      guests: guests is List<_inwk3jth.Guest>?
          ? guests
          : this.guests?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class GuestGroupUpdateTable extends _is.UpdateTable<GuestGroupTable> {
  GuestGroupUpdateTable(super.table);

  _is.ColumnValue<int, int> bookingId(int value) => _is.ColumnValue(
    table.bookingId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> payerId(int? value) => _is.ColumnValue(
    table.payerId,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );
}

class GuestGroupTable extends _is.Table<int?> {
  GuestGroupTable({super.tableRelation}) : super(tableName: 'guest_groups') {
    updateTable = GuestGroupUpdateTable(this);
    bookingId = _is.ColumnInt(
      'bookingId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    payerId = _is.ColumnInt(
      'payerId',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
  }

  late final GuestGroupUpdateTable updateTable;

  late final _is.ColumnInt bookingId;

  _i2jbfzmp.BookingTable? _booking;

  late final _is.ColumnString name;

  late final _is.ColumnInt payerId;

  /// Pays for the group if the booking is billed per group.
  _imbxrfja.ContactTable? _payer;

  late final _is.ColumnInt sortOrder;

  _inwk3jth.GuestTable? ___guests;

  _is.ManyRelation<_inwk3jth.GuestTable>? _guests;

  _i2jbfzmp.BookingTable get booking {
    if (_booking != null) return _booking!;
    _booking = _is.createRelationTable(
      relationFieldName: 'booking',
      field: GuestGroup.t.bookingId,
      foreignField: _i2jbfzmp.Booking.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2jbfzmp.BookingTable(tableRelation: foreignTableRelation),
    );
    return _booking!;
  }

  _imbxrfja.ContactTable get payer {
    if (_payer != null) return _payer!;
    _payer = _is.createRelationTable(
      relationFieldName: 'payer',
      field: GuestGroup.t.payerId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _payer!;
  }

  _inwk3jth.GuestTable get __guests {
    if (___guests != null) return ___guests!;
    ___guests = _is.createRelationTable(
      relationFieldName: '__guests',
      field: GuestGroup.t.id,
      foreignField: _inwk3jth.Guest.t.groupId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inwk3jth.GuestTable(tableRelation: foreignTableRelation),
    );
    return ___guests!;
  }

  _is.ManyRelation<_inwk3jth.GuestTable> get guests {
    if (_guests != null) return _guests!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'guests',
      field: GuestGroup.t.id,
      foreignField: _inwk3jth.Guest.t.groupId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inwk3jth.GuestTable(tableRelation: foreignTableRelation),
    );
    _guests = _is.ManyRelation<_inwk3jth.GuestTable>(
      tableWithRelations: relationTable,
      table: _inwk3jth.GuestTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _guests!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    bookingId,
    name,
    payerId,
    sortOrder,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'booking') {
      return booking;
    }
    if (relationField == 'payer') {
      return payer;
    }
    if (relationField == 'guests') {
      return __guests;
    }
    return null;
  }
}

class GuestGroupInclude extends _is.IncludeObject {
  GuestGroupInclude._({
    _i2jbfzmp.BookingInclude? booking,
    _imbxrfja.ContactInclude? payer,
    _inwk3jth.GuestIncludeList? guests,
  }) {
    _booking = booking;
    _payer = payer;
    _guests = guests;
  }

  _i2jbfzmp.BookingInclude? _booking;

  _imbxrfja.ContactInclude? _payer;

  _inwk3jth.GuestIncludeList? _guests;

  @override
  Map<String, _is.Include?> get includes => {
    'booking': _booking,
    'payer': _payer,
    'guests': _guests,
  };

  @override
  _is.Table<int?> get table => GuestGroup.t;
}

class GuestGroupIncludeList extends _is.IncludeList {
  GuestGroupIncludeList._({
    _is.WhereExpressionBuilder<GuestGroupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GuestGroup.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => GuestGroup.t;
}

class GuestGroupRepository {
  const GuestGroupRepository._();

  final attach = const GuestGroupAttachRepository._();

  final attachRow = const GuestGroupAttachRowRepository._();

  final detachRow = const GuestGroupDetachRowRepository._();

  /// Returns a list of [GuestGroup]s matching the given query parameters.
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
  Future<List<GuestGroup>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestGroupTable>? orderBy,
    _is.OrderByListBuilder<GuestGroupTable>? orderByList,
    _is.Transaction? transaction,
    GuestGroupInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GuestGroup>(
      where: where?.call(GuestGroup.t),
      orderBy: orderBy?.call(GuestGroup.t),
      orderByList: orderByList?.call(GuestGroup.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [GuestGroup] matching the given query parameters.
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
  Future<GuestGroup?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestGroupTable>? where,
    int? offset,
    _is.OrderByBuilder<GuestGroupTable>? orderBy,
    _is.OrderByListBuilder<GuestGroupTable>? orderByList,
    _is.Transaction? transaction,
    GuestGroupInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GuestGroup>(
      where: where?.call(GuestGroup.t),
      orderBy: orderBy?.call(GuestGroup.t),
      orderByList: orderByList?.call(GuestGroup.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GuestGroup] by its [id] or null if no such row exists.
  Future<GuestGroup?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    GuestGroupInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<GuestGroup>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [GuestGroup]s in the list and returns the inserted rows.
  ///
  /// The returned [GuestGroup]s will have their `id` fields set.
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
  Future<List<GuestGroup>> insert(
    _is.DatabaseSession session,
    List<GuestGroup> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<GuestGroup>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [GuestGroup] and returns the inserted row.
  ///
  /// The returned [GuestGroup] will have its `id` field set.
  Future<GuestGroup> insertRow(
    _is.DatabaseSession session,
    GuestGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<GuestGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [GuestGroup]s in the list and returns the resulting rows.
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
  /// The returned [GuestGroup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GuestGroup>> upsert(
    _is.DatabaseSession session,
    List<GuestGroup> rows, {
    required _is.ColumnSelections<GuestGroupTable> conflictColumns,
    _is.ColumnSelections<GuestGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<GuestGroupTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<GuestGroup>(
      rows,
      conflictColumns: conflictColumns(GuestGroup.t),
      updateColumns: updateColumns?.call(GuestGroup.t),
      updateWhere: updateWhere?.call(GuestGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [GuestGroup] and returns the resulting row.
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
  /// The returned [GuestGroup] will have its `id` field set.
  Future<GuestGroup?> upsertRow(
    _is.DatabaseSession session,
    GuestGroup row, {
    required _is.ColumnSelections<GuestGroupTable> conflictColumns,
    _is.ColumnSelections<GuestGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<GuestGroupTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<GuestGroup>(
      row,
      conflictColumns: conflictColumns(GuestGroup.t),
      updateColumns: updateColumns?.call(GuestGroup.t),
      updateWhere: updateWhere?.call(GuestGroup.t),
      transaction: transaction,
    );
  }

  /// Updates all [GuestGroup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GuestGroup>> update(
    _is.DatabaseSession session,
    List<GuestGroup> rows, {
    _is.ColumnSelections<GuestGroupTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<GuestGroup>(
      rows,
      columns: columns?.call(GuestGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [GuestGroup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GuestGroup> updateRow(
    _is.DatabaseSession session,
    GuestGroup row, {
    _is.ColumnSelections<GuestGroupTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<GuestGroup>(
      row,
      columns: columns?.call(GuestGroup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GuestGroup] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GuestGroup?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<GuestGroupUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<GuestGroup>(
      id,
      columnValues: columnValues(GuestGroup.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GuestGroup]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GuestGroup>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<GuestGroupUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<GuestGroupTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestGroupTable>? orderBy,
    _is.OrderByListBuilder<GuestGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<GuestGroup>(
      columnValues: columnValues(GuestGroup.t.updateTable),
      where: where(GuestGroup.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GuestGroup.t),
      orderByList: orderByList?.call(GuestGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [GuestGroup]s in the list and returns the deleted rows.
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
  Future<List<GuestGroup>> delete(
    _is.DatabaseSession session,
    List<GuestGroup> rows, {
    _is.OrderByBuilder<GuestGroupTable>? orderBy,
    _is.OrderByListBuilder<GuestGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<GuestGroup>(
      rows,
      orderBy: orderBy?.call(GuestGroup.t),
      orderByList: orderByList?.call(GuestGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [GuestGroup].
  Future<GuestGroup> deleteRow(
    _is.DatabaseSession session,
    GuestGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GuestGroup>(
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
  Future<List<GuestGroup>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GuestGroupTable> where,
    _is.OrderByBuilder<GuestGroupTable>? orderBy,
    _is.OrderByListBuilder<GuestGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<GuestGroup>(
      where: where(GuestGroup.t),
      orderBy: orderBy?.call(GuestGroup.t),
      orderByList: orderByList?.call(GuestGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestGroupTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<GuestGroup>(
      where: where?.call(GuestGroup.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GuestGroup] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GuestGroupTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GuestGroup>(
      where: where(GuestGroup.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class GuestGroupAttachRepository {
  const GuestGroupAttachRepository._();

  /// Creates a relation between this [GuestGroup] and the given [Guest]s
  /// by setting each [Guest]'s foreign key `groupId` to refer to this [GuestGroup].
  Future<void> guests(
    _is.DatabaseSession session,
    GuestGroup guestGroup,
    List<_inwk3jth.Guest> guest, {
    _is.Transaction? transaction,
  }) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }
    if (guestGroup.id == null) {
      throw ArgumentError.notNull('guestGroup.id');
    }

    var $guest = guest.map((e) => e.copyWith(groupId: guestGroup.id)).toList();
    await session.db.update<_inwk3jth.Guest>(
      $guest,
      columns: [_inwk3jth.Guest.t.groupId],
      transaction: transaction,
    );
  }
}

class GuestGroupAttachRowRepository {
  const GuestGroupAttachRowRepository._();

  /// Creates a relation between the given [GuestGroup] and [Booking]
  /// by setting the [GuestGroup]'s foreign key `bookingId` to refer to the [Booking].
  Future<void> booking(
    _is.DatabaseSession session,
    GuestGroup guestGroup,
    _i2jbfzmp.Booking booking, {
    _is.Transaction? transaction,
  }) async {
    if (guestGroup.id == null) {
      throw ArgumentError.notNull('guestGroup.id');
    }
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $guestGroup = guestGroup.copyWith(bookingId: booking.id);
    await session.db.updateRow<GuestGroup>(
      $guestGroup,
      columns: [GuestGroup.t.bookingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [GuestGroup] and [Contact]
  /// by setting the [GuestGroup]'s foreign key `payerId` to refer to the [Contact].
  Future<void> payer(
    _is.DatabaseSession session,
    GuestGroup guestGroup,
    _imbxrfja.Contact payer, {
    _is.Transaction? transaction,
  }) async {
    if (guestGroup.id == null) {
      throw ArgumentError.notNull('guestGroup.id');
    }
    if (payer.id == null) {
      throw ArgumentError.notNull('payer.id');
    }

    var $guestGroup = guestGroup.copyWith(payerId: payer.id);
    await session.db.updateRow<GuestGroup>(
      $guestGroup,
      columns: [GuestGroup.t.payerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [GuestGroup] and the given [Guest]
  /// by setting the [Guest]'s foreign key `groupId` to refer to this [GuestGroup].
  Future<void> guests(
    _is.DatabaseSession session,
    GuestGroup guestGroup,
    _inwk3jth.Guest guest, {
    _is.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (guestGroup.id == null) {
      throw ArgumentError.notNull('guestGroup.id');
    }

    var $guest = guest.copyWith(groupId: guestGroup.id);
    await session.db.updateRow<_inwk3jth.Guest>(
      $guest,
      columns: [_inwk3jth.Guest.t.groupId],
      transaction: transaction,
    );
  }
}

class GuestGroupDetachRowRepository {
  const GuestGroupDetachRowRepository._();

  /// Detaches the relation between this [GuestGroup] and the [Contact] set in `payer`
  /// by setting the [GuestGroup]'s foreign key `payerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> payer(
    _is.DatabaseSession session,
    GuestGroup guestGroup, {
    _is.Transaction? transaction,
  }) async {
    if (guestGroup.id == null) {
      throw ArgumentError.notNull('guestGroup.id');
    }

    var $guestGroup = guestGroup.copyWith(payerId: null);
    await session.db.updateRow<GuestGroup>(
      $guestGroup,
      columns: [GuestGroup.t.payerId],
      transaction: transaction,
    );
  }
}
