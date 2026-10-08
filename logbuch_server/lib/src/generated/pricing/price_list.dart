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

/// The prices from a day on, until the next price list begins. A night is
/// priced by the list that is in force on the day it starts.
abstract class PriceList
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PriceList._({
    this.id,
    required this.name,
    required this.validFrom,
  });

  factory PriceList({
    int? id,
    required String name,
    required DateTime validFrom,
  }) = _PriceListImpl;

  factory PriceList.fromJson(Map<String, dynamic> jsonSerialization) {
    return PriceList(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      validFrom: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['validFrom'],
      ),
    );
  }

  static final t = PriceListTable();

  static const db = PriceListRepository._();

  @override
  int? id;

  String name;

  DateTime validFrom;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PriceList]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PriceList copyWith({
    int? id,
    String? name,
    DateTime? validFrom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PriceList',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PriceList',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
    };
  }

  static PriceListInclude include() {
    return PriceListInclude._();
  }

  static PriceListIncludeList includeList({
    _is.WhereExpressionBuilder<PriceListTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PriceListTable>? orderBy,
    _is.OrderByListBuilder<PriceListTable>? orderByList,
    PriceListInclude? include,
  }) {
    return PriceListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PriceList.t),
      orderByList: orderByList?.call(PriceList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PriceListImpl extends PriceList {
  _PriceListImpl({
    int? id,
    required String name,
    required DateTime validFrom,
  }) : super._(
         id: id,
         name: name,
         validFrom: validFrom,
       );

  /// Returns a shallow copy of this [PriceList]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PriceList copyWith({
    Object? id = _Undefined,
    String? name,
    DateTime? validFrom,
  }) {
    return PriceList(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      validFrom: validFrom ?? this.validFrom,
    );
  }
}

class PriceListUpdateTable extends _is.UpdateTable<PriceListTable> {
  PriceListUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> validFrom(DateTime value) =>
      _is.ColumnValue(
        table.validFrom,
        value,
      );
}

class PriceListTable extends _is.Table<int?> {
  PriceListTable({super.tableRelation}) : super(tableName: 'price_lists') {
    updateTable = PriceListUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    validFrom = _is.ColumnDateTime(
      'validFrom',
      this,
    );
  }

  late final PriceListUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnDateTime validFrom;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    validFrom,
  ];
}

class PriceListInclude extends _is.IncludeObject {
  PriceListInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PriceList.t;
}

class PriceListIncludeList extends _is.IncludeList {
  PriceListIncludeList._({
    _is.WhereExpressionBuilder<PriceListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PriceList.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PriceList.t;
}

class PriceListRepository {
  const PriceListRepository._();

  /// Returns a list of [PriceList]s matching the given query parameters.
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
  Future<List<PriceList>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PriceListTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PriceListTable>? orderBy,
    _is.OrderByListBuilder<PriceListTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PriceList>(
      where: where?.call(PriceList.t),
      orderBy: orderBy?.call(PriceList.t),
      orderByList: orderByList?.call(PriceList.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PriceList] matching the given query parameters.
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
  Future<PriceList?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PriceListTable>? where,
    int? offset,
    _is.OrderByBuilder<PriceListTable>? orderBy,
    _is.OrderByListBuilder<PriceListTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PriceList>(
      where: where?.call(PriceList.t),
      orderBy: orderBy?.call(PriceList.t),
      orderByList: orderByList?.call(PriceList.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PriceList] by its [id] or null if no such row exists.
  Future<PriceList?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PriceList>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PriceList]s in the list and returns the inserted rows.
  ///
  /// The returned [PriceList]s will have their `id` fields set.
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
  Future<List<PriceList>> insert(
    _is.DatabaseSession session,
    List<PriceList> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PriceList>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PriceList] and returns the inserted row.
  ///
  /// The returned [PriceList] will have its `id` field set.
  Future<PriceList> insertRow(
    _is.DatabaseSession session,
    PriceList row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PriceList>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PriceList]s in the list and returns the resulting rows.
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
  /// The returned [PriceList]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PriceList>> upsert(
    _is.DatabaseSession session,
    List<PriceList> rows, {
    required _is.ColumnSelections<PriceListTable> conflictColumns,
    _is.ColumnSelections<PriceListTable>? updateColumns,
    _is.WhereExpressionBuilder<PriceListTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PriceList>(
      rows,
      conflictColumns: conflictColumns(PriceList.t),
      updateColumns: updateColumns?.call(PriceList.t),
      updateWhere: updateWhere?.call(PriceList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PriceList] and returns the resulting row.
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
  /// The returned [PriceList] will have its `id` field set.
  Future<PriceList?> upsertRow(
    _is.DatabaseSession session,
    PriceList row, {
    required _is.ColumnSelections<PriceListTable> conflictColumns,
    _is.ColumnSelections<PriceListTable>? updateColumns,
    _is.WhereExpressionBuilder<PriceListTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PriceList>(
      row,
      conflictColumns: conflictColumns(PriceList.t),
      updateColumns: updateColumns?.call(PriceList.t),
      updateWhere: updateWhere?.call(PriceList.t),
      transaction: transaction,
    );
  }

  /// Updates all [PriceList]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PriceList>> update(
    _is.DatabaseSession session,
    List<PriceList> rows, {
    _is.ColumnSelections<PriceListTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PriceList>(
      rows,
      columns: columns?.call(PriceList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PriceList]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PriceList> updateRow(
    _is.DatabaseSession session,
    PriceList row, {
    _is.ColumnSelections<PriceListTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PriceList>(
      row,
      columns: columns?.call(PriceList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PriceList] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PriceList?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PriceListUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PriceList>(
      id,
      columnValues: columnValues(PriceList.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PriceList]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PriceList>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PriceListUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PriceListTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PriceListTable>? orderBy,
    _is.OrderByListBuilder<PriceListTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PriceList>(
      columnValues: columnValues(PriceList.t.updateTable),
      where: where(PriceList.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PriceList.t),
      orderByList: orderByList?.call(PriceList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PriceList]s in the list and returns the deleted rows.
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
  Future<List<PriceList>> delete(
    _is.DatabaseSession session,
    List<PriceList> rows, {
    _is.OrderByBuilder<PriceListTable>? orderBy,
    _is.OrderByListBuilder<PriceListTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PriceList>(
      rows,
      orderBy: orderBy?.call(PriceList.t),
      orderByList: orderByList?.call(PriceList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PriceList].
  Future<PriceList> deleteRow(
    _is.DatabaseSession session,
    PriceList row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PriceList>(
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
  Future<List<PriceList>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PriceListTable> where,
    _is.OrderByBuilder<PriceListTable>? orderBy,
    _is.OrderByListBuilder<PriceListTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PriceList>(
      where: where(PriceList.t),
      orderBy: orderBy?.call(PriceList.t),
      orderByList: orderByList?.call(PriceList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PriceListTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PriceList>(
      where: where?.call(PriceList.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PriceList] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PriceListTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PriceList>(
      where: where(PriceList.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
