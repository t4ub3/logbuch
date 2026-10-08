/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../pricing/fee.dart' as _iudlpryb;
import '../rooms/room.dart' as _ij8xg2ak;

/// A surcharge that a room has.
abstract class RoomFee
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RoomFee._({
    this.id,
    required this.roomId,
    this.room,
    required this.feeId,
    this.fee,
  });

  factory RoomFee({
    int? id,
    required int roomId,
    _ij8xg2ak.Room? room,
    required int feeId,
    _iudlpryb.Fee? fee,
  }) = _RoomFeeImpl;

  factory RoomFee.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomFee(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_ij8xg2ak.Room>(
              jsonSerialization['room'],
            ),
      feeId: jsonSerialization['feeId'] as int,
      fee: jsonSerialization['fee'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_iudlpryb.Fee>(
              jsonSerialization['fee'],
            ),
    );
  }

  static final t = RoomFeeTable();

  static const db = RoomFeeRepository._();

  @override
  int? id;

  int roomId;

  _ij8xg2ak.Room? room;

  int feeId;

  _iudlpryb.Fee? fee;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomFee]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomFee copyWith({
    int? id,
    int? roomId,
    _ij8xg2ak.Room? room,
    int? feeId,
    _iudlpryb.Fee? fee,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomFee',
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'feeId': feeId,
      if (fee != null) 'fee': fee?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomFee',
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
      'feeId': feeId,
      if (fee != null) 'fee': fee?.toJsonForProtocol(),
    };
  }

  static RoomFeeInclude include({
    _ij8xg2ak.RoomInclude? room,
    _iudlpryb.FeeInclude? fee,
  }) {
    return RoomFeeInclude._(
      room: room,
      fee: fee,
    );
  }

  static RoomFeeIncludeList includeList({
    _is.WhereExpressionBuilder<RoomFeeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomFeeTable>? orderBy,
    _is.OrderByListBuilder<RoomFeeTable>? orderByList,
    RoomFeeInclude? include,
  }) {
    return RoomFeeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomFee.t),
      orderByList: orderByList?.call(RoomFee.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomFeeImpl extends RoomFee {
  _RoomFeeImpl({
    int? id,
    required int roomId,
    _ij8xg2ak.Room? room,
    required int feeId,
    _iudlpryb.Fee? fee,
  }) : super._(
         id: id,
         roomId: roomId,
         room: room,
         feeId: feeId,
         fee: fee,
       );

  /// Returns a shallow copy of this [RoomFee]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomFee copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    int? feeId,
    Object? fee = _Undefined,
  }) {
    return RoomFee(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _ij8xg2ak.Room? ? room : this.room?.copyWith(),
      feeId: feeId ?? this.feeId,
      fee: fee is _iudlpryb.Fee? ? fee : this.fee?.copyWith(),
    );
  }
}

class RoomFeeUpdateTable extends _is.UpdateTable<RoomFeeTable> {
  RoomFeeUpdateTable(super.table);

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<int, int> feeId(int value) => _is.ColumnValue(
    table.feeId,
    value,
  );
}

class RoomFeeTable extends _is.Table<int?> {
  RoomFeeTable({super.tableRelation}) : super(tableName: 'room_fees') {
    updateTable = RoomFeeUpdateTable(this);
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    feeId = _is.ColumnInt(
      'feeId',
      this,
    );
  }

  late final RoomFeeUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  _ij8xg2ak.RoomTable? _room;

  late final _is.ColumnInt feeId;

  _iudlpryb.FeeTable? _fee;

  _ij8xg2ak.RoomTable get room {
    if (_room != null) return _room!;
    _room = _is.createRelationTable(
      relationFieldName: 'room',
      field: RoomFee.t.roomId,
      foreignField: _ij8xg2ak.Room.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ij8xg2ak.RoomTable(tableRelation: foreignTableRelation),
    );
    return _room!;
  }

  _iudlpryb.FeeTable get fee {
    if (_fee != null) return _fee!;
    _fee = _is.createRelationTable(
      relationFieldName: 'fee',
      field: RoomFee.t.feeId,
      foreignField: _iudlpryb.Fee.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iudlpryb.FeeTable(tableRelation: foreignTableRelation),
    );
    return _fee!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    feeId,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'room') {
      return room;
    }
    if (relationField == 'fee') {
      return fee;
    }
    return null;
  }
}

class RoomFeeInclude extends _is.IncludeObject {
  RoomFeeInclude._({
    _ij8xg2ak.RoomInclude? room,
    _iudlpryb.FeeInclude? fee,
  }) {
    _room = room;
    _fee = fee;
  }

  _ij8xg2ak.RoomInclude? _room;

  _iudlpryb.FeeInclude? _fee;

  @override
  Map<String, _is.Include?> get includes => {
    'room': _room,
    'fee': _fee,
  };

  @override
  _is.Table<int?> get table => RoomFee.t;
}

class RoomFeeIncludeList extends _is.IncludeList {
  RoomFeeIncludeList._({
    _is.WhereExpressionBuilder<RoomFeeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomFee.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RoomFee.t;
}

class RoomFeeRepository {
  const RoomFeeRepository._();

  final attachRow = const RoomFeeAttachRowRepository._();

  /// Returns a list of [RoomFee]s matching the given query parameters.
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
  Future<List<RoomFee>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomFeeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomFeeTable>? orderBy,
    _is.OrderByListBuilder<RoomFeeTable>? orderByList,
    _is.Transaction? transaction,
    RoomFeeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomFee>(
      where: where?.call(RoomFee.t),
      orderBy: orderBy?.call(RoomFee.t),
      orderByList: orderByList?.call(RoomFee.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomFee] matching the given query parameters.
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
  Future<RoomFee?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomFeeTable>? where,
    int? offset,
    _is.OrderByBuilder<RoomFeeTable>? orderBy,
    _is.OrderByListBuilder<RoomFeeTable>? orderByList,
    _is.Transaction? transaction,
    RoomFeeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomFee>(
      where: where?.call(RoomFee.t),
      orderBy: orderBy?.call(RoomFee.t),
      orderByList: orderByList?.call(RoomFee.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomFee] by its [id] or null if no such row exists.
  Future<RoomFee?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    RoomFeeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomFee>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomFee]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomFee]s will have their `id` fields set.
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
  Future<List<RoomFee>> insert(
    _is.DatabaseSession session,
    List<RoomFee> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RoomFee>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RoomFee] and returns the inserted row.
  ///
  /// The returned [RoomFee] will have its `id` field set.
  Future<RoomFee> insertRow(
    _is.DatabaseSession session,
    RoomFee row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomFee>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RoomFee]s in the list and returns the resulting rows.
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
  /// The returned [RoomFee]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomFee>> upsert(
    _is.DatabaseSession session,
    List<RoomFee> rows, {
    required _is.ColumnSelections<RoomFeeTable> conflictColumns,
    _is.ColumnSelections<RoomFeeTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomFeeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RoomFee>(
      rows,
      conflictColumns: conflictColumns(RoomFee.t),
      updateColumns: updateColumns?.call(RoomFee.t),
      updateWhere: updateWhere?.call(RoomFee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RoomFee] and returns the resulting row.
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
  /// The returned [RoomFee] will have its `id` field set.
  Future<RoomFee?> upsertRow(
    _is.DatabaseSession session,
    RoomFee row, {
    required _is.ColumnSelections<RoomFeeTable> conflictColumns,
    _is.ColumnSelections<RoomFeeTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomFeeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RoomFee>(
      row,
      conflictColumns: conflictColumns(RoomFee.t),
      updateColumns: updateColumns?.call(RoomFee.t),
      updateWhere: updateWhere?.call(RoomFee.t),
      transaction: transaction,
    );
  }

  /// Updates all [RoomFee]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomFee>> update(
    _is.DatabaseSession session,
    List<RoomFee> rows, {
    _is.ColumnSelections<RoomFeeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RoomFee>(
      rows,
      columns: columns?.call(RoomFee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RoomFee]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomFee> updateRow(
    _is.DatabaseSession session,
    RoomFee row, {
    _is.ColumnSelections<RoomFeeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomFee>(
      row,
      columns: columns?.call(RoomFee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomFee] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomFee?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoomFeeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomFee>(
      id,
      columnValues: columnValues(RoomFee.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomFee]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomFee>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoomFeeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoomFeeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomFeeTable>? orderBy,
    _is.OrderByListBuilder<RoomFeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RoomFee>(
      columnValues: columnValues(RoomFee.t.updateTable),
      where: where(RoomFee.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomFee.t),
      orderByList: orderByList?.call(RoomFee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RoomFee]s in the list and returns the deleted rows.
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
  Future<List<RoomFee>> delete(
    _is.DatabaseSession session,
    List<RoomFee> rows, {
    _is.OrderByBuilder<RoomFeeTable>? orderBy,
    _is.OrderByListBuilder<RoomFeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RoomFee>(
      rows,
      orderBy: orderBy?.call(RoomFee.t),
      orderByList: orderByList?.call(RoomFee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RoomFee].
  Future<RoomFee> deleteRow(
    _is.DatabaseSession session,
    RoomFee row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomFee>(
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
  Future<List<RoomFee>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomFeeTable> where,
    _is.OrderByBuilder<RoomFeeTable>? orderBy,
    _is.OrderByListBuilder<RoomFeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RoomFee>(
      where: where(RoomFee.t),
      orderBy: orderBy?.call(RoomFee.t),
      orderByList: orderByList?.call(RoomFee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomFeeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RoomFee>(
      where: where?.call(RoomFee.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomFee] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomFeeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomFee>(
      where: where(RoomFee.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RoomFeeAttachRowRepository {
  const RoomFeeAttachRowRepository._();

  /// Creates a relation between the given [RoomFee] and [Room]
  /// by setting the [RoomFee]'s foreign key `roomId` to refer to the [Room].
  Future<void> room(
    _is.DatabaseSession session,
    RoomFee roomFee,
    _ij8xg2ak.Room room, {
    _is.Transaction? transaction,
  }) async {
    if (roomFee.id == null) {
      throw ArgumentError.notNull('roomFee.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $roomFee = roomFee.copyWith(roomId: room.id);
    await session.db.updateRow<RoomFee>(
      $roomFee,
      columns: [RoomFee.t.roomId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RoomFee] and [Fee]
  /// by setting the [RoomFee]'s foreign key `feeId` to refer to the [Fee].
  Future<void> fee(
    _is.DatabaseSession session,
    RoomFee roomFee,
    _iudlpryb.Fee fee, {
    _is.Transaction? transaction,
  }) async {
    if (roomFee.id == null) {
      throw ArgumentError.notNull('roomFee.id');
    }
    if (fee.id == null) {
      throw ArgumentError.notNull('fee.id');
    }

    var $roomFee = roomFee.copyWith(feeId: fee.id);
    await session.db.updateRow<RoomFee>(
      $roomFee,
      columns: [RoomFee.t.feeId],
      transaction: transaction,
    );
  }
}
