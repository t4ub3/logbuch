/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../contacts/contact.dart' as _imbxrfja;

abstract class Booking
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Booking._({
    this.id,
    DateTime? createdAt,
    required this.title,
    this.from,
    this.to,
    required this.lead,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Booking({
    int? id,
    DateTime? createdAt,
    required String title,
    DateTime? from,
    DateTime? to,
    required _imbxrfja.Contact lead,
  }) = _BookingImpl;

  factory Booking.fromJson(Map<String, dynamic> jsonSerialization) {
    return Booking(
      id: jsonSerialization['id'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      title: jsonSerialization['title'] as String,
      from: jsonSerialization['from'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: jsonSerialization['to'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      lead: _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
        jsonSerialization['lead'],
      ),
    );
  }

  static final t = BookingTable();

  static const db = BookingRepository._();

  @override
  int? id;

  DateTime createdAt;

  String title;

  DateTime? from;

  DateTime? to;

  _imbxrfja.Contact lead;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Booking copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    DateTime? from,
    DateTime? to,
    _imbxrfja.Contact? lead,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'title': title,
      if (from != null) 'from': from?.toJson(),
      if (to != null) 'to': to?.toJson(),
      'lead': lead.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'title': title,
      if (from != null) 'from': from?.toJson(),
      if (to != null) 'to': to?.toJson(),
      'lead': lead.toJsonForProtocol(),
    };
  }

  static BookingInclude include() {
    return BookingInclude._();
  }

  static BookingIncludeList includeList({
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    BookingInclude? include,
  }) {
    return BookingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingImpl extends Booking {
  _BookingImpl({
    int? id,
    DateTime? createdAt,
    required String title,
    DateTime? from,
    DateTime? to,
    required _imbxrfja.Contact lead,
  }) : super._(
         id: id,
         createdAt: createdAt,
         title: title,
         from: from,
         to: to,
         lead: lead,
       );

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Booking copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    String? title,
    Object? from = _Undefined,
    Object? to = _Undefined,
    _imbxrfja.Contact? lead,
  }) {
    return Booking(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      from: from is DateTime? ? from : this.from,
      to: to is DateTime? ? to : this.to,
      lead: lead ?? this.lead.copyWith(),
    );
  }
}

class BookingUpdateTable extends _is.UpdateTable<BookingTable> {
  BookingUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> from(DateTime? value) => _is.ColumnValue(
    table.from,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> to(DateTime? value) => _is.ColumnValue(
    table.to,
    value,
  );

  _is.ColumnValue<_imbxrfja.Contact, _imbxrfja.Contact> lead(
    _imbxrfja.Contact value,
  ) => _is.ColumnValue(
    table.lead,
    value,
  );
}

class BookingTable extends _is.Table<int?> {
  BookingTable({super.tableRelation}) : super(tableName: 'bookings') {
    updateTable = BookingUpdateTable(this);
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    from = _is.ColumnDateTime(
      'from',
      this,
    );
    to = _is.ColumnDateTime(
      'to',
      this,
    );
    lead = _is.ColumnSerializable<_imbxrfja.Contact>(
      'lead',
      this,
    );
  }

  late final BookingUpdateTable updateTable;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString title;

  late final _is.ColumnDateTime from;

  late final _is.ColumnDateTime to;

  late final _is.ColumnSerializable<_imbxrfja.Contact> lead;

  @override
  List<_is.Column> get columns => [
    id,
    createdAt,
    title,
    from,
    to,
    lead,
  ];
}

class BookingInclude extends _is.IncludeObject {
  BookingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingIncludeList extends _is.IncludeList {
  BookingIncludeList._({
    _is.WhereExpressionBuilder<BookingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Booking.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingRepository {
  const BookingRepository._();

  /// Returns a list of [Booking]s matching the given query parameters.
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
  Future<List<Booking>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Booking] matching the given query parameters.
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
  Future<Booking?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Booking] by its [id] or null if no such row exists.
  Future<Booking?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Booking>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Booking]s in the list and returns the inserted rows.
  ///
  /// The returned [Booking]s will have their `id` fields set.
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
  Future<List<Booking>> insert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Booking>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Booking] and returns the inserted row.
  ///
  /// The returned [Booking] will have its `id` field set.
  Future<Booking> insertRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Booking>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Booking]s in the list and returns the resulting rows.
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
  /// The returned [Booking]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> upsert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Booking>(
      rows,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Booking] and returns the resulting row.
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
  /// The returned [Booking] will have its `id` field set.
  Future<Booking?> upsertRow(
    _is.DatabaseSession session,
    Booking row, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Booking>(
      row,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> update(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Booking>(
      rows,
      columns: columns?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Booking]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Booking> updateRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Booking>(
      row,
      columns: columns?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Booking] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Booking?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Booking>(
      id,
      columnValues: columnValues(Booking.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Booking>(
      columnValues: columnValues(Booking.t.updateTable),
      where: where(Booking.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Booking]s in the list and returns the deleted rows.
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
  Future<List<Booking>> delete(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Booking>(
      rows,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Booking].
  Future<Booking> deleteRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Booking>(
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
  Future<List<Booking>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Booking>(
      where: where(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Booking>(
      where: where?.call(Booking.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Booking] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Booking>(
      where: where(Booking.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
