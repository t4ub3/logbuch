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

/// What a fee costs by a price list.
abstract class FeePrice
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeePrice._({
    this.id,
    required this.priceListId,
    required this.feeId,
    required this.amount,
  });

  factory FeePrice({
    int? id,
    required int priceListId,
    required int feeId,
    required int amount,
  }) = _FeePriceImpl;

  factory FeePrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeePrice(
      id: jsonSerialization['id'] as int?,
      priceListId: jsonSerialization['priceListId'] as int,
      feeId: jsonSerialization['feeId'] as int,
      amount: jsonSerialization['amount'] as int,
    );
  }

  static final t = FeePriceTable();

  static const db = FeePriceRepository._();

  @override
  int? id;

  int priceListId;

  int feeId;

  int amount;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeePrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeePrice copyWith({
    int? id,
    int? priceListId,
    int? feeId,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeePrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'feeId': feeId,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeePrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'feeId': feeId,
      'amount': amount,
    };
  }

  static FeePriceInclude include() {
    return FeePriceInclude._();
  }

  static FeePriceIncludeList includeList({
    _is.WhereExpressionBuilder<FeePriceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeePriceTable>? orderBy,
    _is.OrderByListBuilder<FeePriceTable>? orderByList,
    FeePriceInclude? include,
  }) {
    return FeePriceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeePrice.t),
      orderByList: orderByList?.call(FeePrice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeePriceImpl extends FeePrice {
  _FeePriceImpl({
    int? id,
    required int priceListId,
    required int feeId,
    required int amount,
  }) : super._(
         id: id,
         priceListId: priceListId,
         feeId: feeId,
         amount: amount,
       );

  /// Returns a shallow copy of this [FeePrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeePrice copyWith({
    Object? id = _Undefined,
    int? priceListId,
    int? feeId,
    int? amount,
  }) {
    return FeePrice(
      id: id is int? ? id : this.id,
      priceListId: priceListId ?? this.priceListId,
      feeId: feeId ?? this.feeId,
      amount: amount ?? this.amount,
    );
  }
}

class FeePriceUpdateTable extends _is.UpdateTable<FeePriceTable> {
  FeePriceUpdateTable(super.table);

  _is.ColumnValue<int, int> priceListId(int value) => _is.ColumnValue(
    table.priceListId,
    value,
  );

  _is.ColumnValue<int, int> feeId(int value) => _is.ColumnValue(
    table.feeId,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );
}

class FeePriceTable extends _is.Table<int?> {
  FeePriceTable({super.tableRelation}) : super(tableName: 'fee_prices') {
    updateTable = FeePriceUpdateTable(this);
    priceListId = _is.ColumnInt(
      'priceListId',
      this,
    );
    feeId = _is.ColumnInt(
      'feeId',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
    );
  }

  late final FeePriceUpdateTable updateTable;

  late final _is.ColumnInt priceListId;

  late final _is.ColumnInt feeId;

  late final _is.ColumnInt amount;

  @override
  List<_is.Column> get columns => [
    id,
    priceListId,
    feeId,
    amount,
  ];
}

class FeePriceInclude extends _is.IncludeObject {
  FeePriceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FeePrice.t;
}

class FeePriceIncludeList extends _is.IncludeList {
  FeePriceIncludeList._({
    _is.WhereExpressionBuilder<FeePriceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeePrice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeePrice.t;
}

class FeePriceRepository {
  const FeePriceRepository._();

  /// Returns a list of [FeePrice]s matching the given query parameters.
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
  Future<List<FeePrice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeePriceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeePriceTable>? orderBy,
    _is.OrderByListBuilder<FeePriceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeePrice>(
      where: where?.call(FeePrice.t),
      orderBy: orderBy?.call(FeePrice.t),
      orderByList: orderByList?.call(FeePrice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeePrice] matching the given query parameters.
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
  Future<FeePrice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeePriceTable>? where,
    int? offset,
    _is.OrderByBuilder<FeePriceTable>? orderBy,
    _is.OrderByListBuilder<FeePriceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeePrice>(
      where: where?.call(FeePrice.t),
      orderBy: orderBy?.call(FeePrice.t),
      orderByList: orderByList?.call(FeePrice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeePrice] by its [id] or null if no such row exists.
  Future<FeePrice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeePrice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeePrice]s in the list and returns the inserted rows.
  ///
  /// The returned [FeePrice]s will have their `id` fields set.
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
  Future<List<FeePrice>> insert(
    _is.DatabaseSession session,
    List<FeePrice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeePrice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeePrice] and returns the inserted row.
  ///
  /// The returned [FeePrice] will have its `id` field set.
  Future<FeePrice> insertRow(
    _is.DatabaseSession session,
    FeePrice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeePrice>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeePrice]s in the list and returns the resulting rows.
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
  /// The returned [FeePrice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeePrice>> upsert(
    _is.DatabaseSession session,
    List<FeePrice> rows, {
    required _is.ColumnSelections<FeePriceTable> conflictColumns,
    _is.ColumnSelections<FeePriceTable>? updateColumns,
    _is.WhereExpressionBuilder<FeePriceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeePrice>(
      rows,
      conflictColumns: conflictColumns(FeePrice.t),
      updateColumns: updateColumns?.call(FeePrice.t),
      updateWhere: updateWhere?.call(FeePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeePrice] and returns the resulting row.
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
  /// The returned [FeePrice] will have its `id` field set.
  Future<FeePrice?> upsertRow(
    _is.DatabaseSession session,
    FeePrice row, {
    required _is.ColumnSelections<FeePriceTable> conflictColumns,
    _is.ColumnSelections<FeePriceTable>? updateColumns,
    _is.WhereExpressionBuilder<FeePriceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeePrice>(
      row,
      conflictColumns: conflictColumns(FeePrice.t),
      updateColumns: updateColumns?.call(FeePrice.t),
      updateWhere: updateWhere?.call(FeePrice.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeePrice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeePrice>> update(
    _is.DatabaseSession session,
    List<FeePrice> rows, {
    _is.ColumnSelections<FeePriceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeePrice>(
      rows,
      columns: columns?.call(FeePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeePrice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeePrice> updateRow(
    _is.DatabaseSession session,
    FeePrice row, {
    _is.ColumnSelections<FeePriceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeePrice>(
      row,
      columns: columns?.call(FeePrice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeePrice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeePrice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeePriceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeePrice>(
      id,
      columnValues: columnValues(FeePrice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeePrice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeePrice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeePriceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FeePriceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeePriceTable>? orderBy,
    _is.OrderByListBuilder<FeePriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeePrice>(
      columnValues: columnValues(FeePrice.t.updateTable),
      where: where(FeePrice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeePrice.t),
      orderByList: orderByList?.call(FeePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeePrice]s in the list and returns the deleted rows.
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
  Future<List<FeePrice>> delete(
    _is.DatabaseSession session,
    List<FeePrice> rows, {
    _is.OrderByBuilder<FeePriceTable>? orderBy,
    _is.OrderByListBuilder<FeePriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeePrice>(
      rows,
      orderBy: orderBy?.call(FeePrice.t),
      orderByList: orderByList?.call(FeePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeePrice].
  Future<FeePrice> deleteRow(
    _is.DatabaseSession session,
    FeePrice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeePrice>(
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
  Future<List<FeePrice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeePriceTable> where,
    _is.OrderByBuilder<FeePriceTable>? orderBy,
    _is.OrderByListBuilder<FeePriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeePrice>(
      where: where(FeePrice.t),
      orderBy: orderBy?.call(FeePrice.t),
      orderByList: orderByList?.call(FeePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeePriceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeePrice>(
      where: where?.call(FeePrice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeePrice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeePriceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeePrice>(
      where: where(FeePrice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
