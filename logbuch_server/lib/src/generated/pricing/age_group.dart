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

abstract class AgeGroup
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AgeGroup._({
    this.id,
    required this.name,
    required this.minAge,
    this.maxAge,
  });

  factory AgeGroup({
    int? id,
    required String name,
    required int minAge,
    int? maxAge,
  }) = _AgeGroupImpl;

  factory AgeGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgeGroup(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      minAge: jsonSerialization['minAge'] as int,
      maxAge: jsonSerialization['maxAge'] as int?,
    );
  }

  static final t = AgeGroupTable();

  static const db = AgeGroupRepository._();

  @override
  int? id;

  String name;

  int minAge;

  int? maxAge;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AgeGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AgeGroup copyWith({
    int? id,
    String? name,
    int? minAge,
    int? maxAge,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgeGroup',
      if (id != null) 'id': id,
      'name': name,
      'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgeGroup',
      if (id != null) 'id': id,
      'name': name,
      'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
    };
  }

  static AgeGroupInclude include() {
    return AgeGroupInclude._();
  }

  static AgeGroupIncludeList includeList({
    _is.WhereExpressionBuilder<AgeGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgeGroupTable>? orderBy,
    _is.OrderByListBuilder<AgeGroupTable>? orderByList,
    AgeGroupInclude? include,
  }) {
    return AgeGroupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AgeGroup.t),
      orderByList: orderByList?.call(AgeGroup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgeGroupImpl extends AgeGroup {
  _AgeGroupImpl({
    int? id,
    required String name,
    required int minAge,
    int? maxAge,
  }) : super._(
         id: id,
         name: name,
         minAge: minAge,
         maxAge: maxAge,
       );

  /// Returns a shallow copy of this [AgeGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AgeGroup copyWith({
    Object? id = _Undefined,
    String? name,
    int? minAge,
    Object? maxAge = _Undefined,
  }) {
    return AgeGroup(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge is int? ? maxAge : this.maxAge,
    );
  }
}

class AgeGroupUpdateTable extends _is.UpdateTable<AgeGroupTable> {
  AgeGroupUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> minAge(int value) => _is.ColumnValue(
    table.minAge,
    value,
  );

  _is.ColumnValue<int, int> maxAge(int? value) => _is.ColumnValue(
    table.maxAge,
    value,
  );
}

class AgeGroupTable extends _is.Table<int?> {
  AgeGroupTable({super.tableRelation}) : super(tableName: 'age_groups') {
    updateTable = AgeGroupUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    minAge = _is.ColumnInt(
      'minAge',
      this,
    );
    maxAge = _is.ColumnInt(
      'maxAge',
      this,
    );
  }

  late final AgeGroupUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt minAge;

  late final _is.ColumnInt maxAge;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    minAge,
    maxAge,
  ];
}

class AgeGroupInclude extends _is.IncludeObject {
  AgeGroupInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AgeGroup.t;
}

class AgeGroupIncludeList extends _is.IncludeList {
  AgeGroupIncludeList._({
    _is.WhereExpressionBuilder<AgeGroupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AgeGroup.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AgeGroup.t;
}

class AgeGroupRepository {
  const AgeGroupRepository._();

  /// Returns a list of [AgeGroup]s matching the given query parameters.
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
  Future<List<AgeGroup>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgeGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgeGroupTable>? orderBy,
    _is.OrderByListBuilder<AgeGroupTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AgeGroup>(
      where: where?.call(AgeGroup.t),
      orderBy: orderBy?.call(AgeGroup.t),
      orderByList: orderByList?.call(AgeGroup.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AgeGroup] matching the given query parameters.
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
  Future<AgeGroup?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgeGroupTable>? where,
    int? offset,
    _is.OrderByBuilder<AgeGroupTable>? orderBy,
    _is.OrderByListBuilder<AgeGroupTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AgeGroup>(
      where: where?.call(AgeGroup.t),
      orderBy: orderBy?.call(AgeGroup.t),
      orderByList: orderByList?.call(AgeGroup.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AgeGroup] by its [id] or null if no such row exists.
  Future<AgeGroup?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AgeGroup>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AgeGroup]s in the list and returns the inserted rows.
  ///
  /// The returned [AgeGroup]s will have their `id` fields set.
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
  Future<List<AgeGroup>> insert(
    _is.DatabaseSession session,
    List<AgeGroup> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AgeGroup>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AgeGroup] and returns the inserted row.
  ///
  /// The returned [AgeGroup] will have its `id` field set.
  Future<AgeGroup> insertRow(
    _is.DatabaseSession session,
    AgeGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AgeGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AgeGroup]s in the list and returns the resulting rows.
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
  /// The returned [AgeGroup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgeGroup>> upsert(
    _is.DatabaseSession session,
    List<AgeGroup> rows, {
    required _is.ColumnSelections<AgeGroupTable> conflictColumns,
    _is.ColumnSelections<AgeGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<AgeGroupTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AgeGroup>(
      rows,
      conflictColumns: conflictColumns(AgeGroup.t),
      updateColumns: updateColumns?.call(AgeGroup.t),
      updateWhere: updateWhere?.call(AgeGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AgeGroup] and returns the resulting row.
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
  /// The returned [AgeGroup] will have its `id` field set.
  Future<AgeGroup?> upsertRow(
    _is.DatabaseSession session,
    AgeGroup row, {
    required _is.ColumnSelections<AgeGroupTable> conflictColumns,
    _is.ColumnSelections<AgeGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<AgeGroupTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AgeGroup>(
      row,
      conflictColumns: conflictColumns(AgeGroup.t),
      updateColumns: updateColumns?.call(AgeGroup.t),
      updateWhere: updateWhere?.call(AgeGroup.t),
      transaction: transaction,
    );
  }

  /// Updates all [AgeGroup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgeGroup>> update(
    _is.DatabaseSession session,
    List<AgeGroup> rows, {
    _is.ColumnSelections<AgeGroupTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AgeGroup>(
      rows,
      columns: columns?.call(AgeGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AgeGroup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AgeGroup> updateRow(
    _is.DatabaseSession session,
    AgeGroup row, {
    _is.ColumnSelections<AgeGroupTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AgeGroup>(
      row,
      columns: columns?.call(AgeGroup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AgeGroup] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AgeGroup?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AgeGroupUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AgeGroup>(
      id,
      columnValues: columnValues(AgeGroup.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AgeGroup]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgeGroup>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AgeGroupUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AgeGroupTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgeGroupTable>? orderBy,
    _is.OrderByListBuilder<AgeGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AgeGroup>(
      columnValues: columnValues(AgeGroup.t.updateTable),
      where: where(AgeGroup.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AgeGroup.t),
      orderByList: orderByList?.call(AgeGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AgeGroup]s in the list and returns the deleted rows.
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
  Future<List<AgeGroup>> delete(
    _is.DatabaseSession session,
    List<AgeGroup> rows, {
    _is.OrderByBuilder<AgeGroupTable>? orderBy,
    _is.OrderByListBuilder<AgeGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AgeGroup>(
      rows,
      orderBy: orderBy?.call(AgeGroup.t),
      orderByList: orderByList?.call(AgeGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AgeGroup].
  Future<AgeGroup> deleteRow(
    _is.DatabaseSession session,
    AgeGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AgeGroup>(
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
  Future<List<AgeGroup>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AgeGroupTable> where,
    _is.OrderByBuilder<AgeGroupTable>? orderBy,
    _is.OrderByListBuilder<AgeGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AgeGroup>(
      where: where(AgeGroup.t),
      orderBy: orderBy?.call(AgeGroup.t),
      orderByList: orderByList?.call(AgeGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgeGroupTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AgeGroup>(
      where: where?.call(AgeGroup.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AgeGroup] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AgeGroupTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AgeGroup>(
      where: where(AgeGroup.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
