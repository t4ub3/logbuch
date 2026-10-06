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

abstract class MealPlan
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MealPlan._({
    this.id,
    required this.name,
  });

  factory MealPlan({
    int? id,
    required String name,
  }) = _MealPlanImpl;

  factory MealPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlan(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
    );
  }

  static final t = MealPlanTable();

  static const db = MealPlanRepository._();

  @override
  int? id;

  String name;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MealPlan copyWith({
    int? id,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealPlan',
      if (id != null) 'id': id,
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealPlan',
      if (id != null) 'id': id,
      'name': name,
    };
  }

  static MealPlanInclude include() {
    return MealPlanInclude._();
  }

  static MealPlanIncludeList includeList({
    _is.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealPlanTable>? orderBy,
    _is.OrderByListBuilder<MealPlanTable>? orderByList,
    MealPlanInclude? include,
  }) {
    return MealPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanImpl extends MealPlan {
  _MealPlanImpl({
    int? id,
    required String name,
  }) : super._(
         id: id,
         name: name,
       );

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MealPlan copyWith({
    Object? id = _Undefined,
    String? name,
  }) {
    return MealPlan(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
    );
  }
}

class MealPlanUpdateTable extends _is.UpdateTable<MealPlanTable> {
  MealPlanUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );
}

class MealPlanTable extends _is.Table<int?> {
  MealPlanTable({super.tableRelation}) : super(tableName: 'meal_plans') {
    updateTable = MealPlanUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
  }

  late final MealPlanUpdateTable updateTable;

  late final _is.ColumnString name;

  @override
  List<_is.Column> get columns => [
    id,
    name,
  ];
}

class MealPlanInclude extends _is.IncludeObject {
  MealPlanInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MealPlan.t;
}

class MealPlanIncludeList extends _is.IncludeList {
  MealPlanIncludeList._({
    _is.WhereExpressionBuilder<MealPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealPlan.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MealPlan.t;
}

class MealPlanRepository {
  const MealPlanRepository._();

  /// Returns a list of [MealPlan]s matching the given query parameters.
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
  Future<List<MealPlan>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealPlanTable>? orderBy,
    _is.OrderByListBuilder<MealPlanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MealPlan>(
      where: where?.call(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MealPlan] matching the given query parameters.
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
  Future<MealPlan?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealPlanTable>? where,
    int? offset,
    _is.OrderByBuilder<MealPlanTable>? orderBy,
    _is.OrderByListBuilder<MealPlanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MealPlan>(
      where: where?.call(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MealPlan] by its [id] or null if no such row exists.
  Future<MealPlan?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MealPlan>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MealPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [MealPlan]s will have their `id` fields set.
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
  Future<List<MealPlan>> insert(
    _is.DatabaseSession session,
    List<MealPlan> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MealPlan>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MealPlan] and returns the inserted row.
  ///
  /// The returned [MealPlan] will have its `id` field set.
  Future<MealPlan> insertRow(
    _is.DatabaseSession session,
    MealPlan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MealPlan]s in the list and returns the resulting rows.
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
  /// The returned [MealPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealPlan>> upsert(
    _is.DatabaseSession session,
    List<MealPlan> rows, {
    required _is.ColumnSelections<MealPlanTable> conflictColumns,
    _is.ColumnSelections<MealPlanTable>? updateColumns,
    _is.WhereExpressionBuilder<MealPlanTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MealPlan>(
      rows,
      conflictColumns: conflictColumns(MealPlan.t),
      updateColumns: updateColumns?.call(MealPlan.t),
      updateWhere: updateWhere?.call(MealPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MealPlan] and returns the resulting row.
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
  /// The returned [MealPlan] will have its `id` field set.
  Future<MealPlan?> upsertRow(
    _is.DatabaseSession session,
    MealPlan row, {
    required _is.ColumnSelections<MealPlanTable> conflictColumns,
    _is.ColumnSelections<MealPlanTable>? updateColumns,
    _is.WhereExpressionBuilder<MealPlanTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MealPlan>(
      row,
      conflictColumns: conflictColumns(MealPlan.t),
      updateColumns: updateColumns?.call(MealPlan.t),
      updateWhere: updateWhere?.call(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Updates all [MealPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealPlan>> update(
    _is.DatabaseSession session,
    List<MealPlan> rows, {
    _is.ColumnSelections<MealPlanTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MealPlan>(
      rows,
      columns: columns?.call(MealPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MealPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealPlan> updateRow(
    _is.DatabaseSession session,
    MealPlan row, {
    _is.ColumnSelections<MealPlanTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealPlan>(
      row,
      columns: columns?.call(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealPlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MealPlan?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MealPlanUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MealPlan>(
      id,
      columnValues: columnValues(MealPlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MealPlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealPlan>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MealPlanUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MealPlanTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealPlanTable>? orderBy,
    _is.OrderByListBuilder<MealPlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MealPlan>(
      columnValues: columnValues(MealPlan.t.updateTable),
      where: where(MealPlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MealPlan]s in the list and returns the deleted rows.
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
  Future<List<MealPlan>> delete(
    _is.DatabaseSession session,
    List<MealPlan> rows, {
    _is.OrderByBuilder<MealPlanTable>? orderBy,
    _is.OrderByListBuilder<MealPlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MealPlan>(
      rows,
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MealPlan].
  Future<MealPlan> deleteRow(
    _is.DatabaseSession session,
    MealPlan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealPlan>(
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
  Future<List<MealPlan>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealPlanTable> where,
    _is.OrderByBuilder<MealPlanTable>? orderBy,
    _is.OrderByListBuilder<MealPlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MealPlan>(
      where: where(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MealPlan>(
      where: where?.call(MealPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MealPlan] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealPlanTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MealPlan>(
      where: where(MealPlan.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
