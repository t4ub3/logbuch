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
import '../pricing/unit_type.dart' as _iwfco3zw;
import '../rooms/building.dart' as _ig4w4s7q;
import '../rooms/room_fee.dart' as _iv47he65;

/// A room, or a house that is booked as a whole, such as a bungalow.
abstract class Room implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Room._({
    this.id,
    required this.roomNumber,
    required this.bedAmount,
    this.buildingId,
    this.building,
    this.floor,
    required this.unitTypeId,
    this.unitType,
    bool? cribPossible,
    bool? active,
    this.notes,
    this.fees,
  }) : cribPossible = cribPossible ?? false,
       active = active ?? true;

  factory Room({
    int? id,
    required String roomNumber,
    required int bedAmount,
    int? buildingId,
    _ig4w4s7q.Building? building,
    String? floor,
    required int unitTypeId,
    _iwfco3zw.UnitType? unitType,
    bool? cribPossible,
    bool? active,
    String? notes,
    List<_iv47he65.RoomFee>? fees,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      roomNumber: jsonSerialization['roomNumber'] as String,
      bedAmount: jsonSerialization['bedAmount'] as int,
      buildingId: jsonSerialization['buildingId'] as int?,
      building: jsonSerialization['building'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_ig4w4s7q.Building>(
              jsonSerialization['building'],
            ),
      floor: jsonSerialization['floor'] as String?,
      unitTypeId: jsonSerialization['unitTypeId'] as int,
      unitType: jsonSerialization['unitType'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_iwfco3zw.UnitType>(
              jsonSerialization['unitType'],
            ),
      cribPossible: jsonSerialization['cribPossible'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['cribPossible']),
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      notes: jsonSerialization['notes'] as String?,
      fees: jsonSerialization['fees'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_iv47he65.RoomFee>>(
              jsonSerialization['fees'],
            ),
    );
  }

  static final t = RoomTable();

  static const db = RoomRepository._();

  @override
  int? id;

  String roomNumber;

  int bedAmount;

  int? buildingId;

  _ig4w4s7q.Building? building;

  String? floor;

  int unitTypeId;

  _iwfco3zw.UnitType? unitType;

  bool cribPossible;

  bool active;

  String? notes;

  /// The surcharges of the room.
  List<_iv47he65.RoomFee>? fees;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Room copyWith({
    int? id,
    String? roomNumber,
    int? bedAmount,
    int? buildingId,
    _ig4w4s7q.Building? building,
    String? floor,
    int? unitTypeId,
    _iwfco3zw.UnitType? unitType,
    bool? cribPossible,
    bool? active,
    String? notes,
    List<_iv47he65.RoomFee>? fees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      'bedAmount': bedAmount,
      if (buildingId != null) 'buildingId': buildingId,
      if (building != null) 'building': building?.toJson(),
      if (floor != null) 'floor': floor,
      'unitTypeId': unitTypeId,
      if (unitType != null) 'unitType': unitType?.toJson(),
      'cribPossible': cribPossible,
      'active': active,
      if (notes != null) 'notes': notes,
      if (fees != null) 'fees': fees?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      'bedAmount': bedAmount,
      if (buildingId != null) 'buildingId': buildingId,
      if (building != null) 'building': building?.toJsonForProtocol(),
      if (floor != null) 'floor': floor,
      'unitTypeId': unitTypeId,
      if (unitType != null) 'unitType': unitType?.toJsonForProtocol(),
      'cribPossible': cribPossible,
      'active': active,
      if (notes != null) 'notes': notes,
      if (fees != null)
        'fees': fees?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static RoomInclude include({
    _ig4w4s7q.BuildingInclude? building,
    _iwfco3zw.UnitTypeInclude? unitType,
    _iv47he65.RoomFeeIncludeList? fees,
  }) {
    return RoomInclude._(
      building: building,
      unitType: unitType,
      fees: fees,
    );
  }

  static RoomIncludeList includeList({
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    RoomInclude? include,
  }) {
    return RoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required String roomNumber,
    required int bedAmount,
    int? buildingId,
    _ig4w4s7q.Building? building,
    String? floor,
    required int unitTypeId,
    _iwfco3zw.UnitType? unitType,
    bool? cribPossible,
    bool? active,
    String? notes,
    List<_iv47he65.RoomFee>? fees,
  }) : super._(
         id: id,
         roomNumber: roomNumber,
         bedAmount: bedAmount,
         buildingId: buildingId,
         building: building,
         floor: floor,
         unitTypeId: unitTypeId,
         unitType: unitType,
         cribPossible: cribPossible,
         active: active,
         notes: notes,
         fees: fees,
       );

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    String? roomNumber,
    int? bedAmount,
    Object? buildingId = _Undefined,
    Object? building = _Undefined,
    Object? floor = _Undefined,
    int? unitTypeId,
    Object? unitType = _Undefined,
    bool? cribPossible,
    bool? active,
    Object? notes = _Undefined,
    Object? fees = _Undefined,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      bedAmount: bedAmount ?? this.bedAmount,
      buildingId: buildingId is int? ? buildingId : this.buildingId,
      building: building is _ig4w4s7q.Building?
          ? building
          : this.building?.copyWith(),
      floor: floor is String? ? floor : this.floor,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      unitType: unitType is _iwfco3zw.UnitType?
          ? unitType
          : this.unitType?.copyWith(),
      cribPossible: cribPossible ?? this.cribPossible,
      active: active ?? this.active,
      notes: notes is String? ? notes : this.notes,
      fees: fees is List<_iv47he65.RoomFee>?
          ? fees
          : this.fees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class RoomUpdateTable extends _is.UpdateTable<RoomTable> {
  RoomUpdateTable(super.table);

  _is.ColumnValue<String, String> roomNumber(String value) => _is.ColumnValue(
    table.roomNumber,
    value,
  );

  _is.ColumnValue<int, int> bedAmount(int value) => _is.ColumnValue(
    table.bedAmount,
    value,
  );

  _is.ColumnValue<int, int> buildingId(int? value) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<String, String> floor(String? value) => _is.ColumnValue(
    table.floor,
    value,
  );

  _is.ColumnValue<int, int> unitTypeId(int value) => _is.ColumnValue(
    table.unitTypeId,
    value,
  );

  _is.ColumnValue<bool, bool> cribPossible(bool value) => _is.ColumnValue(
    table.cribPossible,
    value,
  );

  _is.ColumnValue<bool, bool> active(bool value) => _is.ColumnValue(
    table.active,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );
}

class RoomTable extends _is.Table<int?> {
  RoomTable({super.tableRelation}) : super(tableName: 'rooms') {
    updateTable = RoomUpdateTable(this);
    roomNumber = _is.ColumnString(
      'roomNumber',
      this,
    );
    bedAmount = _is.ColumnInt(
      'bedAmount',
      this,
    );
    buildingId = _is.ColumnInt(
      'buildingId',
      this,
    );
    floor = _is.ColumnString(
      'floor',
      this,
    );
    unitTypeId = _is.ColumnInt(
      'unitTypeId',
      this,
    );
    cribPossible = _is.ColumnBool(
      'cribPossible',
      this,
      hasDefault: true,
    );
    active = _is.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
  }

  late final RoomUpdateTable updateTable;

  late final _is.ColumnString roomNumber;

  late final _is.ColumnInt bedAmount;

  late final _is.ColumnInt buildingId;

  _ig4w4s7q.BuildingTable? _building;

  late final _is.ColumnString floor;

  late final _is.ColumnInt unitTypeId;

  _iwfco3zw.UnitTypeTable? _unitType;

  late final _is.ColumnBool cribPossible;

  late final _is.ColumnBool active;

  late final _is.ColumnString notes;

  /// The surcharges of the room.
  _iv47he65.RoomFeeTable? ___fees;

  /// The surcharges of the room.
  _is.ManyRelation<_iv47he65.RoomFeeTable>? _fees;

  _ig4w4s7q.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: Room.t.buildingId,
      foreignField: _ig4w4s7q.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ig4w4s7q.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _iwfco3zw.UnitTypeTable get unitType {
    if (_unitType != null) return _unitType!;
    _unitType = _is.createRelationTable(
      relationFieldName: 'unitType',
      field: Room.t.unitTypeId,
      foreignField: _iwfco3zw.UnitType.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwfco3zw.UnitTypeTable(tableRelation: foreignTableRelation),
    );
    return _unitType!;
  }

  _iv47he65.RoomFeeTable get __fees {
    if (___fees != null) return ___fees!;
    ___fees = _is.createRelationTable(
      relationFieldName: '__fees',
      field: Room.t.id,
      foreignField: _iv47he65.RoomFee.t.roomId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iv47he65.RoomFeeTable(tableRelation: foreignTableRelation),
    );
    return ___fees!;
  }

  _is.ManyRelation<_iv47he65.RoomFeeTable> get fees {
    if (_fees != null) return _fees!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'fees',
      field: Room.t.id,
      foreignField: _iv47he65.RoomFee.t.roomId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iv47he65.RoomFeeTable(tableRelation: foreignTableRelation),
    );
    _fees = _is.ManyRelation<_iv47he65.RoomFeeTable>(
      tableWithRelations: relationTable,
      table: _iv47he65.RoomFeeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _fees!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    roomNumber,
    bedAmount,
    buildingId,
    floor,
    unitTypeId,
    cribPossible,
    active,
    notes,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'unitType') {
      return unitType;
    }
    if (relationField == 'fees') {
      return __fees;
    }
    return null;
  }
}

class RoomInclude extends _is.IncludeObject {
  RoomInclude._({
    _ig4w4s7q.BuildingInclude? building,
    _iwfco3zw.UnitTypeInclude? unitType,
    _iv47he65.RoomFeeIncludeList? fees,
  }) {
    _building = building;
    _unitType = unitType;
    _fees = fees;
  }

  _ig4w4s7q.BuildingInclude? _building;

  _iwfco3zw.UnitTypeInclude? _unitType;

  _iv47he65.RoomFeeIncludeList? _fees;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'unitType': _unitType,
    'fees': _fees,
  };

  @override
  _is.Table<int?> get table => Room.t;
}

class RoomIncludeList extends _is.IncludeList {
  RoomIncludeList._({
    _is.WhereExpressionBuilder<RoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Room.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Room.t;
}

class RoomRepository {
  const RoomRepository._();

  final attach = const RoomAttachRepository._();

  final attachRow = const RoomAttachRowRepository._();

  final detachRow = const RoomDetachRowRepository._();

  /// Returns a list of [Room]s matching the given query parameters.
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
  Future<List<Room>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    RoomInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Room] matching the given query parameters.
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
  Future<Room?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    RoomInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Room] by its [id] or null if no such row exists.
  Future<Room?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    RoomInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Room>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Room]s in the list and returns the inserted rows.
  ///
  /// The returned [Room]s will have their `id` fields set.
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
  Future<List<Room>> insert(
    _is.DatabaseSession session,
    List<Room> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Room>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Room] and returns the inserted row.
  ///
  /// The returned [Room] will have its `id` field set.
  Future<Room> insertRow(
    _is.DatabaseSession session,
    Room row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Room>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Room]s in the list and returns the resulting rows.
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
  /// The returned [Room]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> upsert(
    _is.DatabaseSession session,
    List<Room> rows, {
    required _is.ColumnSelections<RoomTable> conflictColumns,
    _is.ColumnSelections<RoomTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Room>(
      rows,
      conflictColumns: conflictColumns(Room.t),
      updateColumns: updateColumns?.call(Room.t),
      updateWhere: updateWhere?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Room] and returns the resulting row.
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
  /// The returned [Room] will have its `id` field set.
  Future<Room?> upsertRow(
    _is.DatabaseSession session,
    Room row, {
    required _is.ColumnSelections<RoomTable> conflictColumns,
    _is.ColumnSelections<RoomTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Room>(
      row,
      conflictColumns: conflictColumns(Room.t),
      updateColumns: updateColumns?.call(Room.t),
      updateWhere: updateWhere?.call(Room.t),
      transaction: transaction,
    );
  }

  /// Updates all [Room]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> update(
    _is.DatabaseSession session,
    List<Room> rows, {
    _is.ColumnSelections<RoomTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Room>(
      rows,
      columns: columns?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Room]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Room> updateRow(
    _is.DatabaseSession session,
    Room row, {
    _is.ColumnSelections<RoomTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Room>(
      row,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Room] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Room?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoomUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Room>(
      id,
      columnValues: columnValues(Room.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Room]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoomUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoomTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Room>(
      columnValues: columnValues(Room.t.updateTable),
      where: where(Room.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Room]s in the list and returns the deleted rows.
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
  Future<List<Room>> delete(
    _is.DatabaseSession session,
    List<Room> rows, {
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Room>(
      rows,
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Room].
  Future<Room> deleteRow(
    _is.DatabaseSession session,
    Room row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Room>(
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
  Future<List<Room>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomTable> where,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Room>(
      where: where(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Room>(
      where: where?.call(Room.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Room] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Room>(
      where: where(Room.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RoomAttachRepository {
  const RoomAttachRepository._();

  /// Creates a relation between this [Room] and the given [RoomFee]s
  /// by setting each [RoomFee]'s foreign key `roomId` to refer to this [Room].
  Future<void> fees(
    _is.DatabaseSession session,
    Room room,
    List<_iv47he65.RoomFee> roomFee, {
    _is.Transaction? transaction,
  }) async {
    if (roomFee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomFee.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $roomFee = roomFee.map((e) => e.copyWith(roomId: room.id)).toList();
    await session.db.update<_iv47he65.RoomFee>(
      $roomFee,
      columns: [_iv47he65.RoomFee.t.roomId],
      transaction: transaction,
    );
  }
}

class RoomAttachRowRepository {
  const RoomAttachRowRepository._();

  /// Creates a relation between the given [Room] and [Building]
  /// by setting the [Room]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    Room room,
    _ig4w4s7q.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $room = room.copyWith(buildingId: building.id);
    await session.db.updateRow<Room>(
      $room,
      columns: [Room.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Room] and [UnitType]
  /// by setting the [Room]'s foreign key `unitTypeId` to refer to the [UnitType].
  Future<void> unitType(
    _is.DatabaseSession session,
    Room room,
    _iwfco3zw.UnitType unitType, {
    _is.Transaction? transaction,
  }) async {
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }
    if (unitType.id == null) {
      throw ArgumentError.notNull('unitType.id');
    }

    var $room = room.copyWith(unitTypeId: unitType.id);
    await session.db.updateRow<Room>(
      $room,
      columns: [Room.t.unitTypeId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Room] and the given [RoomFee]
  /// by setting the [RoomFee]'s foreign key `roomId` to refer to this [Room].
  Future<void> fees(
    _is.DatabaseSession session,
    Room room,
    _iv47he65.RoomFee roomFee, {
    _is.Transaction? transaction,
  }) async {
    if (roomFee.id == null) {
      throw ArgumentError.notNull('roomFee.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $roomFee = roomFee.copyWith(roomId: room.id);
    await session.db.updateRow<_iv47he65.RoomFee>(
      $roomFee,
      columns: [_iv47he65.RoomFee.t.roomId],
      transaction: transaction,
    );
  }
}

class RoomDetachRowRepository {
  const RoomDetachRowRepository._();

  /// Detaches the relation between this [Room] and the [Building] set in `building`
  /// by setting the [Room]'s foreign key `buildingId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> building(
    _is.DatabaseSession session,
    Room room, {
    _is.Transaction? transaction,
  }) async {
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $room = room.copyWith(buildingId: null);
    await session.db.updateRow<Room>(
      $room,
      columns: [Room.t.buildingId],
      transaction: transaction,
    );
  }
}
