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
import 'package:serverpod/serverpod.dart' as _is;

abstract class RoomRate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RoomRate._({
    this.id,
    required this.seasonId,
    required this.priceCategoryId,
    required this.ageGroupId,
    required this.pricePerNight,
  });

  factory RoomRate({
    int? id,
    required int seasonId,
    required int priceCategoryId,
    required int ageGroupId,
    required int pricePerNight,
  }) = _RoomRateImpl;

  factory RoomRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomRate(
      id: jsonSerialization['id'] as int?,
      seasonId: jsonSerialization['seasonId'] as int,
      priceCategoryId: jsonSerialization['priceCategoryId'] as int,
      ageGroupId: jsonSerialization['ageGroupId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int,
    );
  }

  static final t = RoomRateTable();

  static const db = RoomRateRepository._();

  @override
  int? id;

  int seasonId;

  int priceCategoryId;

  int ageGroupId;

  int pricePerNight;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomRate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomRate copyWith({
    int? id,
    int? seasonId,
    int? priceCategoryId,
    int? ageGroupId,
    int? pricePerNight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'priceCategoryId': priceCategoryId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'priceCategoryId': priceCategoryId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  static RoomRateInclude include() {
    return RoomRateInclude._();
  }

  static RoomRateIncludeList includeList({
    _is.WhereExpressionBuilder<RoomRateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomRateTable>? orderBy,
    _is.OrderByListBuilder<RoomRateTable>? orderByList,
    RoomRateInclude? include,
  }) {
    return RoomRateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomRate.t),
      orderByList: orderByList?.call(RoomRate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomRateImpl extends RoomRate {
  _RoomRateImpl({
    int? id,
    required int seasonId,
    required int priceCategoryId,
    required int ageGroupId,
    required int pricePerNight,
  }) : super._(
         id: id,
         seasonId: seasonId,
         priceCategoryId: priceCategoryId,
         ageGroupId: ageGroupId,
         pricePerNight: pricePerNight,
       );

  /// Returns a shallow copy of this [RoomRate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomRate copyWith({
    Object? id = _Undefined,
    int? seasonId,
    int? priceCategoryId,
    int? ageGroupId,
    int? pricePerNight,
  }) {
    return RoomRate(
      id: id is int? ? id : this.id,
      seasonId: seasonId ?? this.seasonId,
      priceCategoryId: priceCategoryId ?? this.priceCategoryId,
      ageGroupId: ageGroupId ?? this.ageGroupId,
      pricePerNight: pricePerNight ?? this.pricePerNight,
    );
  }
}

class RoomRateUpdateTable extends _is.UpdateTable<RoomRateTable> {
  RoomRateUpdateTable(super.table);

  _is.ColumnValue<int, int> seasonId(int value) => _is.ColumnValue(
    table.seasonId,
    value,
  );

  _is.ColumnValue<int, int> priceCategoryId(int value) => _is.ColumnValue(
    table.priceCategoryId,
    value,
  );

  _is.ColumnValue<int, int> ageGroupId(int value) => _is.ColumnValue(
    table.ageGroupId,
    value,
  );

  _is.ColumnValue<int, int> pricePerNight(int value) => _is.ColumnValue(
    table.pricePerNight,
    value,
  );
}

class RoomRateTable extends _is.Table<int?> {
  RoomRateTable({super.tableRelation}) : super(tableName: 'room_rates') {
    updateTable = RoomRateUpdateTable(this);
    seasonId = _is.ColumnInt(
      'seasonId',
      this,
    );
    priceCategoryId = _is.ColumnInt(
      'priceCategoryId',
      this,
    );
    ageGroupId = _is.ColumnInt(
      'ageGroupId',
      this,
    );
    pricePerNight = _is.ColumnInt(
      'pricePerNight',
      this,
    );
  }

  late final RoomRateUpdateTable updateTable;

  late final _is.ColumnInt seasonId;

  late final _is.ColumnInt priceCategoryId;

  late final _is.ColumnInt ageGroupId;

  late final _is.ColumnInt pricePerNight;

  @override
  List<_is.Column> get columns => [
    id,
    seasonId,
    priceCategoryId,
    ageGroupId,
    pricePerNight,
  ];
}

class RoomRateInclude extends _is.IncludeObject {
  RoomRateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RoomRate.t;
}

class RoomRateIncludeList extends _is.IncludeList {
  RoomRateIncludeList._({
    _is.WhereExpressionBuilder<RoomRateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomRate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RoomRate.t;
}

class RoomRateRepository {
  const RoomRateRepository._();

  /// Returns a list of [RoomRate]s matching the given query parameters.
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
  Future<List<RoomRate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomRateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomRateTable>? orderBy,
    _is.OrderByListBuilder<RoomRateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomRate>(
      where: where?.call(RoomRate.t),
      orderBy: orderBy?.call(RoomRate.t),
      orderByList: orderByList?.call(RoomRate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomRate] matching the given query parameters.
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
  Future<RoomRate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomRateTable>? where,
    int? offset,
    _is.OrderByBuilder<RoomRateTable>? orderBy,
    _is.OrderByListBuilder<RoomRateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomRate>(
      where: where?.call(RoomRate.t),
      orderBy: orderBy?.call(RoomRate.t),
      orderByList: orderByList?.call(RoomRate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomRate] by its [id] or null if no such row exists.
  Future<RoomRate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomRate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomRate]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomRate]s will have their `id` fields set.
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
  Future<List<RoomRate>> insert(
    _is.DatabaseSession session,
    List<RoomRate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RoomRate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RoomRate] and returns the inserted row.
  ///
  /// The returned [RoomRate] will have its `id` field set.
  Future<RoomRate> insertRow(
    _is.DatabaseSession session,
    RoomRate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomRate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RoomRate]s in the list and returns the resulting rows.
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
  /// The returned [RoomRate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomRate>> upsert(
    _is.DatabaseSession session,
    List<RoomRate> rows, {
    required _is.ColumnSelections<RoomRateTable> conflictColumns,
    _is.ColumnSelections<RoomRateTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomRateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RoomRate>(
      rows,
      conflictColumns: conflictColumns(RoomRate.t),
      updateColumns: updateColumns?.call(RoomRate.t),
      updateWhere: updateWhere?.call(RoomRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RoomRate] and returns the resulting row.
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
  /// The returned [RoomRate] will have its `id` field set.
  Future<RoomRate?> upsertRow(
    _is.DatabaseSession session,
    RoomRate row, {
    required _is.ColumnSelections<RoomRateTable> conflictColumns,
    _is.ColumnSelections<RoomRateTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomRateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RoomRate>(
      row,
      conflictColumns: conflictColumns(RoomRate.t),
      updateColumns: updateColumns?.call(RoomRate.t),
      updateWhere: updateWhere?.call(RoomRate.t),
      transaction: transaction,
    );
  }

  /// Updates all [RoomRate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomRate>> update(
    _is.DatabaseSession session,
    List<RoomRate> rows, {
    _is.ColumnSelections<RoomRateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RoomRate>(
      rows,
      columns: columns?.call(RoomRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RoomRate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomRate> updateRow(
    _is.DatabaseSession session,
    RoomRate row, {
    _is.ColumnSelections<RoomRateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomRate>(
      row,
      columns: columns?.call(RoomRate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomRate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomRate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoomRateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomRate>(
      id,
      columnValues: columnValues(RoomRate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomRate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomRate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoomRateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoomRateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomRateTable>? orderBy,
    _is.OrderByListBuilder<RoomRateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RoomRate>(
      columnValues: columnValues(RoomRate.t.updateTable),
      where: where(RoomRate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomRate.t),
      orderByList: orderByList?.call(RoomRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RoomRate]s in the list and returns the deleted rows.
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
  Future<List<RoomRate>> delete(
    _is.DatabaseSession session,
    List<RoomRate> rows, {
    _is.OrderByBuilder<RoomRateTable>? orderBy,
    _is.OrderByListBuilder<RoomRateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RoomRate>(
      rows,
      orderBy: orderBy?.call(RoomRate.t),
      orderByList: orderByList?.call(RoomRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RoomRate].
  Future<RoomRate> deleteRow(
    _is.DatabaseSession session,
    RoomRate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomRate>(
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
  Future<List<RoomRate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomRateTable> where,
    _is.OrderByBuilder<RoomRateTable>? orderBy,
    _is.OrderByListBuilder<RoomRateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RoomRate>(
      where: where(RoomRate.t),
      orderBy: orderBy?.call(RoomRate.t),
      orderByList: orderByList?.call(RoomRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomRateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RoomRate>(
      where: where?.call(RoomRate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomRate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomRateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomRate>(
      where: where(RoomRate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
