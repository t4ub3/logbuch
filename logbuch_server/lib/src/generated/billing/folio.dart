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
import '../billing/charge.dart' as _ipdcl412;
import '../billing/folio_status.dart' as _i90mh7tq;
import '../billing/payment.dart' as _i5od23c2;
import '../bookings/bookings.dart' as _i2jbfzmp;
import '../contacts/contact.dart' as _imbxrfja;

/// The account of one payer for one booking: what they are charged and
/// what they paid.
abstract class Folio implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Folio._({
    this.id,
    required this.bookingId,
    this.booking,
    required this.payerId,
    this.payer,
    _i90mh7tq.FolioStatus? status,
    this.invoiceNumber,
    this.invoicedAt,
    this.charges,
    this.payments,
  }) : status = status ?? _i90mh7tq.FolioStatus.open;

  factory Folio({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int payerId,
    _imbxrfja.Contact? payer,
    _i90mh7tq.FolioStatus? status,
    String? invoiceNumber,
    DateTime? invoicedAt,
    List<_ipdcl412.Charge>? charges,
    List<_i5od23c2.Payment>? payments,
  }) = _FolioImpl;

  factory Folio.fromJson(Map<String, dynamic> jsonSerialization) {
    return Folio(
      id: jsonSerialization['id'] as int?,
      bookingId: jsonSerialization['bookingId'] as int,
      booking: jsonSerialization['booking'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i2jbfzmp.Booking>(
              jsonSerialization['booking'],
            ),
      payerId: jsonSerialization['payerId'] as int,
      payer: jsonSerialization['payer'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['payer'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i90mh7tq.FolioStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      invoiceNumber: jsonSerialization['invoiceNumber'] as String?,
      invoicedAt: jsonSerialization['invoicedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['invoicedAt']),
      charges: jsonSerialization['charges'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_ipdcl412.Charge>>(
              jsonSerialization['charges'],
            ),
      payments: jsonSerialization['payments'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_i5od23c2.Payment>>(
              jsonSerialization['payments'],
            ),
    );
  }

  static final t = FolioTable();

  static const db = FolioRepository._();

  @override
  int? id;

  int bookingId;

  _i2jbfzmp.Booking? booking;

  int payerId;

  _imbxrfja.Contact? payer;

  _i90mh7tq.FolioStatus status;

  /// Given once when the folio is invoiced and never changed afterwards.
  String? invoiceNumber;

  /// The day of the invoice.
  DateTime? invoicedAt;

  List<_ipdcl412.Charge>? charges;

  List<_i5od23c2.Payment>? payments;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Folio]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Folio copyWith({
    int? id,
    int? bookingId,
    _i2jbfzmp.Booking? booking,
    int? payerId,
    _imbxrfja.Contact? payer,
    _i90mh7tq.FolioStatus? status,
    String? invoiceNumber,
    DateTime? invoicedAt,
    List<_ipdcl412.Charge>? charges,
    List<_i5od23c2.Payment>? payments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Folio',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJson(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJson(),
      'status': status.toJson(),
      if (invoiceNumber != null) 'invoiceNumber': invoiceNumber,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      if (charges != null)
        'charges': charges?.toJson(valueToJson: (v) => v.toJson()),
      if (payments != null)
        'payments': payments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Folio',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJsonForProtocol(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJsonForProtocol(),
      'status': status.toJson(),
      if (invoiceNumber != null) 'invoiceNumber': invoiceNumber,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      if (charges != null)
        'charges': charges?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (payments != null)
        'payments': payments?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static FolioInclude include({
    _i2jbfzmp.BookingInclude? booking,
    _imbxrfja.ContactInclude? payer,
    _ipdcl412.ChargeIncludeList? charges,
    _i5od23c2.PaymentIncludeList? payments,
  }) {
    return FolioInclude._(
      booking: booking,
      payer: payer,
      charges: charges,
      payments: payments,
    );
  }

  static FolioIncludeList includeList({
    _is.WhereExpressionBuilder<FolioTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FolioTable>? orderBy,
    _is.OrderByListBuilder<FolioTable>? orderByList,
    FolioInclude? include,
  }) {
    return FolioIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Folio.t),
      orderByList: orderByList?.call(Folio.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FolioImpl extends Folio {
  _FolioImpl({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int payerId,
    _imbxrfja.Contact? payer,
    _i90mh7tq.FolioStatus? status,
    String? invoiceNumber,
    DateTime? invoicedAt,
    List<_ipdcl412.Charge>? charges,
    List<_i5od23c2.Payment>? payments,
  }) : super._(
         id: id,
         bookingId: bookingId,
         booking: booking,
         payerId: payerId,
         payer: payer,
         status: status,
         invoiceNumber: invoiceNumber,
         invoicedAt: invoicedAt,
         charges: charges,
         payments: payments,
       );

  /// Returns a shallow copy of this [Folio]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Folio copyWith({
    Object? id = _Undefined,
    int? bookingId,
    Object? booking = _Undefined,
    int? payerId,
    Object? payer = _Undefined,
    _i90mh7tq.FolioStatus? status,
    Object? invoiceNumber = _Undefined,
    Object? invoicedAt = _Undefined,
    Object? charges = _Undefined,
    Object? payments = _Undefined,
  }) {
    return Folio(
      id: id is int? ? id : this.id,
      bookingId: bookingId ?? this.bookingId,
      booking: booking is _i2jbfzmp.Booking?
          ? booking
          : this.booking?.copyWith(),
      payerId: payerId ?? this.payerId,
      payer: payer is _imbxrfja.Contact? ? payer : this.payer?.copyWith(),
      status: status ?? this.status,
      invoiceNumber: invoiceNumber is String?
          ? invoiceNumber
          : this.invoiceNumber,
      invoicedAt: invoicedAt is DateTime? ? invoicedAt : this.invoicedAt,
      charges: charges is List<_ipdcl412.Charge>?
          ? charges
          : this.charges?.map((e0) => e0.copyWith()).toList(),
      payments: payments is List<_i5od23c2.Payment>?
          ? payments
          : this.payments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class FolioUpdateTable extends _is.UpdateTable<FolioTable> {
  FolioUpdateTable(super.table);

  _is.ColumnValue<int, int> bookingId(int value) => _is.ColumnValue(
    table.bookingId,
    value,
  );

  _is.ColumnValue<int, int> payerId(int value) => _is.ColumnValue(
    table.payerId,
    value,
  );

  _is.ColumnValue<_i90mh7tq.FolioStatus, _i90mh7tq.FolioStatus> status(
    _i90mh7tq.FolioStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> invoiceNumber(String? value) =>
      _is.ColumnValue(
        table.invoiceNumber,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> invoicedAt(DateTime? value) =>
      _is.ColumnValue(
        table.invoicedAt,
        value,
      );
}

class FolioTable extends _is.Table<int?> {
  FolioTable({super.tableRelation}) : super(tableName: 'folios') {
    updateTable = FolioUpdateTable(this);
    bookingId = _is.ColumnInt(
      'bookingId',
      this,
    );
    payerId = _is.ColumnInt(
      'payerId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    invoiceNumber = _is.ColumnString(
      'invoiceNumber',
      this,
    );
    invoicedAt = _is.ColumnDateTime(
      'invoicedAt',
      this,
    );
  }

  late final FolioUpdateTable updateTable;

  late final _is.ColumnInt bookingId;

  _i2jbfzmp.BookingTable? _booking;

  late final _is.ColumnInt payerId;

  _imbxrfja.ContactTable? _payer;

  late final _is.ColumnEnum<_i90mh7tq.FolioStatus> status;

  /// Given once when the folio is invoiced and never changed afterwards.
  late final _is.ColumnString invoiceNumber;

  /// The day of the invoice.
  late final _is.ColumnDateTime invoicedAt;

  _ipdcl412.ChargeTable? ___charges;

  _is.ManyRelation<_ipdcl412.ChargeTable>? _charges;

  _i5od23c2.PaymentTable? ___payments;

  _is.ManyRelation<_i5od23c2.PaymentTable>? _payments;

  _i2jbfzmp.BookingTable get booking {
    if (_booking != null) return _booking!;
    _booking = _is.createRelationTable(
      relationFieldName: 'booking',
      field: Folio.t.bookingId,
      foreignField: _i2jbfzmp.Booking.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2jbfzmp.BookingTable(tableRelation: foreignTableRelation),
    );
    return _booking!;
  }

  _imbxrfja.ContactTable get payer {
    if (_payer != null) return _payer!;
    _payer = _is.createRelationTable(
      relationFieldName: 'payer',
      field: Folio.t.payerId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _payer!;
  }

  _ipdcl412.ChargeTable get __charges {
    if (___charges != null) return ___charges!;
    ___charges = _is.createRelationTable(
      relationFieldName: '__charges',
      field: Folio.t.id,
      foreignField: _ipdcl412.Charge.t.folioId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ipdcl412.ChargeTable(tableRelation: foreignTableRelation),
    );
    return ___charges!;
  }

  _i5od23c2.PaymentTable get __payments {
    if (___payments != null) return ___payments!;
    ___payments = _is.createRelationTable(
      relationFieldName: '__payments',
      field: Folio.t.id,
      foreignField: _i5od23c2.Payment.t.folioId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5od23c2.PaymentTable(tableRelation: foreignTableRelation),
    );
    return ___payments!;
  }

  _is.ManyRelation<_ipdcl412.ChargeTable> get charges {
    if (_charges != null) return _charges!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'charges',
      field: Folio.t.id,
      foreignField: _ipdcl412.Charge.t.folioId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ipdcl412.ChargeTable(tableRelation: foreignTableRelation),
    );
    _charges = _is.ManyRelation<_ipdcl412.ChargeTable>(
      tableWithRelations: relationTable,
      table: _ipdcl412.ChargeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _charges!;
  }

  _is.ManyRelation<_i5od23c2.PaymentTable> get payments {
    if (_payments != null) return _payments!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'payments',
      field: Folio.t.id,
      foreignField: _i5od23c2.Payment.t.folioId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5od23c2.PaymentTable(tableRelation: foreignTableRelation),
    );
    _payments = _is.ManyRelation<_i5od23c2.PaymentTable>(
      tableWithRelations: relationTable,
      table: _i5od23c2.PaymentTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _payments!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    bookingId,
    payerId,
    status,
    invoiceNumber,
    invoicedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'booking') {
      return booking;
    }
    if (relationField == 'payer') {
      return payer;
    }
    if (relationField == 'charges') {
      return __charges;
    }
    if (relationField == 'payments') {
      return __payments;
    }
    return null;
  }
}

class FolioInclude extends _is.IncludeObject {
  FolioInclude._({
    _i2jbfzmp.BookingInclude? booking,
    _imbxrfja.ContactInclude? payer,
    _ipdcl412.ChargeIncludeList? charges,
    _i5od23c2.PaymentIncludeList? payments,
  }) {
    _booking = booking;
    _payer = payer;
    _charges = charges;
    _payments = payments;
  }

  _i2jbfzmp.BookingInclude? _booking;

  _imbxrfja.ContactInclude? _payer;

  _ipdcl412.ChargeIncludeList? _charges;

  _i5od23c2.PaymentIncludeList? _payments;

  @override
  Map<String, _is.Include?> get includes => {
    'booking': _booking,
    'payer': _payer,
    'charges': _charges,
    'payments': _payments,
  };

  @override
  _is.Table<int?> get table => Folio.t;
}

class FolioIncludeList extends _is.IncludeList {
  FolioIncludeList._({
    _is.WhereExpressionBuilder<FolioTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Folio.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Folio.t;
}

class FolioRepository {
  const FolioRepository._();

  final attach = const FolioAttachRepository._();

  final attachRow = const FolioAttachRowRepository._();

  /// Returns a list of [Folio]s matching the given query parameters.
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
  Future<List<Folio>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FolioTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FolioTable>? orderBy,
    _is.OrderByListBuilder<FolioTable>? orderByList,
    _is.Transaction? transaction,
    FolioInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Folio>(
      where: where?.call(Folio.t),
      orderBy: orderBy?.call(Folio.t),
      orderByList: orderByList?.call(Folio.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Folio] matching the given query parameters.
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
  Future<Folio?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FolioTable>? where,
    int? offset,
    _is.OrderByBuilder<FolioTable>? orderBy,
    _is.OrderByListBuilder<FolioTable>? orderByList,
    _is.Transaction? transaction,
    FolioInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Folio>(
      where: where?.call(Folio.t),
      orderBy: orderBy?.call(Folio.t),
      orderByList: orderByList?.call(Folio.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Folio] by its [id] or null if no such row exists.
  Future<Folio?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FolioInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Folio>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Folio]s in the list and returns the inserted rows.
  ///
  /// The returned [Folio]s will have their `id` fields set.
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
  Future<List<Folio>> insert(
    _is.DatabaseSession session,
    List<Folio> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Folio>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Folio] and returns the inserted row.
  ///
  /// The returned [Folio] will have its `id` field set.
  Future<Folio> insertRow(
    _is.DatabaseSession session,
    Folio row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Folio>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Folio]s in the list and returns the resulting rows.
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
  /// The returned [Folio]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Folio>> upsert(
    _is.DatabaseSession session,
    List<Folio> rows, {
    required _is.ColumnSelections<FolioTable> conflictColumns,
    _is.ColumnSelections<FolioTable>? updateColumns,
    _is.WhereExpressionBuilder<FolioTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Folio>(
      rows,
      conflictColumns: conflictColumns(Folio.t),
      updateColumns: updateColumns?.call(Folio.t),
      updateWhere: updateWhere?.call(Folio.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Folio] and returns the resulting row.
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
  /// The returned [Folio] will have its `id` field set.
  Future<Folio?> upsertRow(
    _is.DatabaseSession session,
    Folio row, {
    required _is.ColumnSelections<FolioTable> conflictColumns,
    _is.ColumnSelections<FolioTable>? updateColumns,
    _is.WhereExpressionBuilder<FolioTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Folio>(
      row,
      conflictColumns: conflictColumns(Folio.t),
      updateColumns: updateColumns?.call(Folio.t),
      updateWhere: updateWhere?.call(Folio.t),
      transaction: transaction,
    );
  }

  /// Updates all [Folio]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Folio>> update(
    _is.DatabaseSession session,
    List<Folio> rows, {
    _is.ColumnSelections<FolioTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Folio>(
      rows,
      columns: columns?.call(Folio.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Folio]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Folio> updateRow(
    _is.DatabaseSession session,
    Folio row, {
    _is.ColumnSelections<FolioTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Folio>(
      row,
      columns: columns?.call(Folio.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Folio] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Folio?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FolioUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Folio>(
      id,
      columnValues: columnValues(Folio.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Folio]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Folio>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FolioUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FolioTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FolioTable>? orderBy,
    _is.OrderByListBuilder<FolioTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Folio>(
      columnValues: columnValues(Folio.t.updateTable),
      where: where(Folio.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Folio.t),
      orderByList: orderByList?.call(Folio.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Folio]s in the list and returns the deleted rows.
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
  Future<List<Folio>> delete(
    _is.DatabaseSession session,
    List<Folio> rows, {
    _is.OrderByBuilder<FolioTable>? orderBy,
    _is.OrderByListBuilder<FolioTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Folio>(
      rows,
      orderBy: orderBy?.call(Folio.t),
      orderByList: orderByList?.call(Folio.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Folio].
  Future<Folio> deleteRow(
    _is.DatabaseSession session,
    Folio row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Folio>(
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
  Future<List<Folio>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FolioTable> where,
    _is.OrderByBuilder<FolioTable>? orderBy,
    _is.OrderByListBuilder<FolioTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Folio>(
      where: where(Folio.t),
      orderBy: orderBy?.call(Folio.t),
      orderByList: orderByList?.call(Folio.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FolioTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Folio>(
      where: where?.call(Folio.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Folio] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FolioTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Folio>(
      where: where(Folio.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FolioAttachRepository {
  const FolioAttachRepository._();

  /// Creates a relation between this [Folio] and the given [Charge]s
  /// by setting each [Charge]'s foreign key `folioId` to refer to this [Folio].
  Future<void> charges(
    _is.DatabaseSession session,
    Folio folio,
    List<_ipdcl412.Charge> charge, {
    _is.Transaction? transaction,
  }) async {
    if (charge.any((e) => e.id == null)) {
      throw ArgumentError.notNull('charge.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $charge = charge.map((e) => e.copyWith(folioId: folio.id)).toList();
    await session.db.update<_ipdcl412.Charge>(
      $charge,
      columns: [_ipdcl412.Charge.t.folioId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Folio] and the given [Payment]s
  /// by setting each [Payment]'s foreign key `folioId` to refer to this [Folio].
  Future<void> payments(
    _is.DatabaseSession session,
    Folio folio,
    List<_i5od23c2.Payment> payment, {
    _is.Transaction? transaction,
  }) async {
    if (payment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('payment.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $payment = payment.map((e) => e.copyWith(folioId: folio.id)).toList();
    await session.db.update<_i5od23c2.Payment>(
      $payment,
      columns: [_i5od23c2.Payment.t.folioId],
      transaction: transaction,
    );
  }
}

class FolioAttachRowRepository {
  const FolioAttachRowRepository._();

  /// Creates a relation between the given [Folio] and [Booking]
  /// by setting the [Folio]'s foreign key `bookingId` to refer to the [Booking].
  Future<void> booking(
    _is.DatabaseSession session,
    Folio folio,
    _i2jbfzmp.Booking booking, {
    _is.Transaction? transaction,
  }) async {
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $folio = folio.copyWith(bookingId: booking.id);
    await session.db.updateRow<Folio>(
      $folio,
      columns: [Folio.t.bookingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Folio] and [Contact]
  /// by setting the [Folio]'s foreign key `payerId` to refer to the [Contact].
  Future<void> payer(
    _is.DatabaseSession session,
    Folio folio,
    _imbxrfja.Contact payer, {
    _is.Transaction? transaction,
  }) async {
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }
    if (payer.id == null) {
      throw ArgumentError.notNull('payer.id');
    }

    var $folio = folio.copyWith(payerId: payer.id);
    await session.db.updateRow<Folio>(
      $folio,
      columns: [Folio.t.payerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Folio] and the given [Charge]
  /// by setting the [Charge]'s foreign key `folioId` to refer to this [Folio].
  Future<void> charges(
    _is.DatabaseSession session,
    Folio folio,
    _ipdcl412.Charge charge, {
    _is.Transaction? transaction,
  }) async {
    if (charge.id == null) {
      throw ArgumentError.notNull('charge.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $charge = charge.copyWith(folioId: folio.id);
    await session.db.updateRow<_ipdcl412.Charge>(
      $charge,
      columns: [_ipdcl412.Charge.t.folioId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Folio] and the given [Payment]
  /// by setting the [Payment]'s foreign key `folioId` to refer to this [Folio].
  Future<void> payments(
    _is.DatabaseSession session,
    Folio folio,
    _i5od23c2.Payment payment, {
    _is.Transaction? transaction,
  }) async {
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $payment = payment.copyWith(folioId: folio.id);
    await session.db.updateRow<_i5od23c2.Payment>(
      $payment,
      columns: [_i5od23c2.Payment.t.folioId],
      transaction: transaction,
    );
  }
}
