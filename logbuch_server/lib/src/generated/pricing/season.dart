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

abstract class Season implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Season._({
    this.id,
    required this.name,
    required this.validFrom,
    required this.validTo,
  });

  factory Season({
    int? id,
    required String name,
    required DateTime validFrom,
    required DateTime validTo,
  }) = _SeasonImpl;

  factory Season.fromJson(Map<String, dynamic> jsonSerialization) {
    return Season(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      validFrom: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['validFrom'],
      ),
      validTo: _is.DateTimeJsonExtension.fromJson(jsonSerialization['validTo']),
    );
  }

  static final t = SeasonTable();

  static const db = SeasonRepository._();

  @override
  int? id;

  String name;

  DateTime validFrom;

  DateTime validTo;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Season]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Season copyWith({
    int? id,
    String? name,
    DateTime? validFrom,
    DateTime? validTo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Season',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
      'validTo': validTo.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Season',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
      'validTo': validTo.toJson(),
    };
  }

  static SeasonInclude include() {
    return SeasonInclude._();
  }

  static SeasonIncludeList includeList({
    _is.WhereExpressionBuilder<SeasonTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeasonTable>? orderBy,
    _is.OrderByListBuilder<SeasonTable>? orderByList,
    SeasonInclude? include,
  }) {
    return SeasonIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Season.t),
      orderByList: orderByList?.call(Season.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonImpl extends Season {
  _SeasonImpl({
    int? id,
    required String name,
    required DateTime validFrom,
    required DateTime validTo,
  }) : super._(
         id: id,
         name: name,
         validFrom: validFrom,
         validTo: validTo,
       );

  /// Returns a shallow copy of this [Season]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Season copyWith({
    Object? id = _Undefined,
    String? name,
    DateTime? validFrom,
    DateTime? validTo,
  }) {
    return Season(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
    );
  }
}

class SeasonUpdateTable extends _is.UpdateTable<SeasonTable> {
  SeasonUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> validFrom(DateTime value) =>
      _is.ColumnValue(
        table.validFrom,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> validTo(DateTime value) =>
      _is.ColumnValue(
        table.validTo,
        value,
      );
}

class SeasonTable extends _is.Table<int?> {
  SeasonTable({super.tableRelation}) : super(tableName: 'seasons') {
    updateTable = SeasonUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    validFrom = _is.ColumnDateTime(
      'validFrom',
      this,
    );
    validTo = _is.ColumnDateTime(
      'validTo',
      this,
    );
  }

  late final SeasonUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnDateTime validFrom;

  late final _is.ColumnDateTime validTo;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    validFrom,
    validTo,
  ];
}

class SeasonInclude extends _is.IncludeObject {
  SeasonInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Season.t;
}

class SeasonIncludeList extends _is.IncludeList {
  SeasonIncludeList._({
    _is.WhereExpressionBuilder<SeasonTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Season.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Season.t;
}

class SeasonRepository {
  const SeasonRepository._();

  /// Returns a list of [Season]s matching the given query parameters.
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
  Future<List<Season>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeasonTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeasonTable>? orderBy,
    _is.OrderByListBuilder<SeasonTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Season>(
      where: where?.call(Season.t),
      orderBy: orderBy?.call(Season.t),
      orderByList: orderByList?.call(Season.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Season] matching the given query parameters.
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
  Future<Season?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeasonTable>? where,
    int? offset,
    _is.OrderByBuilder<SeasonTable>? orderBy,
    _is.OrderByListBuilder<SeasonTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Season>(
      where: where?.call(Season.t),
      orderBy: orderBy?.call(Season.t),
      orderByList: orderByList?.call(Season.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Season] by its [id] or null if no such row exists.
  Future<Season?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Season>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Season]s in the list and returns the inserted rows.
  ///
  /// The returned [Season]s will have their `id` fields set.
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
  Future<List<Season>> insert(
    _is.DatabaseSession session,
    List<Season> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Season>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Season] and returns the inserted row.
  ///
  /// The returned [Season] will have its `id` field set.
  Future<Season> insertRow(
    _is.DatabaseSession session,
    Season row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Season>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Season]s in the list and returns the resulting rows.
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
  /// The returned [Season]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Season>> upsert(
    _is.DatabaseSession session,
    List<Season> rows, {
    required _is.ColumnSelections<SeasonTable> conflictColumns,
    _is.ColumnSelections<SeasonTable>? updateColumns,
    _is.WhereExpressionBuilder<SeasonTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Season>(
      rows,
      conflictColumns: conflictColumns(Season.t),
      updateColumns: updateColumns?.call(Season.t),
      updateWhere: updateWhere?.call(Season.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Season] and returns the resulting row.
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
  /// The returned [Season] will have its `id` field set.
  Future<Season?> upsertRow(
    _is.DatabaseSession session,
    Season row, {
    required _is.ColumnSelections<SeasonTable> conflictColumns,
    _is.ColumnSelections<SeasonTable>? updateColumns,
    _is.WhereExpressionBuilder<SeasonTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Season>(
      row,
      conflictColumns: conflictColumns(Season.t),
      updateColumns: updateColumns?.call(Season.t),
      updateWhere: updateWhere?.call(Season.t),
      transaction: transaction,
    );
  }

  /// Updates all [Season]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Season>> update(
    _is.DatabaseSession session,
    List<Season> rows, {
    _is.ColumnSelections<SeasonTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Season>(
      rows,
      columns: columns?.call(Season.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Season]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Season> updateRow(
    _is.DatabaseSession session,
    Season row, {
    _is.ColumnSelections<SeasonTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Season>(
      row,
      columns: columns?.call(Season.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Season] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Season?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SeasonUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Season>(
      id,
      columnValues: columnValues(Season.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Season]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Season>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SeasonUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SeasonTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeasonTable>? orderBy,
    _is.OrderByListBuilder<SeasonTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Season>(
      columnValues: columnValues(Season.t.updateTable),
      where: where(Season.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Season.t),
      orderByList: orderByList?.call(Season.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Season]s in the list and returns the deleted rows.
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
  Future<List<Season>> delete(
    _is.DatabaseSession session,
    List<Season> rows, {
    _is.OrderByBuilder<SeasonTable>? orderBy,
    _is.OrderByListBuilder<SeasonTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Season>(
      rows,
      orderBy: orderBy?.call(Season.t),
      orderByList: orderByList?.call(Season.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Season].
  Future<Season> deleteRow(
    _is.DatabaseSession session,
    Season row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Season>(
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
  Future<List<Season>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SeasonTable> where,
    _is.OrderByBuilder<SeasonTable>? orderBy,
    _is.OrderByListBuilder<SeasonTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Season>(
      where: where(Season.t),
      orderBy: orderBy?.call(Season.t),
      orderByList: orderByList?.call(Season.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeasonTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Season>(
      where: where?.call(Season.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Season] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SeasonTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Season>(
      where: where(Season.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
