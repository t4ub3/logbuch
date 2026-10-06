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
import '../pricing/fee_unit.dart' as _ivlcb7ri;

abstract class Fee implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Fee._({
    this.id,
    required this.name,
    required this.amount,
    required this.unit,
    this.ageGroupId,
    int? taxRate,
    bool? autoApply,
  }) : taxRate = taxRate ?? 0,
       autoApply = autoApply ?? false;

  factory Fee({
    int? id,
    required String name,
    required int amount,
    required _ivlcb7ri.FeeUnit unit,
    int? ageGroupId,
    int? taxRate,
    bool? autoApply,
  }) = _FeeImpl;

  factory Fee.fromJson(Map<String, dynamic> jsonSerialization) {
    return Fee(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      amount: jsonSerialization['amount'] as int,
      unit: _ivlcb7ri.FeeUnit.fromJson((jsonSerialization['unit'] as String)),
      ageGroupId: jsonSerialization['ageGroupId'] as int?,
      taxRate: jsonSerialization['taxRate'] as int?,
      autoApply: jsonSerialization['autoApply'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['autoApply']),
    );
  }

  static final t = FeeTable();

  static const db = FeeRepository._();

  @override
  int? id;

  String name;

  int amount;

  _ivlcb7ri.FeeUnit unit;

  int? ageGroupId;

  int taxRate;

  bool autoApply;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Fee]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Fee copyWith({
    int? id,
    String? name,
    int? amount,
    _ivlcb7ri.FeeUnit? unit,
    int? ageGroupId,
    int? taxRate,
    bool? autoApply,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Fee',
      if (id != null) 'id': id,
      'name': name,
      'amount': amount,
      'unit': unit.toJson(),
      if (ageGroupId != null) 'ageGroupId': ageGroupId,
      'taxRate': taxRate,
      'autoApply': autoApply,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Fee',
      if (id != null) 'id': id,
      'name': name,
      'amount': amount,
      'unit': unit.toJson(),
      if (ageGroupId != null) 'ageGroupId': ageGroupId,
      'taxRate': taxRate,
      'autoApply': autoApply,
    };
  }

  static FeeInclude include() {
    return FeeInclude._();
  }

  static FeeIncludeList includeList({
    _is.WhereExpressionBuilder<FeeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeeTable>? orderBy,
    _is.OrderByListBuilder<FeeTable>? orderByList,
    FeeInclude? include,
  }) {
    return FeeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Fee.t),
      orderByList: orderByList?.call(Fee.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeeImpl extends Fee {
  _FeeImpl({
    int? id,
    required String name,
    required int amount,
    required _ivlcb7ri.FeeUnit unit,
    int? ageGroupId,
    int? taxRate,
    bool? autoApply,
  }) : super._(
         id: id,
         name: name,
         amount: amount,
         unit: unit,
         ageGroupId: ageGroupId,
         taxRate: taxRate,
         autoApply: autoApply,
       );

  /// Returns a shallow copy of this [Fee]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Fee copyWith({
    Object? id = _Undefined,
    String? name,
    int? amount,
    _ivlcb7ri.FeeUnit? unit,
    Object? ageGroupId = _Undefined,
    int? taxRate,
    bool? autoApply,
  }) {
    return Fee(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      ageGroupId: ageGroupId is int? ? ageGroupId : this.ageGroupId,
      taxRate: taxRate ?? this.taxRate,
      autoApply: autoApply ?? this.autoApply,
    );
  }
}

class FeeUpdateTable extends _is.UpdateTable<FeeTable> {
  FeeUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<_ivlcb7ri.FeeUnit, _ivlcb7ri.FeeUnit> unit(
    _ivlcb7ri.FeeUnit value,
  ) => _is.ColumnValue(
    table.unit,
    value,
  );

  _is.ColumnValue<int, int> ageGroupId(int? value) => _is.ColumnValue(
    table.ageGroupId,
    value,
  );

  _is.ColumnValue<int, int> taxRate(int value) => _is.ColumnValue(
    table.taxRate,
    value,
  );

  _is.ColumnValue<bool, bool> autoApply(bool value) => _is.ColumnValue(
    table.autoApply,
    value,
  );
}

class FeeTable extends _is.Table<int?> {
  FeeTable({super.tableRelation}) : super(tableName: 'fees') {
    updateTable = FeeUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
    );
    unit = _is.ColumnEnum(
      'unit',
      this,
      _is.EnumSerialization.byName,
    );
    ageGroupId = _is.ColumnInt(
      'ageGroupId',
      this,
    );
    taxRate = _is.ColumnInt(
      'taxRate',
      this,
      hasDefault: true,
    );
    autoApply = _is.ColumnBool(
      'autoApply',
      this,
      hasDefault: true,
    );
  }

  late final FeeUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt amount;

  late final _is.ColumnEnum<_ivlcb7ri.FeeUnit> unit;

  late final _is.ColumnInt ageGroupId;

  late final _is.ColumnInt taxRate;

  late final _is.ColumnBool autoApply;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    amount,
    unit,
    ageGroupId,
    taxRate,
    autoApply,
  ];
}

class FeeInclude extends _is.IncludeObject {
  FeeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Fee.t;
}

class FeeIncludeList extends _is.IncludeList {
  FeeIncludeList._({
    _is.WhereExpressionBuilder<FeeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Fee.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Fee.t;
}

class FeeRepository {
  const FeeRepository._();

  /// Returns a list of [Fee]s matching the given query parameters.
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
  Future<List<Fee>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeeTable>? orderBy,
    _is.OrderByListBuilder<FeeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Fee>(
      where: where?.call(Fee.t),
      orderBy: orderBy?.call(Fee.t),
      orderByList: orderByList?.call(Fee.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Fee] matching the given query parameters.
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
  Future<Fee?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeeTable>? where,
    int? offset,
    _is.OrderByBuilder<FeeTable>? orderBy,
    _is.OrderByListBuilder<FeeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Fee>(
      where: where?.call(Fee.t),
      orderBy: orderBy?.call(Fee.t),
      orderByList: orderByList?.call(Fee.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Fee] by its [id] or null if no such row exists.
  Future<Fee?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Fee>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Fee]s in the list and returns the inserted rows.
  ///
  /// The returned [Fee]s will have their `id` fields set.
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
  Future<List<Fee>> insert(
    _is.DatabaseSession session,
    List<Fee> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Fee>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Fee] and returns the inserted row.
  ///
  /// The returned [Fee] will have its `id` field set.
  Future<Fee> insertRow(
    _is.DatabaseSession session,
    Fee row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Fee>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Fee]s in the list and returns the resulting rows.
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
  /// The returned [Fee]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Fee>> upsert(
    _is.DatabaseSession session,
    List<Fee> rows, {
    required _is.ColumnSelections<FeeTable> conflictColumns,
    _is.ColumnSelections<FeeTable>? updateColumns,
    _is.WhereExpressionBuilder<FeeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Fee>(
      rows,
      conflictColumns: conflictColumns(Fee.t),
      updateColumns: updateColumns?.call(Fee.t),
      updateWhere: updateWhere?.call(Fee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Fee] and returns the resulting row.
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
  /// The returned [Fee] will have its `id` field set.
  Future<Fee?> upsertRow(
    _is.DatabaseSession session,
    Fee row, {
    required _is.ColumnSelections<FeeTable> conflictColumns,
    _is.ColumnSelections<FeeTable>? updateColumns,
    _is.WhereExpressionBuilder<FeeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Fee>(
      row,
      conflictColumns: conflictColumns(Fee.t),
      updateColumns: updateColumns?.call(Fee.t),
      updateWhere: updateWhere?.call(Fee.t),
      transaction: transaction,
    );
  }

  /// Updates all [Fee]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Fee>> update(
    _is.DatabaseSession session,
    List<Fee> rows, {
    _is.ColumnSelections<FeeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Fee>(
      rows,
      columns: columns?.call(Fee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Fee]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Fee> updateRow(
    _is.DatabaseSession session,
    Fee row, {
    _is.ColumnSelections<FeeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Fee>(
      row,
      columns: columns?.call(Fee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Fee] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Fee?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Fee>(
      id,
      columnValues: columnValues(Fee.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Fee]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Fee>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FeeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeeTable>? orderBy,
    _is.OrderByListBuilder<FeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Fee>(
      columnValues: columnValues(Fee.t.updateTable),
      where: where(Fee.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Fee.t),
      orderByList: orderByList?.call(Fee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Fee]s in the list and returns the deleted rows.
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
  Future<List<Fee>> delete(
    _is.DatabaseSession session,
    List<Fee> rows, {
    _is.OrderByBuilder<FeeTable>? orderBy,
    _is.OrderByListBuilder<FeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Fee>(
      rows,
      orderBy: orderBy?.call(Fee.t),
      orderByList: orderByList?.call(Fee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Fee].
  Future<Fee> deleteRow(
    _is.DatabaseSession session,
    Fee row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Fee>(
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
  Future<List<Fee>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeeTable> where,
    _is.OrderByBuilder<FeeTable>? orderBy,
    _is.OrderByListBuilder<FeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Fee>(
      where: where(Fee.t),
      orderBy: orderBy?.call(Fee.t),
      orderByList: orderByList?.call(Fee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Fee>(
      where: where?.call(Fee.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Fee] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Fee>(
      where: where(Fee.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
