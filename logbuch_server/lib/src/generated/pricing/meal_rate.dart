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

abstract class MealRate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MealRate._({
    this.id,
    required this.seasonId,
    required this.mealPlanId,
    required this.ageGroupId,
    required this.pricePerNight,
  });

  factory MealRate({
    int? id,
    required int seasonId,
    required int mealPlanId,
    required int ageGroupId,
    required int pricePerNight,
  }) = _MealRateImpl;

  factory MealRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealRate(
      id: jsonSerialization['id'] as int?,
      seasonId: jsonSerialization['seasonId'] as int,
      mealPlanId: jsonSerialization['mealPlanId'] as int,
      ageGroupId: jsonSerialization['ageGroupId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int,
    );
  }

  static final t = MealRateTable();

  static const db = MealRateRepository._();

  @override
  int? id;

  int seasonId;

  int mealPlanId;

  int ageGroupId;

  int pricePerNight;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MealRate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MealRate copyWith({
    int? id,
    int? seasonId,
    int? mealPlanId,
    int? ageGroupId,
    int? pricePerNight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'mealPlanId': mealPlanId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'mealPlanId': mealPlanId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  static MealRateInclude include() {
    return MealRateInclude._();
  }

  static MealRateIncludeList includeList({
    _is.WhereExpressionBuilder<MealRateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealRateTable>? orderBy,
    _is.OrderByListBuilder<MealRateTable>? orderByList,
    MealRateInclude? include,
  }) {
    return MealRateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealRate.t),
      orderByList: orderByList?.call(MealRate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealRateImpl extends MealRate {
  _MealRateImpl({
    int? id,
    required int seasonId,
    required int mealPlanId,
    required int ageGroupId,
    required int pricePerNight,
  }) : super._(
         id: id,
         seasonId: seasonId,
         mealPlanId: mealPlanId,
         ageGroupId: ageGroupId,
         pricePerNight: pricePerNight,
       );

  /// Returns a shallow copy of this [MealRate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MealRate copyWith({
    Object? id = _Undefined,
    int? seasonId,
    int? mealPlanId,
    int? ageGroupId,
    int? pricePerNight,
  }) {
    return MealRate(
      id: id is int? ? id : this.id,
      seasonId: seasonId ?? this.seasonId,
      mealPlanId: mealPlanId ?? this.mealPlanId,
      ageGroupId: ageGroupId ?? this.ageGroupId,
      pricePerNight: pricePerNight ?? this.pricePerNight,
    );
  }
}

class MealRateUpdateTable extends _is.UpdateTable<MealRateTable> {
  MealRateUpdateTable(super.table);

  _is.ColumnValue<int, int> seasonId(int value) => _is.ColumnValue(
    table.seasonId,
    value,
  );

  _is.ColumnValue<int, int> mealPlanId(int value) => _is.ColumnValue(
    table.mealPlanId,
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

class MealRateTable extends _is.Table<int?> {
  MealRateTable({super.tableRelation}) : super(tableName: 'meal_rates') {
    updateTable = MealRateUpdateTable(this);
    seasonId = _is.ColumnInt(
      'seasonId',
      this,
    );
    mealPlanId = _is.ColumnInt(
      'mealPlanId',
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

  late final MealRateUpdateTable updateTable;

  late final _is.ColumnInt seasonId;

  late final _is.ColumnInt mealPlanId;

  late final _is.ColumnInt ageGroupId;

  late final _is.ColumnInt pricePerNight;

  @override
  List<_is.Column> get columns => [
    id,
    seasonId,
    mealPlanId,
    ageGroupId,
    pricePerNight,
  ];
}

class MealRateInclude extends _is.IncludeObject {
  MealRateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MealRate.t;
}

class MealRateIncludeList extends _is.IncludeList {
  MealRateIncludeList._({
    _is.WhereExpressionBuilder<MealRateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealRate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MealRate.t;
}

class MealRateRepository {
  const MealRateRepository._();

  /// Returns a list of [MealRate]s matching the given query parameters.
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
  Future<List<MealRate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealRateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealRateTable>? orderBy,
    _is.OrderByListBuilder<MealRateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MealRate>(
      where: where?.call(MealRate.t),
      orderBy: orderBy?.call(MealRate.t),
      orderByList: orderByList?.call(MealRate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MealRate] matching the given query parameters.
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
  Future<MealRate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealRateTable>? where,
    int? offset,
    _is.OrderByBuilder<MealRateTable>? orderBy,
    _is.OrderByListBuilder<MealRateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MealRate>(
      where: where?.call(MealRate.t),
      orderBy: orderBy?.call(MealRate.t),
      orderByList: orderByList?.call(MealRate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MealRate] by its [id] or null if no such row exists.
  Future<MealRate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MealRate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MealRate]s in the list and returns the inserted rows.
  ///
  /// The returned [MealRate]s will have their `id` fields set.
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
  Future<List<MealRate>> insert(
    _is.DatabaseSession session,
    List<MealRate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MealRate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MealRate] and returns the inserted row.
  ///
  /// The returned [MealRate] will have its `id` field set.
  Future<MealRate> insertRow(
    _is.DatabaseSession session,
    MealRate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealRate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MealRate]s in the list and returns the resulting rows.
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
  /// The returned [MealRate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealRate>> upsert(
    _is.DatabaseSession session,
    List<MealRate> rows, {
    required _is.ColumnSelections<MealRateTable> conflictColumns,
    _is.ColumnSelections<MealRateTable>? updateColumns,
    _is.WhereExpressionBuilder<MealRateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MealRate>(
      rows,
      conflictColumns: conflictColumns(MealRate.t),
      updateColumns: updateColumns?.call(MealRate.t),
      updateWhere: updateWhere?.call(MealRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MealRate] and returns the resulting row.
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
  /// The returned [MealRate] will have its `id` field set.
  Future<MealRate?> upsertRow(
    _is.DatabaseSession session,
    MealRate row, {
    required _is.ColumnSelections<MealRateTable> conflictColumns,
    _is.ColumnSelections<MealRateTable>? updateColumns,
    _is.WhereExpressionBuilder<MealRateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MealRate>(
      row,
      conflictColumns: conflictColumns(MealRate.t),
      updateColumns: updateColumns?.call(MealRate.t),
      updateWhere: updateWhere?.call(MealRate.t),
      transaction: transaction,
    );
  }

  /// Updates all [MealRate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealRate>> update(
    _is.DatabaseSession session,
    List<MealRate> rows, {
    _is.ColumnSelections<MealRateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MealRate>(
      rows,
      columns: columns?.call(MealRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MealRate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealRate> updateRow(
    _is.DatabaseSession session,
    MealRate row, {
    _is.ColumnSelections<MealRateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealRate>(
      row,
      columns: columns?.call(MealRate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealRate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MealRate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MealRateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MealRate>(
      id,
      columnValues: columnValues(MealRate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MealRate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealRate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MealRateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MealRateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealRateTable>? orderBy,
    _is.OrderByListBuilder<MealRateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MealRate>(
      columnValues: columnValues(MealRate.t.updateTable),
      where: where(MealRate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealRate.t),
      orderByList: orderByList?.call(MealRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MealRate]s in the list and returns the deleted rows.
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
  Future<List<MealRate>> delete(
    _is.DatabaseSession session,
    List<MealRate> rows, {
    _is.OrderByBuilder<MealRateTable>? orderBy,
    _is.OrderByListBuilder<MealRateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MealRate>(
      rows,
      orderBy: orderBy?.call(MealRate.t),
      orderByList: orderByList?.call(MealRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MealRate].
  Future<MealRate> deleteRow(
    _is.DatabaseSession session,
    MealRate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealRate>(
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
  Future<List<MealRate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealRateTable> where,
    _is.OrderByBuilder<MealRateTable>? orderBy,
    _is.OrderByListBuilder<MealRateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MealRate>(
      where: where(MealRate.t),
      orderBy: orderBy?.call(MealRate.t),
      orderByList: orderByList?.call(MealRate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealRateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MealRate>(
      where: where?.call(MealRate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MealRate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealRateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MealRate>(
      where: where(MealRate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
