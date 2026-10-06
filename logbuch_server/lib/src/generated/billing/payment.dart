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
import '../billing/donation.dart' as _isunzuoe;
import '../billing/folio.dart' as _i7r42ton;
import '../billing/payment_method.dart' as _ilepuntz;
import '../contacts/contact.dart' as _imbxrfja;

/// Money received for a folio, or paid back if the amount is negative.
abstract class Payment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Payment._({
    this.id,
    required this.folioId,
    this.folio,
    required this.payerId,
    this.payer,
    required this.amount,
    required this.date,
    required this.method,
    this.reference,
    this.donations,
  });

  factory Payment({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    required int payerId,
    _imbxrfja.Contact? payer,
    required int amount,
    required DateTime date,
    required _ilepuntz.PaymentMethod method,
    String? reference,
    List<_isunzuoe.Donation>? donations,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      folioId: jsonSerialization['folioId'] as int,
      folio: jsonSerialization['folio'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i7r42ton.Folio>(
              jsonSerialization['folio'],
            ),
      payerId: jsonSerialization['payerId'] as int,
      payer: jsonSerialization['payer'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['payer'],
            ),
      amount: jsonSerialization['amount'] as int,
      date: _is.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      method: _ilepuntz.PaymentMethod.fromJson(
        (jsonSerialization['method'] as String),
      ),
      reference: jsonSerialization['reference'] as String?,
      donations: jsonSerialization['donations'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_isunzuoe.Donation>>(
              jsonSerialization['donations'],
            ),
    );
  }

  static final t = PaymentTable();

  static const db = PaymentRepository._();

  @override
  int? id;

  int folioId;

  _i7r42ton.Folio? folio;

  int payerId;

  _imbxrfja.Contact? payer;

  int amount;

  DateTime date;

  _ilepuntz.PaymentMethod method;

  String? reference;

  List<_isunzuoe.Donation>? donations;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Payment copyWith({
    int? id,
    int? folioId,
    _i7r42ton.Folio? folio,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? amount,
    DateTime? date,
    _ilepuntz.PaymentMethod? method,
    String? reference,
    List<_isunzuoe.Donation>? donations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJson(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJson(),
      'amount': amount,
      'date': date.toJson(),
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      if (donations != null)
        'donations': donations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJsonForProtocol(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJsonForProtocol(),
      'amount': amount,
      'date': date.toJson(),
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      if (donations != null)
        'donations': donations?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static PaymentInclude include({
    _i7r42ton.FolioInclude? folio,
    _imbxrfja.ContactInclude? payer,
    _isunzuoe.DonationIncludeList? donations,
  }) {
    return PaymentInclude._(
      folio: folio,
      payer: payer,
      donations: donations,
    );
  }

  static PaymentIncludeList includeList({
    _is.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PaymentTable>? orderBy,
    _is.OrderByListBuilder<PaymentTable>? orderByList,
    PaymentInclude? include,
  }) {
    return PaymentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    required int payerId,
    _imbxrfja.Contact? payer,
    required int amount,
    required DateTime date,
    required _ilepuntz.PaymentMethod method,
    String? reference,
    List<_isunzuoe.Donation>? donations,
  }) : super._(
         id: id,
         folioId: folioId,
         folio: folio,
         payerId: payerId,
         payer: payer,
         amount: amount,
         date: date,
         method: method,
         reference: reference,
         donations: donations,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? folioId,
    Object? folio = _Undefined,
    int? payerId,
    Object? payer = _Undefined,
    int? amount,
    DateTime? date,
    _ilepuntz.PaymentMethod? method,
    Object? reference = _Undefined,
    Object? donations = _Undefined,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      folioId: folioId ?? this.folioId,
      folio: folio is _i7r42ton.Folio? ? folio : this.folio?.copyWith(),
      payerId: payerId ?? this.payerId,
      payer: payer is _imbxrfja.Contact? ? payer : this.payer?.copyWith(),
      amount: amount ?? this.amount,
      date: date ?? this.date,
      method: method ?? this.method,
      reference: reference is String? ? reference : this.reference,
      donations: donations is List<_isunzuoe.Donation>?
          ? donations
          : this.donations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class PaymentUpdateTable extends _is.UpdateTable<PaymentTable> {
  PaymentUpdateTable(super.table);

  _is.ColumnValue<int, int> folioId(int value) => _is.ColumnValue(
    table.folioId,
    value,
  );

  _is.ColumnValue<int, int> payerId(int value) => _is.ColumnValue(
    table.payerId,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> date(DateTime value) => _is.ColumnValue(
    table.date,
    value,
  );

  _is.ColumnValue<_ilepuntz.PaymentMethod, _ilepuntz.PaymentMethod> method(
    _ilepuntz.PaymentMethod value,
  ) => _is.ColumnValue(
    table.method,
    value,
  );

  _is.ColumnValue<String, String> reference(String? value) => _is.ColumnValue(
    table.reference,
    value,
  );
}

class PaymentTable extends _is.Table<int?> {
  PaymentTable({super.tableRelation}) : super(tableName: 'payments') {
    updateTable = PaymentUpdateTable(this);
    folioId = _is.ColumnInt(
      'folioId',
      this,
    );
    payerId = _is.ColumnInt(
      'payerId',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
    );
    date = _is.ColumnDateTime(
      'date',
      this,
    );
    method = _is.ColumnEnum(
      'method',
      this,
      _is.EnumSerialization.byName,
    );
    reference = _is.ColumnString(
      'reference',
      this,
    );
  }

  late final PaymentUpdateTable updateTable;

  late final _is.ColumnInt folioId;

  _i7r42ton.FolioTable? _folio;

  late final _is.ColumnInt payerId;

  _imbxrfja.ContactTable? _payer;

  late final _is.ColumnInt amount;

  late final _is.ColumnDateTime date;

  late final _is.ColumnEnum<_ilepuntz.PaymentMethod> method;

  late final _is.ColumnString reference;

  _isunzuoe.DonationTable? ___donations;

  _is.ManyRelation<_isunzuoe.DonationTable>? _donations;

  _i7r42ton.FolioTable get folio {
    if (_folio != null) return _folio!;
    _folio = _is.createRelationTable(
      relationFieldName: 'folio',
      field: Payment.t.folioId,
      foreignField: _i7r42ton.Folio.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7r42ton.FolioTable(tableRelation: foreignTableRelation),
    );
    return _folio!;
  }

  _imbxrfja.ContactTable get payer {
    if (_payer != null) return _payer!;
    _payer = _is.createRelationTable(
      relationFieldName: 'payer',
      field: Payment.t.payerId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _payer!;
  }

  _isunzuoe.DonationTable get __donations {
    if (___donations != null) return ___donations!;
    ___donations = _is.createRelationTable(
      relationFieldName: '__donations',
      field: Payment.t.id,
      foreignField: _isunzuoe.Donation.t.paymentId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isunzuoe.DonationTable(tableRelation: foreignTableRelation),
    );
    return ___donations!;
  }

  _is.ManyRelation<_isunzuoe.DonationTable> get donations {
    if (_donations != null) return _donations!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'donations',
      field: Payment.t.id,
      foreignField: _isunzuoe.Donation.t.paymentId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isunzuoe.DonationTable(tableRelation: foreignTableRelation),
    );
    _donations = _is.ManyRelation<_isunzuoe.DonationTable>(
      tableWithRelations: relationTable,
      table: _isunzuoe.DonationTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _donations!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    folioId,
    payerId,
    amount,
    date,
    method,
    reference,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'folio') {
      return folio;
    }
    if (relationField == 'payer') {
      return payer;
    }
    if (relationField == 'donations') {
      return __donations;
    }
    return null;
  }
}

class PaymentInclude extends _is.IncludeObject {
  PaymentInclude._({
    _i7r42ton.FolioInclude? folio,
    _imbxrfja.ContactInclude? payer,
    _isunzuoe.DonationIncludeList? donations,
  }) {
    _folio = folio;
    _payer = payer;
    _donations = donations;
  }

  _i7r42ton.FolioInclude? _folio;

  _imbxrfja.ContactInclude? _payer;

  _isunzuoe.DonationIncludeList? _donations;

  @override
  Map<String, _is.Include?> get includes => {
    'folio': _folio,
    'payer': _payer,
    'donations': _donations,
  };

  @override
  _is.Table<int?> get table => Payment.t;
}

class PaymentIncludeList extends _is.IncludeList {
  PaymentIncludeList._({
    _is.WhereExpressionBuilder<PaymentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Payment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Payment.t;
}

class PaymentRepository {
  const PaymentRepository._();

  final attach = const PaymentAttachRepository._();

  final attachRow = const PaymentAttachRowRepository._();

  final detach = const PaymentDetachRepository._();

  final detachRow = const PaymentDetachRowRepository._();

  /// Returns a list of [Payment]s matching the given query parameters.
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
  Future<List<Payment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PaymentTable>? orderBy,
    _is.OrderByListBuilder<PaymentTable>? orderByList,
    _is.Transaction? transaction,
    PaymentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Payment] matching the given query parameters.
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
  Future<Payment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PaymentTable>? where,
    int? offset,
    _is.OrderByBuilder<PaymentTable>? orderBy,
    _is.OrderByListBuilder<PaymentTable>? orderByList,
    _is.Transaction? transaction,
    PaymentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Payment] by its [id] or null if no such row exists.
  Future<Payment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    PaymentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Payment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Payment]s in the list and returns the inserted rows.
  ///
  /// The returned [Payment]s will have their `id` fields set.
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
  Future<List<Payment>> insert(
    _is.DatabaseSession session,
    List<Payment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Payment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Payment] and returns the inserted row.
  ///
  /// The returned [Payment] will have its `id` field set.
  Future<Payment> insertRow(
    _is.DatabaseSession session,
    Payment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Payment]s in the list and returns the resulting rows.
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
  /// The returned [Payment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Payment>> upsert(
    _is.DatabaseSession session,
    List<Payment> rows, {
    required _is.ColumnSelections<PaymentTable> conflictColumns,
    _is.ColumnSelections<PaymentTable>? updateColumns,
    _is.WhereExpressionBuilder<PaymentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Payment>(
      rows,
      conflictColumns: conflictColumns(Payment.t),
      updateColumns: updateColumns?.call(Payment.t),
      updateWhere: updateWhere?.call(Payment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Payment] and returns the resulting row.
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
  /// The returned [Payment] will have its `id` field set.
  Future<Payment?> upsertRow(
    _is.DatabaseSession session,
    Payment row, {
    required _is.ColumnSelections<PaymentTable> conflictColumns,
    _is.ColumnSelections<PaymentTable>? updateColumns,
    _is.WhereExpressionBuilder<PaymentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Payment>(
      row,
      conflictColumns: conflictColumns(Payment.t),
      updateColumns: updateColumns?.call(Payment.t),
      updateWhere: updateWhere?.call(Payment.t),
      transaction: transaction,
    );
  }

  /// Updates all [Payment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Payment>> update(
    _is.DatabaseSession session,
    List<Payment> rows, {
    _is.ColumnSelections<PaymentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Payment>(
      rows,
      columns: columns?.call(Payment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Payment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Payment> updateRow(
    _is.DatabaseSession session,
    Payment row, {
    _is.ColumnSelections<PaymentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Payment>(
      row,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Payment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Payment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PaymentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Payment>(
      id,
      columnValues: columnValues(Payment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Payment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Payment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PaymentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PaymentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PaymentTable>? orderBy,
    _is.OrderByListBuilder<PaymentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Payment>(
      columnValues: columnValues(Payment.t.updateTable),
      where: where(Payment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Payment]s in the list and returns the deleted rows.
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
  Future<List<Payment>> delete(
    _is.DatabaseSession session,
    List<Payment> rows, {
    _is.OrderByBuilder<PaymentTable>? orderBy,
    _is.OrderByListBuilder<PaymentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Payment>(
      rows,
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Payment].
  Future<Payment> deleteRow(
    _is.DatabaseSession session,
    Payment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Payment>(
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
  Future<List<Payment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PaymentTable> where,
    _is.OrderByBuilder<PaymentTable>? orderBy,
    _is.OrderByListBuilder<PaymentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Payment>(
      where: where(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Payment>(
      where: where?.call(Payment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Payment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PaymentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Payment>(
      where: where(Payment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PaymentAttachRepository {
  const PaymentAttachRepository._();

  /// Creates a relation between this [Payment] and the given [Donation]s
  /// by setting each [Donation]'s foreign key `paymentId` to refer to this [Payment].
  Future<void> donations(
    _is.DatabaseSession session,
    Payment payment,
    List<_isunzuoe.Donation> donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('donation.id');
    }
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }

    var $donation = donation
        .map((e) => e.copyWith(paymentId: payment.id))
        .toList();
    await session.db.update<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.paymentId],
      transaction: transaction,
    );
  }
}

class PaymentAttachRowRepository {
  const PaymentAttachRowRepository._();

  /// Creates a relation between the given [Payment] and [Folio]
  /// by setting the [Payment]'s foreign key `folioId` to refer to the [Folio].
  Future<void> folio(
    _is.DatabaseSession session,
    Payment payment,
    _i7r42ton.Folio folio, {
    _is.Transaction? transaction,
  }) async {
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $payment = payment.copyWith(folioId: folio.id);
    await session.db.updateRow<Payment>(
      $payment,
      columns: [Payment.t.folioId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Payment] and [Contact]
  /// by setting the [Payment]'s foreign key `payerId` to refer to the [Contact].
  Future<void> payer(
    _is.DatabaseSession session,
    Payment payment,
    _imbxrfja.Contact payer, {
    _is.Transaction? transaction,
  }) async {
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }
    if (payer.id == null) {
      throw ArgumentError.notNull('payer.id');
    }

    var $payment = payment.copyWith(payerId: payer.id);
    await session.db.updateRow<Payment>(
      $payment,
      columns: [Payment.t.payerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Payment] and the given [Donation]
  /// by setting the [Donation]'s foreign key `paymentId` to refer to this [Payment].
  Future<void> donations(
    _is.DatabaseSession session,
    Payment payment,
    _isunzuoe.Donation donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }

    var $donation = donation.copyWith(paymentId: payment.id);
    await session.db.updateRow<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.paymentId],
      transaction: transaction,
    );
  }
}

class PaymentDetachRepository {
  const PaymentDetachRepository._();

  /// Detaches the relation between this [Payment] and the given [Donation]
  /// by setting the [Donation]'s foreign key `paymentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> donations(
    _is.DatabaseSession session,
    List<_isunzuoe.Donation> donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('donation.id');
    }

    var $donation = donation.map((e) => e.copyWith(paymentId: null)).toList();
    await session.db.update<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.paymentId],
      transaction: transaction,
    );
  }
}

class PaymentDetachRowRepository {
  const PaymentDetachRowRepository._();

  /// Detaches the relation between this [Payment] and the given [Donation]
  /// by setting the [Donation]'s foreign key `paymentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> donations(
    _is.DatabaseSession session,
    _isunzuoe.Donation donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }

    var $donation = donation.copyWith(paymentId: null);
    await session.db.updateRow<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.paymentId],
      transaction: transaction,
    );
  }
}
