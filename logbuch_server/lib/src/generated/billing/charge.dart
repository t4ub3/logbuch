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
import '../billing/folio.dart' as _i7r42ton;
import '../guests/guest.dart' as _inwk3jth;
import '../pricing/charge_type.dart' as _iiq5obzg;

/// A position on a folio. It keeps the price it was charged with, whatever
/// happens to the rates later. Amounts are in cents and include the tax.
abstract class Charge implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Charge._({
    this.id,
    required this.folioId,
    this.folio,
    this.guestId,
    this.guest,
    required this.type,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.taxRate,
    this.periodFrom,
    this.periodTo,
  });

  factory Charge({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    int? guestId,
    _inwk3jth.Guest? guest,
    required _iiq5obzg.ChargeType type,
    required String description,
    required int quantity,
    required int unitPrice,
    required int total,
    required int taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  }) = _ChargeImpl;

  factory Charge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Charge(
      id: jsonSerialization['id'] as int?,
      folioId: jsonSerialization['folioId'] as int,
      folio: jsonSerialization['folio'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i7r42ton.Folio>(
              jsonSerialization['folio'],
            ),
      guestId: jsonSerialization['guestId'] as int?,
      guest: jsonSerialization['guest'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_inwk3jth.Guest>(
              jsonSerialization['guest'],
            ),
      type: _iiq5obzg.ChargeType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      description: jsonSerialization['description'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: jsonSerialization['unitPrice'] as int,
      total: jsonSerialization['total'] as int,
      taxRate: jsonSerialization['taxRate'] as int,
      periodFrom: jsonSerialization['periodFrom'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['periodFrom']),
      periodTo: jsonSerialization['periodTo'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['periodTo']),
    );
  }

  static final t = ChargeTable();

  static const db = ChargeRepository._();

  @override
  int? id;

  int folioId;

  _i7r42ton.Folio? folio;

  int? guestId;

  /// Null for what is charged per booking or per room, and for charges
  /// added by hand.
  _inwk3jth.Guest? guest;

  _iiq5obzg.ChargeType type;

  String description;

  int quantity;

  int unitPrice;

  int total;

  /// In basis points.
  int taxRate;

  DateTime? periodFrom;

  DateTime? periodTo;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Charge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Charge copyWith({
    int? id,
    int? folioId,
    _i7r42ton.Folio? folio,
    int? guestId,
    _inwk3jth.Guest? guest,
    _iiq5obzg.ChargeType? type,
    String? description,
    int? quantity,
    int? unitPrice,
    int? total,
    int? taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Charge',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJson(),
      if (guestId != null) 'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'type': type.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
      'taxRate': taxRate,
      if (periodFrom != null) 'periodFrom': periodFrom?.toJson(),
      if (periodTo != null) 'periodTo': periodTo?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Charge',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJsonForProtocol(),
      if (guestId != null) 'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      'type': type.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
      'taxRate': taxRate,
      if (periodFrom != null) 'periodFrom': periodFrom?.toJson(),
      if (periodTo != null) 'periodTo': periodTo?.toJson(),
    };
  }

  static ChargeInclude include({
    _i7r42ton.FolioInclude? folio,
    _inwk3jth.GuestInclude? guest,
  }) {
    return ChargeInclude._(
      folio: folio,
      guest: guest,
    );
  }

  static ChargeIncludeList includeList({
    _is.WhereExpressionBuilder<ChargeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChargeTable>? orderBy,
    _is.OrderByListBuilder<ChargeTable>? orderByList,
    ChargeInclude? include,
  }) {
    return ChargeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Charge.t),
      orderByList: orderByList?.call(Charge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChargeImpl extends Charge {
  _ChargeImpl({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    int? guestId,
    _inwk3jth.Guest? guest,
    required _iiq5obzg.ChargeType type,
    required String description,
    required int quantity,
    required int unitPrice,
    required int total,
    required int taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  }) : super._(
         id: id,
         folioId: folioId,
         folio: folio,
         guestId: guestId,
         guest: guest,
         type: type,
         description: description,
         quantity: quantity,
         unitPrice: unitPrice,
         total: total,
         taxRate: taxRate,
         periodFrom: periodFrom,
         periodTo: periodTo,
       );

  /// Returns a shallow copy of this [Charge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Charge copyWith({
    Object? id = _Undefined,
    int? folioId,
    Object? folio = _Undefined,
    Object? guestId = _Undefined,
    Object? guest = _Undefined,
    _iiq5obzg.ChargeType? type,
    String? description,
    int? quantity,
    int? unitPrice,
    int? total,
    int? taxRate,
    Object? periodFrom = _Undefined,
    Object? periodTo = _Undefined,
  }) {
    return Charge(
      id: id is int? ? id : this.id,
      folioId: folioId ?? this.folioId,
      folio: folio is _i7r42ton.Folio? ? folio : this.folio?.copyWith(),
      guestId: guestId is int? ? guestId : this.guestId,
      guest: guest is _inwk3jth.Guest? ? guest : this.guest?.copyWith(),
      type: type ?? this.type,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      taxRate: taxRate ?? this.taxRate,
      periodFrom: periodFrom is DateTime? ? periodFrom : this.periodFrom,
      periodTo: periodTo is DateTime? ? periodTo : this.periodTo,
    );
  }
}

class ChargeUpdateTable extends _is.UpdateTable<ChargeTable> {
  ChargeUpdateTable(super.table);

  _is.ColumnValue<int, int> folioId(int value) => _is.ColumnValue(
    table.folioId,
    value,
  );

  _is.ColumnValue<int, int> guestId(int? value) => _is.ColumnValue(
    table.guestId,
    value,
  );

  _is.ColumnValue<_iiq5obzg.ChargeType, _iiq5obzg.ChargeType> type(
    _iiq5obzg.ChargeType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> quantity(int value) => _is.ColumnValue(
    table.quantity,
    value,
  );

  _is.ColumnValue<int, int> unitPrice(int value) => _is.ColumnValue(
    table.unitPrice,
    value,
  );

  _is.ColumnValue<int, int> total(int value) => _is.ColumnValue(
    table.total,
    value,
  );

  _is.ColumnValue<int, int> taxRate(int value) => _is.ColumnValue(
    table.taxRate,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> periodFrom(DateTime? value) =>
      _is.ColumnValue(
        table.periodFrom,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> periodTo(DateTime? value) =>
      _is.ColumnValue(
        table.periodTo,
        value,
      );
}

class ChargeTable extends _is.Table<int?> {
  ChargeTable({super.tableRelation}) : super(tableName: 'charges') {
    updateTable = ChargeUpdateTable(this);
    folioId = _is.ColumnInt(
      'folioId',
      this,
    );
    guestId = _is.ColumnInt(
      'guestId',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    quantity = _is.ColumnInt(
      'quantity',
      this,
    );
    unitPrice = _is.ColumnInt(
      'unitPrice',
      this,
    );
    total = _is.ColumnInt(
      'total',
      this,
    );
    taxRate = _is.ColumnInt(
      'taxRate',
      this,
    );
    periodFrom = _is.ColumnDateTime(
      'periodFrom',
      this,
    );
    periodTo = _is.ColumnDateTime(
      'periodTo',
      this,
    );
  }

  late final ChargeUpdateTable updateTable;

  late final _is.ColumnInt folioId;

  _i7r42ton.FolioTable? _folio;

  late final _is.ColumnInt guestId;

  /// Null for what is charged per booking or per room, and for charges
  /// added by hand.
  _inwk3jth.GuestTable? _guest;

  late final _is.ColumnEnum<_iiq5obzg.ChargeType> type;

  late final _is.ColumnString description;

  late final _is.ColumnInt quantity;

  late final _is.ColumnInt unitPrice;

  late final _is.ColumnInt total;

  /// In basis points.
  late final _is.ColumnInt taxRate;

  late final _is.ColumnDateTime periodFrom;

  late final _is.ColumnDateTime periodTo;

  _i7r42ton.FolioTable get folio {
    if (_folio != null) return _folio!;
    _folio = _is.createRelationTable(
      relationFieldName: 'folio',
      field: Charge.t.folioId,
      foreignField: _i7r42ton.Folio.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7r42ton.FolioTable(tableRelation: foreignTableRelation),
    );
    return _folio!;
  }

  _inwk3jth.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _is.createRelationTable(
      relationFieldName: 'guest',
      field: Charge.t.guestId,
      foreignField: _inwk3jth.Guest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inwk3jth.GuestTable(tableRelation: foreignTableRelation),
    );
    return _guest!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    folioId,
    guestId,
    type,
    description,
    quantity,
    unitPrice,
    total,
    taxRate,
    periodFrom,
    periodTo,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'folio') {
      return folio;
    }
    if (relationField == 'guest') {
      return guest;
    }
    return null;
  }
}

class ChargeInclude extends _is.IncludeObject {
  ChargeInclude._({
    _i7r42ton.FolioInclude? folio,
    _inwk3jth.GuestInclude? guest,
  }) {
    _folio = folio;
    _guest = guest;
  }

  _i7r42ton.FolioInclude? _folio;

  _inwk3jth.GuestInclude? _guest;

  @override
  Map<String, _is.Include?> get includes => {
    'folio': _folio,
    'guest': _guest,
  };

  @override
  _is.Table<int?> get table => Charge.t;
}

class ChargeIncludeList extends _is.IncludeList {
  ChargeIncludeList._({
    _is.WhereExpressionBuilder<ChargeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Charge.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Charge.t;
}

class ChargeRepository {
  const ChargeRepository._();

  final attachRow = const ChargeAttachRowRepository._();

  final detachRow = const ChargeDetachRowRepository._();

  /// Returns a list of [Charge]s matching the given query parameters.
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
  Future<List<Charge>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChargeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChargeTable>? orderBy,
    _is.OrderByListBuilder<ChargeTable>? orderByList,
    _is.Transaction? transaction,
    ChargeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Charge>(
      where: where?.call(Charge.t),
      orderBy: orderBy?.call(Charge.t),
      orderByList: orderByList?.call(Charge.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Charge] matching the given query parameters.
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
  Future<Charge?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChargeTable>? where,
    int? offset,
    _is.OrderByBuilder<ChargeTable>? orderBy,
    _is.OrderByListBuilder<ChargeTable>? orderByList,
    _is.Transaction? transaction,
    ChargeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Charge>(
      where: where?.call(Charge.t),
      orderBy: orderBy?.call(Charge.t),
      orderByList: orderByList?.call(Charge.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Charge] by its [id] or null if no such row exists.
  Future<Charge?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ChargeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Charge>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Charge]s in the list and returns the inserted rows.
  ///
  /// The returned [Charge]s will have their `id` fields set.
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
  Future<List<Charge>> insert(
    _is.DatabaseSession session,
    List<Charge> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Charge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Charge] and returns the inserted row.
  ///
  /// The returned [Charge] will have its `id` field set.
  Future<Charge> insertRow(
    _is.DatabaseSession session,
    Charge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Charge>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Charge]s in the list and returns the resulting rows.
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
  /// The returned [Charge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Charge>> upsert(
    _is.DatabaseSession session,
    List<Charge> rows, {
    required _is.ColumnSelections<ChargeTable> conflictColumns,
    _is.ColumnSelections<ChargeTable>? updateColumns,
    _is.WhereExpressionBuilder<ChargeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Charge>(
      rows,
      conflictColumns: conflictColumns(Charge.t),
      updateColumns: updateColumns?.call(Charge.t),
      updateWhere: updateWhere?.call(Charge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Charge] and returns the resulting row.
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
  /// The returned [Charge] will have its `id` field set.
  Future<Charge?> upsertRow(
    _is.DatabaseSession session,
    Charge row, {
    required _is.ColumnSelections<ChargeTable> conflictColumns,
    _is.ColumnSelections<ChargeTable>? updateColumns,
    _is.WhereExpressionBuilder<ChargeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Charge>(
      row,
      conflictColumns: conflictColumns(Charge.t),
      updateColumns: updateColumns?.call(Charge.t),
      updateWhere: updateWhere?.call(Charge.t),
      transaction: transaction,
    );
  }

  /// Updates all [Charge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Charge>> update(
    _is.DatabaseSession session,
    List<Charge> rows, {
    _is.ColumnSelections<ChargeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Charge>(
      rows,
      columns: columns?.call(Charge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Charge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Charge> updateRow(
    _is.DatabaseSession session,
    Charge row, {
    _is.ColumnSelections<ChargeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Charge>(
      row,
      columns: columns?.call(Charge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Charge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Charge?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChargeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Charge>(
      id,
      columnValues: columnValues(Charge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Charge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Charge>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChargeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChargeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChargeTable>? orderBy,
    _is.OrderByListBuilder<ChargeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Charge>(
      columnValues: columnValues(Charge.t.updateTable),
      where: where(Charge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Charge.t),
      orderByList: orderByList?.call(Charge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Charge]s in the list and returns the deleted rows.
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
  Future<List<Charge>> delete(
    _is.DatabaseSession session,
    List<Charge> rows, {
    _is.OrderByBuilder<ChargeTable>? orderBy,
    _is.OrderByListBuilder<ChargeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Charge>(
      rows,
      orderBy: orderBy?.call(Charge.t),
      orderByList: orderByList?.call(Charge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Charge].
  Future<Charge> deleteRow(
    _is.DatabaseSession session,
    Charge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Charge>(
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
  Future<List<Charge>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChargeTable> where,
    _is.OrderByBuilder<ChargeTable>? orderBy,
    _is.OrderByListBuilder<ChargeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Charge>(
      where: where(Charge.t),
      orderBy: orderBy?.call(Charge.t),
      orderByList: orderByList?.call(Charge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChargeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Charge>(
      where: where?.call(Charge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Charge] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChargeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Charge>(
      where: where(Charge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ChargeAttachRowRepository {
  const ChargeAttachRowRepository._();

  /// Creates a relation between the given [Charge] and [Folio]
  /// by setting the [Charge]'s foreign key `folioId` to refer to the [Folio].
  Future<void> folio(
    _is.DatabaseSession session,
    Charge charge,
    _i7r42ton.Folio folio, {
    _is.Transaction? transaction,
  }) async {
    if (charge.id == null) {
      throw ArgumentError.notNull('charge.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $charge = charge.copyWith(folioId: folio.id);
    await session.db.updateRow<Charge>(
      $charge,
      columns: [Charge.t.folioId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Charge] and [Guest]
  /// by setting the [Charge]'s foreign key `guestId` to refer to the [Guest].
  Future<void> guest(
    _is.DatabaseSession session,
    Charge charge,
    _inwk3jth.Guest guest, {
    _is.Transaction? transaction,
  }) async {
    if (charge.id == null) {
      throw ArgumentError.notNull('charge.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $charge = charge.copyWith(guestId: guest.id);
    await session.db.updateRow<Charge>(
      $charge,
      columns: [Charge.t.guestId],
      transaction: transaction,
    );
  }
}

class ChargeDetachRowRepository {
  const ChargeDetachRowRepository._();

  /// Detaches the relation between this [Charge] and the [Guest] set in `guest`
  /// by setting the [Charge]'s foreign key `guestId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> guest(
    _is.DatabaseSession session,
    Charge charge, {
    _is.Transaction? transaction,
  }) async {
    if (charge.id == null) {
      throw ArgumentError.notNull('charge.id');
    }

    var $charge = charge.copyWith(guestId: null);
    await session.db.updateRow<Charge>(
      $charge,
      columns: [Charge.t.guestId],
      transaction: transaction,
    );
  }
}
