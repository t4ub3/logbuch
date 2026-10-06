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

abstract class PriceCategory
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PriceCategory._({
    this.id,
    required this.name,
    int? sortOrder,
  }) : sortOrder = sortOrder ?? 0;

  factory PriceCategory({
    int? id,
    required String name,
    int? sortOrder,
  }) = _PriceCategoryImpl;

  factory PriceCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return PriceCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int?,
    );
  }

  static final t = PriceCategoryTable();

  static const db = PriceCategoryRepository._();

  @override
  int? id;

  String name;

  int sortOrder;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PriceCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PriceCategory copyWith({
    int? id,
    String? name,
    int? sortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PriceCategory',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PriceCategory',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
    };
  }

  static PriceCategoryInclude include() {
    return PriceCategoryInclude._();
  }

  static PriceCategoryIncludeList includeList({
    _is.WhereExpressionBuilder<PriceCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PriceCategoryTable>? orderBy,
    _is.OrderByListBuilder<PriceCategoryTable>? orderByList,
    PriceCategoryInclude? include,
  }) {
    return PriceCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PriceCategory.t),
      orderByList: orderByList?.call(PriceCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PriceCategoryImpl extends PriceCategory {
  _PriceCategoryImpl({
    int? id,
    required String name,
    int? sortOrder,
  }) : super._(
         id: id,
         name: name,
         sortOrder: sortOrder,
       );

  /// Returns a shallow copy of this [PriceCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PriceCategory copyWith({
    Object? id = _Undefined,
    String? name,
    int? sortOrder,
  }) {
    return PriceCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

class PriceCategoryUpdateTable extends _is.UpdateTable<PriceCategoryTable> {
  PriceCategoryUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );
}

class PriceCategoryTable extends _is.Table<int?> {
  PriceCategoryTable({super.tableRelation})
    : super(tableName: 'price_categories') {
    updateTable = PriceCategoryUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
  }

  late final PriceCategoryUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt sortOrder;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    sortOrder,
  ];
}

class PriceCategoryInclude extends _is.IncludeObject {
  PriceCategoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PriceCategory.t;
}

class PriceCategoryIncludeList extends _is.IncludeList {
  PriceCategoryIncludeList._({
    _is.WhereExpressionBuilder<PriceCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PriceCategory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PriceCategory.t;
}

class PriceCategoryRepository {
  const PriceCategoryRepository._();

  /// Returns a list of [PriceCategory]s matching the given query parameters.
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
  Future<List<PriceCategory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PriceCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PriceCategoryTable>? orderBy,
    _is.OrderByListBuilder<PriceCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PriceCategory>(
      where: where?.call(PriceCategory.t),
      orderBy: orderBy?.call(PriceCategory.t),
      orderByList: orderByList?.call(PriceCategory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PriceCategory] matching the given query parameters.
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
  Future<PriceCategory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PriceCategoryTable>? where,
    int? offset,
    _is.OrderByBuilder<PriceCategoryTable>? orderBy,
    _is.OrderByListBuilder<PriceCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PriceCategory>(
      where: where?.call(PriceCategory.t),
      orderBy: orderBy?.call(PriceCategory.t),
      orderByList: orderByList?.call(PriceCategory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PriceCategory] by its [id] or null if no such row exists.
  Future<PriceCategory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PriceCategory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PriceCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [PriceCategory]s will have their `id` fields set.
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
  Future<List<PriceCategory>> insert(
    _is.DatabaseSession session,
    List<PriceCategory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PriceCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PriceCategory] and returns the inserted row.
  ///
  /// The returned [PriceCategory] will have its `id` field set.
  Future<PriceCategory> insertRow(
    _is.DatabaseSession session,
    PriceCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PriceCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PriceCategory]s in the list and returns the resulting rows.
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
  /// The returned [PriceCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PriceCategory>> upsert(
    _is.DatabaseSession session,
    List<PriceCategory> rows, {
    required _is.ColumnSelections<PriceCategoryTable> conflictColumns,
    _is.ColumnSelections<PriceCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<PriceCategoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PriceCategory>(
      rows,
      conflictColumns: conflictColumns(PriceCategory.t),
      updateColumns: updateColumns?.call(PriceCategory.t),
      updateWhere: updateWhere?.call(PriceCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PriceCategory] and returns the resulting row.
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
  /// The returned [PriceCategory] will have its `id` field set.
  Future<PriceCategory?> upsertRow(
    _is.DatabaseSession session,
    PriceCategory row, {
    required _is.ColumnSelections<PriceCategoryTable> conflictColumns,
    _is.ColumnSelections<PriceCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<PriceCategoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PriceCategory>(
      row,
      conflictColumns: conflictColumns(PriceCategory.t),
      updateColumns: updateColumns?.call(PriceCategory.t),
      updateWhere: updateWhere?.call(PriceCategory.t),
      transaction: transaction,
    );
  }

  /// Updates all [PriceCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PriceCategory>> update(
    _is.DatabaseSession session,
    List<PriceCategory> rows, {
    _is.ColumnSelections<PriceCategoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PriceCategory>(
      rows,
      columns: columns?.call(PriceCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PriceCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PriceCategory> updateRow(
    _is.DatabaseSession session,
    PriceCategory row, {
    _is.ColumnSelections<PriceCategoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PriceCategory>(
      row,
      columns: columns?.call(PriceCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PriceCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PriceCategory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PriceCategoryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PriceCategory>(
      id,
      columnValues: columnValues(PriceCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PriceCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PriceCategory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PriceCategoryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PriceCategoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PriceCategoryTable>? orderBy,
    _is.OrderByListBuilder<PriceCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PriceCategory>(
      columnValues: columnValues(PriceCategory.t.updateTable),
      where: where(PriceCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PriceCategory.t),
      orderByList: orderByList?.call(PriceCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PriceCategory]s in the list and returns the deleted rows.
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
  Future<List<PriceCategory>> delete(
    _is.DatabaseSession session,
    List<PriceCategory> rows, {
    _is.OrderByBuilder<PriceCategoryTable>? orderBy,
    _is.OrderByListBuilder<PriceCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PriceCategory>(
      rows,
      orderBy: orderBy?.call(PriceCategory.t),
      orderByList: orderByList?.call(PriceCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PriceCategory].
  Future<PriceCategory> deleteRow(
    _is.DatabaseSession session,
    PriceCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PriceCategory>(
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
  Future<List<PriceCategory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PriceCategoryTable> where,
    _is.OrderByBuilder<PriceCategoryTable>? orderBy,
    _is.OrderByListBuilder<PriceCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PriceCategory>(
      where: where(PriceCategory.t),
      orderBy: orderBy?.call(PriceCategory.t),
      orderByList: orderByList?.call(PriceCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PriceCategoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PriceCategory>(
      where: where?.call(PriceCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PriceCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PriceCategoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PriceCategory>(
      where: where(PriceCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
