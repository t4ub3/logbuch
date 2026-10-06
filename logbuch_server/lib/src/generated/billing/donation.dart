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
import '../billing/donation_source.dart' as _i6ugrixl;
import '../billing/payment.dart' as _i5od23c2;
import '../contacts/contact.dart' as _imbxrfja;
import '../donations/donation_receipt.dart' as _i8tqi4gv;

/// Money a contact gave without getting something for it. Only recorded
/// when the donor said so, never worked out from what was overpaid.
abstract class Donation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Donation._({
    this.id,
    required this.contactId,
    this.contact,
    required this.amount,
    required this.date,
    this.paymentId,
    this.payment,
    required this.source,
    this.receiptId,
    this.receipt,
  });

  factory Donation({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int amount,
    required DateTime date,
    int? paymentId,
    _i5od23c2.Payment? payment,
    required _i6ugrixl.DonationSource source,
    int? receiptId,
    _i8tqi4gv.DonationReceipt? receipt,
  }) = _DonationImpl;

  factory Donation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Donation(
      id: jsonSerialization['id'] as int?,
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
      amount: jsonSerialization['amount'] as int,
      date: _is.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      paymentId: jsonSerialization['paymentId'] as int?,
      payment: jsonSerialization['payment'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i5od23c2.Payment>(
              jsonSerialization['payment'],
            ),
      source: _i6ugrixl.DonationSource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      receiptId: jsonSerialization['receiptId'] as int?,
      receipt: jsonSerialization['receipt'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i8tqi4gv.DonationReceipt>(
              jsonSerialization['receipt'],
            ),
    );
  }

  static final t = DonationTable();

  static const db = DonationRepository._();

  @override
  int? id;

  int contactId;

  _imbxrfja.Contact? contact;

  int amount;

  DateTime date;

  int? paymentId;

  /// The payment the donation was part of, if it was left over from one.
  _i5od23c2.Payment? payment;

  _i6ugrixl.DonationSource source;

  int? receiptId;

  /// The receipt the donation is on. A donation on a receipt cannot be
  /// changed or removed anymore.
  _i8tqi4gv.DonationReceipt? receipt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Donation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Donation copyWith({
    int? id,
    int? contactId,
    _imbxrfja.Contact? contact,
    int? amount,
    DateTime? date,
    int? paymentId,
    _i5od23c2.Payment? payment,
    _i6ugrixl.DonationSource? source,
    int? receiptId,
    _i8tqi4gv.DonationReceipt? receipt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Donation',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
      'amount': amount,
      'date': date.toJson(),
      if (paymentId != null) 'paymentId': paymentId,
      if (payment != null) 'payment': payment?.toJson(),
      'source': source.toJson(),
      if (receiptId != null) 'receiptId': receiptId,
      if (receipt != null) 'receipt': receipt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Donation',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
      'amount': amount,
      'date': date.toJson(),
      if (paymentId != null) 'paymentId': paymentId,
      if (payment != null) 'payment': payment?.toJsonForProtocol(),
      'source': source.toJson(),
      if (receiptId != null) 'receiptId': receiptId,
      if (receipt != null) 'receipt': receipt?.toJsonForProtocol(),
    };
  }

  static DonationInclude include({
    _imbxrfja.ContactInclude? contact,
    _i5od23c2.PaymentInclude? payment,
    _i8tqi4gv.DonationReceiptInclude? receipt,
  }) {
    return DonationInclude._(
      contact: contact,
      payment: payment,
      receipt: receipt,
    );
  }

  static DonationIncludeList includeList({
    _is.WhereExpressionBuilder<DonationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DonationTable>? orderBy,
    _is.OrderByListBuilder<DonationTable>? orderByList,
    DonationInclude? include,
  }) {
    return DonationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Donation.t),
      orderByList: orderByList?.call(Donation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DonationImpl extends Donation {
  _DonationImpl({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int amount,
    required DateTime date,
    int? paymentId,
    _i5od23c2.Payment? payment,
    required _i6ugrixl.DonationSource source,
    int? receiptId,
    _i8tqi4gv.DonationReceipt? receipt,
  }) : super._(
         id: id,
         contactId: contactId,
         contact: contact,
         amount: amount,
         date: date,
         paymentId: paymentId,
         payment: payment,
         source: source,
         receiptId: receiptId,
         receipt: receipt,
       );

  /// Returns a shallow copy of this [Donation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Donation copyWith({
    Object? id = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
    int? amount,
    DateTime? date,
    Object? paymentId = _Undefined,
    Object? payment = _Undefined,
    _i6ugrixl.DonationSource? source,
    Object? receiptId = _Undefined,
    Object? receipt = _Undefined,
  }) {
    return Donation(
      id: id is int? ? id : this.id,
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentId: paymentId is int? ? paymentId : this.paymentId,
      payment: payment is _i5od23c2.Payment?
          ? payment
          : this.payment?.copyWith(),
      source: source ?? this.source,
      receiptId: receiptId is int? ? receiptId : this.receiptId,
      receipt: receipt is _i8tqi4gv.DonationReceipt?
          ? receipt
          : this.receipt?.copyWith(),
    );
  }
}

class DonationUpdateTable extends _is.UpdateTable<DonationTable> {
  DonationUpdateTable(super.table);

  _is.ColumnValue<int, int> contactId(int value) => _is.ColumnValue(
    table.contactId,
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

  _is.ColumnValue<int, int> paymentId(int? value) => _is.ColumnValue(
    table.paymentId,
    value,
  );

  _is.ColumnValue<_i6ugrixl.DonationSource, _i6ugrixl.DonationSource> source(
    _i6ugrixl.DonationSource value,
  ) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<int, int> receiptId(int? value) => _is.ColumnValue(
    table.receiptId,
    value,
  );
}

class DonationTable extends _is.Table<int?> {
  DonationTable({super.tableRelation}) : super(tableName: 'donations') {
    updateTable = DonationUpdateTable(this);
    contactId = _is.ColumnInt(
      'contactId',
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
    paymentId = _is.ColumnInt(
      'paymentId',
      this,
    );
    source = _is.ColumnEnum(
      'source',
      this,
      _is.EnumSerialization.byName,
    );
    receiptId = _is.ColumnInt(
      'receiptId',
      this,
    );
  }

  late final DonationUpdateTable updateTable;

  late final _is.ColumnInt contactId;

  _imbxrfja.ContactTable? _contact;

  late final _is.ColumnInt amount;

  late final _is.ColumnDateTime date;

  late final _is.ColumnInt paymentId;

  /// The payment the donation was part of, if it was left over from one.
  _i5od23c2.PaymentTable? _payment;

  late final _is.ColumnEnum<_i6ugrixl.DonationSource> source;

  late final _is.ColumnInt receiptId;

  /// The receipt the donation is on. A donation on a receipt cannot be
  /// changed or removed anymore.
  _i8tqi4gv.DonationReceiptTable? _receipt;

  _imbxrfja.ContactTable get contact {
    if (_contact != null) return _contact!;
    _contact = _is.createRelationTable(
      relationFieldName: 'contact',
      field: Donation.t.contactId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _contact!;
  }

  _i5od23c2.PaymentTable get payment {
    if (_payment != null) return _payment!;
    _payment = _is.createRelationTable(
      relationFieldName: 'payment',
      field: Donation.t.paymentId,
      foreignField: _i5od23c2.Payment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5od23c2.PaymentTable(tableRelation: foreignTableRelation),
    );
    return _payment!;
  }

  _i8tqi4gv.DonationReceiptTable get receipt {
    if (_receipt != null) return _receipt!;
    _receipt = _is.createRelationTable(
      relationFieldName: 'receipt',
      field: Donation.t.receiptId,
      foreignField: _i8tqi4gv.DonationReceipt.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8tqi4gv.DonationReceiptTable(tableRelation: foreignTableRelation),
    );
    return _receipt!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    contactId,
    amount,
    date,
    paymentId,
    source,
    receiptId,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'contact') {
      return contact;
    }
    if (relationField == 'payment') {
      return payment;
    }
    if (relationField == 'receipt') {
      return receipt;
    }
    return null;
  }
}

class DonationInclude extends _is.IncludeObject {
  DonationInclude._({
    _imbxrfja.ContactInclude? contact,
    _i5od23c2.PaymentInclude? payment,
    _i8tqi4gv.DonationReceiptInclude? receipt,
  }) {
    _contact = contact;
    _payment = payment;
    _receipt = receipt;
  }

  _imbxrfja.ContactInclude? _contact;

  _i5od23c2.PaymentInclude? _payment;

  _i8tqi4gv.DonationReceiptInclude? _receipt;

  @override
  Map<String, _is.Include?> get includes => {
    'contact': _contact,
    'payment': _payment,
    'receipt': _receipt,
  };

  @override
  _is.Table<int?> get table => Donation.t;
}

class DonationIncludeList extends _is.IncludeList {
  DonationIncludeList._({
    _is.WhereExpressionBuilder<DonationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Donation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Donation.t;
}

class DonationRepository {
  const DonationRepository._();

  final attachRow = const DonationAttachRowRepository._();

  final detachRow = const DonationDetachRowRepository._();

  /// Returns a list of [Donation]s matching the given query parameters.
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
  Future<List<Donation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DonationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DonationTable>? orderBy,
    _is.OrderByListBuilder<DonationTable>? orderByList,
    _is.Transaction? transaction,
    DonationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Donation>(
      where: where?.call(Donation.t),
      orderBy: orderBy?.call(Donation.t),
      orderByList: orderByList?.call(Donation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Donation] matching the given query parameters.
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
  Future<Donation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DonationTable>? where,
    int? offset,
    _is.OrderByBuilder<DonationTable>? orderBy,
    _is.OrderByListBuilder<DonationTable>? orderByList,
    _is.Transaction? transaction,
    DonationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Donation>(
      where: where?.call(Donation.t),
      orderBy: orderBy?.call(Donation.t),
      orderByList: orderByList?.call(Donation.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Donation] by its [id] or null if no such row exists.
  Future<Donation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    DonationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Donation>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Donation]s in the list and returns the inserted rows.
  ///
  /// The returned [Donation]s will have their `id` fields set.
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
  Future<List<Donation>> insert(
    _is.DatabaseSession session,
    List<Donation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Donation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Donation] and returns the inserted row.
  ///
  /// The returned [Donation] will have its `id` field set.
  Future<Donation> insertRow(
    _is.DatabaseSession session,
    Donation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Donation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Donation]s in the list and returns the resulting rows.
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
  /// The returned [Donation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Donation>> upsert(
    _is.DatabaseSession session,
    List<Donation> rows, {
    required _is.ColumnSelections<DonationTable> conflictColumns,
    _is.ColumnSelections<DonationTable>? updateColumns,
    _is.WhereExpressionBuilder<DonationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Donation>(
      rows,
      conflictColumns: conflictColumns(Donation.t),
      updateColumns: updateColumns?.call(Donation.t),
      updateWhere: updateWhere?.call(Donation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Donation] and returns the resulting row.
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
  /// The returned [Donation] will have its `id` field set.
  Future<Donation?> upsertRow(
    _is.DatabaseSession session,
    Donation row, {
    required _is.ColumnSelections<DonationTable> conflictColumns,
    _is.ColumnSelections<DonationTable>? updateColumns,
    _is.WhereExpressionBuilder<DonationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Donation>(
      row,
      conflictColumns: conflictColumns(Donation.t),
      updateColumns: updateColumns?.call(Donation.t),
      updateWhere: updateWhere?.call(Donation.t),
      transaction: transaction,
    );
  }

  /// Updates all [Donation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Donation>> update(
    _is.DatabaseSession session,
    List<Donation> rows, {
    _is.ColumnSelections<DonationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Donation>(
      rows,
      columns: columns?.call(Donation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Donation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Donation> updateRow(
    _is.DatabaseSession session,
    Donation row, {
    _is.ColumnSelections<DonationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Donation>(
      row,
      columns: columns?.call(Donation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Donation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Donation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DonationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Donation>(
      id,
      columnValues: columnValues(Donation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Donation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Donation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DonationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DonationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DonationTable>? orderBy,
    _is.OrderByListBuilder<DonationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Donation>(
      columnValues: columnValues(Donation.t.updateTable),
      where: where(Donation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Donation.t),
      orderByList: orderByList?.call(Donation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Donation]s in the list and returns the deleted rows.
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
  Future<List<Donation>> delete(
    _is.DatabaseSession session,
    List<Donation> rows, {
    _is.OrderByBuilder<DonationTable>? orderBy,
    _is.OrderByListBuilder<DonationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Donation>(
      rows,
      orderBy: orderBy?.call(Donation.t),
      orderByList: orderByList?.call(Donation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Donation].
  Future<Donation> deleteRow(
    _is.DatabaseSession session,
    Donation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Donation>(
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
  Future<List<Donation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DonationTable> where,
    _is.OrderByBuilder<DonationTable>? orderBy,
    _is.OrderByListBuilder<DonationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Donation>(
      where: where(Donation.t),
      orderBy: orderBy?.call(Donation.t),
      orderByList: orderByList?.call(Donation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DonationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Donation>(
      where: where?.call(Donation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Donation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DonationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Donation>(
      where: where(Donation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DonationAttachRowRepository {
  const DonationAttachRowRepository._();

  /// Creates a relation between the given [Donation] and [Contact]
  /// by setting the [Donation]'s foreign key `contactId` to refer to the [Contact].
  Future<void> contact(
    _is.DatabaseSession session,
    Donation donation,
    _imbxrfja.Contact contact, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }
    if (contact.id == null) {
      throw ArgumentError.notNull('contact.id');
    }

    var $donation = donation.copyWith(contactId: contact.id);
    await session.db.updateRow<Donation>(
      $donation,
      columns: [Donation.t.contactId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Donation] and [Payment]
  /// by setting the [Donation]'s foreign key `paymentId` to refer to the [Payment].
  Future<void> payment(
    _is.DatabaseSession session,
    Donation donation,
    _i5od23c2.Payment payment, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }

    var $donation = donation.copyWith(paymentId: payment.id);
    await session.db.updateRow<Donation>(
      $donation,
      columns: [Donation.t.paymentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Donation] and [DonationReceipt]
  /// by setting the [Donation]'s foreign key `receiptId` to refer to the [DonationReceipt].
  Future<void> receipt(
    _is.DatabaseSession session,
    Donation donation,
    _i8tqi4gv.DonationReceipt receipt, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }
    if (receipt.id == null) {
      throw ArgumentError.notNull('receipt.id');
    }

    var $donation = donation.copyWith(receiptId: receipt.id);
    await session.db.updateRow<Donation>(
      $donation,
      columns: [Donation.t.receiptId],
      transaction: transaction,
    );
  }
}

class DonationDetachRowRepository {
  const DonationDetachRowRepository._();

  /// Detaches the relation between this [Donation] and the [Payment] set in `payment`
  /// by setting the [Donation]'s foreign key `paymentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> payment(
    _is.DatabaseSession session,
    Donation donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }

    var $donation = donation.copyWith(paymentId: null);
    await session.db.updateRow<Donation>(
      $donation,
      columns: [Donation.t.paymentId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Donation] and the [DonationReceipt] set in `receipt`
  /// by setting the [Donation]'s foreign key `receiptId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> receipt(
    _is.DatabaseSession session,
    Donation donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }

    var $donation = donation.copyWith(receiptId: null);
    await session.db.updateRow<Donation>(
      $donation,
      columns: [Donation.t.receiptId],
      transaction: transaction,
    );
  }
}
