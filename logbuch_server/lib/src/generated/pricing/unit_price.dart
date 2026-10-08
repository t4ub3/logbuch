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

/// What a unit of a type costs as a whole, whoever stays in it.
abstract class UnitPrice
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UnitPrice._({
    this.id,
    required this.priceListId,
    required this.unitTypeId,
    this.pricePerNight,
    this.dayUsePrice,
  });

  factory UnitPrice({
    int? id,
    required int priceListId,
    required int unitTypeId,
    int? pricePerNight,
    int? dayUsePrice,
  }) = _UnitPriceImpl;

  factory UnitPrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return UnitPrice(
      id: jsonSerialization['id'] as int?,
      priceListId: jsonSerialization['priceListId'] as int,
      unitTypeId: jsonSerialization['unitTypeId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int?,
      dayUsePrice: jsonSerialization['dayUsePrice'] as int?,
    );
  }

  static final t = UnitPriceTable();

  static const db = UnitPriceRepository._();

  @override
  int? id;

  int priceListId;

  int unitTypeId;

  /// Null if the unit itself costs nothing and only its guests pay.
  int? pricePerNight;

  /// What a booking that arrives and departs on the same day pays.
  int? dayUsePrice;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UnitPrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UnitPrice copyWith({
    int? id,
    int? priceListId,
    int? unitTypeId,
    int? pricePerNight,
    int? dayUsePrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UnitPrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'unitTypeId': unitTypeId,
      if (pricePerNight != null) 'pricePerNight': pricePerNight,
      if (dayUsePrice != null) 'dayUsePrice': dayUsePrice,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UnitPrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'unitTypeId': unitTypeId,
      if (pricePerNight != null) 'pricePerNight': pricePerNight,
      if (dayUsePrice != null) 'dayUsePrice': dayUsePrice,
    };
  }

  static UnitPriceInclude include() {
    return UnitPriceInclude._();
  }

  static UnitPriceIncludeList includeList({
    _is.WhereExpressionBuilder<UnitPriceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UnitPriceTable>? orderBy,
    _is.OrderByListBuilder<UnitPriceTable>? orderByList,
    UnitPriceInclude? include,
  }) {
    return UnitPriceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UnitPrice.t),
      orderByList: orderByList?.call(UnitPrice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UnitPriceImpl extends UnitPrice {
  _UnitPriceImpl({
    int? id,
    required int priceListId,
    required int unitTypeId,
    int? pricePerNight,
    int? dayUsePrice,
  }) : super._(
         id: id,
         priceListId: priceListId,
         unitTypeId: unitTypeId,
         pricePerNight: pricePerNight,
         dayUsePrice: dayUsePrice,
       );

  /// Returns a shallow copy of this [UnitPrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UnitPrice copyWith({
    Object? id = _Undefined,
    int? priceListId,
    int? unitTypeId,
    Object? pricePerNight = _Undefined,
    Object? dayUsePrice = _Undefined,
  }) {
    return UnitPrice(
      id: id is int? ? id : this.id,
      priceListId: priceListId ?? this.priceListId,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      pricePerNight: pricePerNight is int? ? pricePerNight : this.pricePerNight,
      dayUsePrice: dayUsePrice is int? ? dayUsePrice : this.dayUsePrice,
    );
  }
}

class UnitPriceUpdateTable extends _is.UpdateTable<UnitPriceTable> {
  UnitPriceUpdateTable(super.table);

  _is.ColumnValue<int, int> priceListId(int value) => _is.ColumnValue(
    table.priceListId,
    value,
  );

  _is.ColumnValue<int, int> unitTypeId(int value) => _is.ColumnValue(
    table.unitTypeId,
    value,
  );

  _is.ColumnValue<int, int> pricePerNight(int? value) => _is.ColumnValue(
    table.pricePerNight,
    value,
  );

  _is.ColumnValue<int, int> dayUsePrice(int? value) => _is.ColumnValue(
    table.dayUsePrice,
    value,
  );
}

class UnitPriceTable extends _is.Table<int?> {
  UnitPriceTable({super.tableRelation}) : super(tableName: 'unit_prices') {
    updateTable = UnitPriceUpdateTable(this);
    priceListId = _is.ColumnInt(
      'priceListId',
      this,
    );
    unitTypeId = _is.ColumnInt(
      'unitTypeId',
      this,
    );
    pricePerNight = _is.ColumnInt(
      'pricePerNight',
      this,
    );
    dayUsePrice = _is.ColumnInt(
      'dayUsePrice',
      this,
    );
  }

  late final UnitPriceUpdateTable updateTable;

  late final _is.ColumnInt priceListId;

  late final _is.ColumnInt unitTypeId;

  /// Null if the unit itself costs nothing and only its guests pay.
  late final _is.ColumnInt pricePerNight;

  /// What a booking that arrives and departs on the same day pays.
  late final _is.ColumnInt dayUsePrice;

  @override
  List<_is.Column> get columns => [
    id,
    priceListId,
    unitTypeId,
    pricePerNight,
    dayUsePrice,
  ];
}

class UnitPriceInclude extends _is.IncludeObject {
  UnitPriceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UnitPrice.t;
}

class UnitPriceIncludeList extends _is.IncludeList {
  UnitPriceIncludeList._({
    _is.WhereExpressionBuilder<UnitPriceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UnitPrice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UnitPrice.t;
}

class UnitPriceRepository {
  const UnitPriceRepository._();

  /// Returns a list of [UnitPrice]s matching the given query parameters.
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
  Future<List<UnitPrice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UnitPriceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UnitPriceTable>? orderBy,
    _is.OrderByListBuilder<UnitPriceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UnitPrice>(
      where: where?.call(UnitPrice.t),
      orderBy: orderBy?.call(UnitPrice.t),
      orderByList: orderByList?.call(UnitPrice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UnitPrice] matching the given query parameters.
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
  Future<UnitPrice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UnitPriceTable>? where,
    int? offset,
    _is.OrderByBuilder<UnitPriceTable>? orderBy,
    _is.OrderByListBuilder<UnitPriceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UnitPrice>(
      where: where?.call(UnitPrice.t),
      orderBy: orderBy?.call(UnitPrice.t),
      orderByList: orderByList?.call(UnitPrice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UnitPrice] by its [id] or null if no such row exists.
  Future<UnitPrice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UnitPrice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UnitPrice]s in the list and returns the inserted rows.
  ///
  /// The returned [UnitPrice]s will have their `id` fields set.
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
  Future<List<UnitPrice>> insert(
    _is.DatabaseSession session,
    List<UnitPrice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UnitPrice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UnitPrice] and returns the inserted row.
  ///
  /// The returned [UnitPrice] will have its `id` field set.
  Future<UnitPrice> insertRow(
    _is.DatabaseSession session,
    UnitPrice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UnitPrice>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UnitPrice]s in the list and returns the resulting rows.
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
  /// The returned [UnitPrice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UnitPrice>> upsert(
    _is.DatabaseSession session,
    List<UnitPrice> rows, {
    required _is.ColumnSelections<UnitPriceTable> conflictColumns,
    _is.ColumnSelections<UnitPriceTable>? updateColumns,
    _is.WhereExpressionBuilder<UnitPriceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UnitPrice>(
      rows,
      conflictColumns: conflictColumns(UnitPrice.t),
      updateColumns: updateColumns?.call(UnitPrice.t),
      updateWhere: updateWhere?.call(UnitPrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UnitPrice] and returns the resulting row.
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
  /// The returned [UnitPrice] will have its `id` field set.
  Future<UnitPrice?> upsertRow(
    _is.DatabaseSession session,
    UnitPrice row, {
    required _is.ColumnSelections<UnitPriceTable> conflictColumns,
    _is.ColumnSelections<UnitPriceTable>? updateColumns,
    _is.WhereExpressionBuilder<UnitPriceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UnitPrice>(
      row,
      conflictColumns: conflictColumns(UnitPrice.t),
      updateColumns: updateColumns?.call(UnitPrice.t),
      updateWhere: updateWhere?.call(UnitPrice.t),
      transaction: transaction,
    );
  }

  /// Updates all [UnitPrice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UnitPrice>> update(
    _is.DatabaseSession session,
    List<UnitPrice> rows, {
    _is.ColumnSelections<UnitPriceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UnitPrice>(
      rows,
      columns: columns?.call(UnitPrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UnitPrice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UnitPrice> updateRow(
    _is.DatabaseSession session,
    UnitPrice row, {
    _is.ColumnSelections<UnitPriceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UnitPrice>(
      row,
      columns: columns?.call(UnitPrice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UnitPrice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UnitPrice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UnitPriceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UnitPrice>(
      id,
      columnValues: columnValues(UnitPrice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UnitPrice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UnitPrice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UnitPriceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UnitPriceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UnitPriceTable>? orderBy,
    _is.OrderByListBuilder<UnitPriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UnitPrice>(
      columnValues: columnValues(UnitPrice.t.updateTable),
      where: where(UnitPrice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UnitPrice.t),
      orderByList: orderByList?.call(UnitPrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UnitPrice]s in the list and returns the deleted rows.
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
  Future<List<UnitPrice>> delete(
    _is.DatabaseSession session,
    List<UnitPrice> rows, {
    _is.OrderByBuilder<UnitPriceTable>? orderBy,
    _is.OrderByListBuilder<UnitPriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UnitPrice>(
      rows,
      orderBy: orderBy?.call(UnitPrice.t),
      orderByList: orderByList?.call(UnitPrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UnitPrice].
  Future<UnitPrice> deleteRow(
    _is.DatabaseSession session,
    UnitPrice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UnitPrice>(
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
  Future<List<UnitPrice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UnitPriceTable> where,
    _is.OrderByBuilder<UnitPriceTable>? orderBy,
    _is.OrderByListBuilder<UnitPriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UnitPrice>(
      where: where(UnitPrice.t),
      orderBy: orderBy?.call(UnitPrice.t),
      orderByList: orderByList?.call(UnitPrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UnitPriceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UnitPrice>(
      where: where?.call(UnitPrice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UnitPrice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UnitPriceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UnitPrice>(
      where: where(UnitPrice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
