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

/// A kind of room or house that is priced the same way, such as a room in
/// the main house or a bungalow. Its prices are in the price lists.
abstract class UnitType
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UnitType._({
    this.id,
    required this.name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) : sortOrder = sortOrder ?? 0,
       taxRate = taxRate ?? 700,
       shared = shared ?? false;

  factory UnitType({
    int? id,
    required String name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) = _UnitTypeImpl;

  factory UnitType.fromJson(Map<String, dynamic> jsonSerialization) {
    return UnitType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      taxRate: jsonSerialization['taxRate'] as int?,
      shared: jsonSerialization['shared'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['shared']),
    );
  }

  static final t = UnitTypeTable();

  static const db = UnitTypeRepository._();

  @override
  int? id;

  String name;

  int sortOrder;

  /// What staying in a unit of this type is taxed with, in basis points.
  int taxRate;

  /// Several bookings may hold a unit of this type during the same night.
  /// They share what it costs per night.
  bool shared;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UnitType]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UnitType copyWith({
    int? id,
    String? name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UnitType',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
      'taxRate': taxRate,
      'shared': shared,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UnitType',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
      'taxRate': taxRate,
      'shared': shared,
    };
  }

  static UnitTypeInclude include() {
    return UnitTypeInclude._();
  }

  static UnitTypeIncludeList includeList({
    _is.WhereExpressionBuilder<UnitTypeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UnitTypeTable>? orderBy,
    _is.OrderByListBuilder<UnitTypeTable>? orderByList,
    UnitTypeInclude? include,
  }) {
    return UnitTypeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UnitType.t),
      orderByList: orderByList?.call(UnitType.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UnitTypeImpl extends UnitType {
  _UnitTypeImpl({
    int? id,
    required String name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) : super._(
         id: id,
         name: name,
         sortOrder: sortOrder,
         taxRate: taxRate,
         shared: shared,
       );

  /// Returns a shallow copy of this [UnitType]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UnitType copyWith({
    Object? id = _Undefined,
    String? name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) {
    return UnitType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      taxRate: taxRate ?? this.taxRate,
      shared: shared ?? this.shared,
    );
  }
}

class UnitTypeUpdateTable extends _is.UpdateTable<UnitTypeTable> {
  UnitTypeUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<int, int> taxRate(int value) => _is.ColumnValue(
    table.taxRate,
    value,
  );

  _is.ColumnValue<bool, bool> shared(bool value) => _is.ColumnValue(
    table.shared,
    value,
  );
}

class UnitTypeTable extends _is.Table<int?> {
  UnitTypeTable({super.tableRelation}) : super(tableName: 'unit_types') {
    updateTable = UnitTypeUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    taxRate = _is.ColumnInt(
      'taxRate',
      this,
      hasDefault: true,
    );
    shared = _is.ColumnBool(
      'shared',
      this,
      hasDefault: true,
    );
  }

  late final UnitTypeUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt sortOrder;

  /// What staying in a unit of this type is taxed with, in basis points.
  late final _is.ColumnInt taxRate;

  /// Several bookings may hold a unit of this type during the same night.
  /// They share what it costs per night.
  late final _is.ColumnBool shared;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    sortOrder,
    taxRate,
    shared,
  ];
}

class UnitTypeInclude extends _is.IncludeObject {
  UnitTypeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UnitType.t;
}

class UnitTypeIncludeList extends _is.IncludeList {
  UnitTypeIncludeList._({
    _is.WhereExpressionBuilder<UnitTypeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UnitType.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UnitType.t;
}

class UnitTypeRepository {
  const UnitTypeRepository._();

  /// Returns a list of [UnitType]s matching the given query parameters.
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
  Future<List<UnitType>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UnitTypeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UnitTypeTable>? orderBy,
    _is.OrderByListBuilder<UnitTypeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UnitType>(
      where: where?.call(UnitType.t),
      orderBy: orderBy?.call(UnitType.t),
      orderByList: orderByList?.call(UnitType.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UnitType] matching the given query parameters.
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
  Future<UnitType?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UnitTypeTable>? where,
    int? offset,
    _is.OrderByBuilder<UnitTypeTable>? orderBy,
    _is.OrderByListBuilder<UnitTypeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UnitType>(
      where: where?.call(UnitType.t),
      orderBy: orderBy?.call(UnitType.t),
      orderByList: orderByList?.call(UnitType.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UnitType] by its [id] or null if no such row exists.
  Future<UnitType?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UnitType>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UnitType]s in the list and returns the inserted rows.
  ///
  /// The returned [UnitType]s will have their `id` fields set.
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
  Future<List<UnitType>> insert(
    _is.DatabaseSession session,
    List<UnitType> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UnitType>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UnitType] and returns the inserted row.
  ///
  /// The returned [UnitType] will have its `id` field set.
  Future<UnitType> insertRow(
    _is.DatabaseSession session,
    UnitType row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UnitType>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UnitType]s in the list and returns the resulting rows.
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
  /// The returned [UnitType]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UnitType>> upsert(
    _is.DatabaseSession session,
    List<UnitType> rows, {
    required _is.ColumnSelections<UnitTypeTable> conflictColumns,
    _is.ColumnSelections<UnitTypeTable>? updateColumns,
    _is.WhereExpressionBuilder<UnitTypeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UnitType>(
      rows,
      conflictColumns: conflictColumns(UnitType.t),
      updateColumns: updateColumns?.call(UnitType.t),
      updateWhere: updateWhere?.call(UnitType.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UnitType] and returns the resulting row.
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
  /// The returned [UnitType] will have its `id` field set.
  Future<UnitType?> upsertRow(
    _is.DatabaseSession session,
    UnitType row, {
    required _is.ColumnSelections<UnitTypeTable> conflictColumns,
    _is.ColumnSelections<UnitTypeTable>? updateColumns,
    _is.WhereExpressionBuilder<UnitTypeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UnitType>(
      row,
      conflictColumns: conflictColumns(UnitType.t),
      updateColumns: updateColumns?.call(UnitType.t),
      updateWhere: updateWhere?.call(UnitType.t),
      transaction: transaction,
    );
  }

  /// Updates all [UnitType]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UnitType>> update(
    _is.DatabaseSession session,
    List<UnitType> rows, {
    _is.ColumnSelections<UnitTypeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UnitType>(
      rows,
      columns: columns?.call(UnitType.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UnitType]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UnitType> updateRow(
    _is.DatabaseSession session,
    UnitType row, {
    _is.ColumnSelections<UnitTypeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UnitType>(
      row,
      columns: columns?.call(UnitType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UnitType] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UnitType?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UnitTypeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UnitType>(
      id,
      columnValues: columnValues(UnitType.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UnitType]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UnitType>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UnitTypeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UnitTypeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UnitTypeTable>? orderBy,
    _is.OrderByListBuilder<UnitTypeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UnitType>(
      columnValues: columnValues(UnitType.t.updateTable),
      where: where(UnitType.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UnitType.t),
      orderByList: orderByList?.call(UnitType.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UnitType]s in the list and returns the deleted rows.
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
  Future<List<UnitType>> delete(
    _is.DatabaseSession session,
    List<UnitType> rows, {
    _is.OrderByBuilder<UnitTypeTable>? orderBy,
    _is.OrderByListBuilder<UnitTypeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UnitType>(
      rows,
      orderBy: orderBy?.call(UnitType.t),
      orderByList: orderByList?.call(UnitType.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UnitType].
  Future<UnitType> deleteRow(
    _is.DatabaseSession session,
    UnitType row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UnitType>(
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
  Future<List<UnitType>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UnitTypeTable> where,
    _is.OrderByBuilder<UnitTypeTable>? orderBy,
    _is.OrderByListBuilder<UnitTypeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UnitType>(
      where: where(UnitType.t),
      orderBy: orderBy?.call(UnitType.t),
      orderByList: orderByList?.call(UnitType.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UnitTypeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UnitType>(
      where: where?.call(UnitType.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UnitType] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UnitTypeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UnitType>(
      where: where(UnitType.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
