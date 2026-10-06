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
import 'dart:typed_data' as _idt;
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../billing/donation.dart' as _isunzuoe;
import '../contacts/contact.dart' as _imbxrfja;

/// The receipt for all donations of a contact in one year
/// (Sammelbestaetigung). Once it is issued, its donations cannot change.
abstract class DonationReceipt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DonationReceipt._({
    this.id,
    required this.contactId,
    this.contact,
    required this.year,
    required this.number,
    required this.total,
    required this.issuedAt,
    this.pdf,
    this.donations,
  });

  factory DonationReceipt({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int year,
    required String number,
    required int total,
    required DateTime issuedAt,
    _idt.ByteData? pdf,
    List<_isunzuoe.Donation>? donations,
  }) = _DonationReceiptImpl;

  factory DonationReceipt.fromJson(Map<String, dynamic> jsonSerialization) {
    return DonationReceipt(
      id: jsonSerialization['id'] as int?,
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
      year: jsonSerialization['year'] as int,
      number: jsonSerialization['number'] as String,
      total: jsonSerialization['total'] as int,
      issuedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      pdf: jsonSerialization['pdf'] == null
          ? null
          : _is.ByteDataJsonExtension.fromJson(jsonSerialization['pdf']),
      donations: jsonSerialization['donations'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_isunzuoe.Donation>>(
              jsonSerialization['donations'],
            ),
    );
  }

  static final t = DonationReceiptTable();

  static const db = DonationReceiptRepository._();

  @override
  int? id;

  int contactId;

  _imbxrfja.Contact? contact;

  int year;

  String number;

  int total;

  /// The day the receipt was issued.
  DateTime issuedAt;

  /// The document as it was issued. Read with the endpoint, as it is too
  /// large to travel with every receipt.
  _idt.ByteData? pdf;

  List<_isunzuoe.Donation>? donations;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DonationReceipt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DonationReceipt copyWith({
    int? id,
    int? contactId,
    _imbxrfja.Contact? contact,
    int? year,
    String? number,
    int? total,
    DateTime? issuedAt,
    _idt.ByteData? pdf,
    List<_isunzuoe.Donation>? donations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DonationReceipt',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
      'year': year,
      'number': number,
      'total': total,
      'issuedAt': issuedAt.toJson(),
      if (pdf != null) 'pdf': pdf?.toJson(),
      if (donations != null)
        'donations': donations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DonationReceipt',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
      'year': year,
      'number': number,
      'total': total,
      'issuedAt': issuedAt.toJson(),
      if (donations != null)
        'donations': donations?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static DonationReceiptInclude include({
    _imbxrfja.ContactInclude? contact,
    _isunzuoe.DonationIncludeList? donations,
  }) {
    return DonationReceiptInclude._(
      contact: contact,
      donations: donations,
    );
  }

  static DonationReceiptIncludeList includeList({
    _is.WhereExpressionBuilder<DonationReceiptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DonationReceiptTable>? orderBy,
    _is.OrderByListBuilder<DonationReceiptTable>? orderByList,
    DonationReceiptInclude? include,
  }) {
    return DonationReceiptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DonationReceipt.t),
      orderByList: orderByList?.call(DonationReceipt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DonationReceiptImpl extends DonationReceipt {
  _DonationReceiptImpl({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int year,
    required String number,
    required int total,
    required DateTime issuedAt,
    _idt.ByteData? pdf,
    List<_isunzuoe.Donation>? donations,
  }) : super._(
         id: id,
         contactId: contactId,
         contact: contact,
         year: year,
         number: number,
         total: total,
         issuedAt: issuedAt,
         pdf: pdf,
         donations: donations,
       );

  /// Returns a shallow copy of this [DonationReceipt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DonationReceipt copyWith({
    Object? id = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
    int? year,
    String? number,
    int? total,
    DateTime? issuedAt,
    Object? pdf = _Undefined,
    Object? donations = _Undefined,
  }) {
    return DonationReceipt(
      id: id is int? ? id : this.id,
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
      year: year ?? this.year,
      number: number ?? this.number,
      total: total ?? this.total,
      issuedAt: issuedAt ?? this.issuedAt,
      pdf: pdf is _idt.ByteData? ? pdf : this.pdf?.clone(),
      donations: donations is List<_isunzuoe.Donation>?
          ? donations
          : this.donations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class DonationReceiptUpdateTable extends _is.UpdateTable<DonationReceiptTable> {
  DonationReceiptUpdateTable(super.table);

  _is.ColumnValue<int, int> contactId(int value) => _is.ColumnValue(
    table.contactId,
    value,
  );

  _is.ColumnValue<int, int> year(int value) => _is.ColumnValue(
    table.year,
    value,
  );

  _is.ColumnValue<String, String> number(String value) => _is.ColumnValue(
    table.number,
    value,
  );

  _is.ColumnValue<int, int> total(int value) => _is.ColumnValue(
    table.total,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _is.ColumnValue(
        table.issuedAt,
        value,
      );

  _is.ColumnValue<_idt.ByteData, _idt.ByteData> pdf(_idt.ByteData? value) =>
      _is.ColumnValue(
        table.pdf,
        value,
      );
}

class DonationReceiptTable extends _is.Table<int?> {
  DonationReceiptTable({super.tableRelation})
    : super(tableName: 'donation_receipts') {
    updateTable = DonationReceiptUpdateTable(this);
    contactId = _is.ColumnInt(
      'contactId',
      this,
    );
    year = _is.ColumnInt(
      'year',
      this,
    );
    number = _is.ColumnString(
      'number',
      this,
    );
    total = _is.ColumnInt(
      'total',
      this,
    );
    issuedAt = _is.ColumnDateTime(
      'issuedAt',
      this,
    );
    pdf = _is.ColumnByteData(
      'pdf',
      this,
    );
  }

  late final DonationReceiptUpdateTable updateTable;

  late final _is.ColumnInt contactId;

  _imbxrfja.ContactTable? _contact;

  late final _is.ColumnInt year;

  late final _is.ColumnString number;

  late final _is.ColumnInt total;

  /// The day the receipt was issued.
  late final _is.ColumnDateTime issuedAt;

  /// The document as it was issued. Read with the endpoint, as it is too
  /// large to travel with every receipt.
  late final _is.ColumnByteData pdf;

  _isunzuoe.DonationTable? ___donations;

  _is.ManyRelation<_isunzuoe.DonationTable>? _donations;

  _imbxrfja.ContactTable get contact {
    if (_contact != null) return _contact!;
    _contact = _is.createRelationTable(
      relationFieldName: 'contact',
      field: DonationReceipt.t.contactId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _contact!;
  }

  _isunzuoe.DonationTable get __donations {
    if (___donations != null) return ___donations!;
    ___donations = _is.createRelationTable(
      relationFieldName: '__donations',
      field: DonationReceipt.t.id,
      foreignField: _isunzuoe.Donation.t.receiptId,
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
      field: DonationReceipt.t.id,
      foreignField: _isunzuoe.Donation.t.receiptId,
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
    contactId,
    year,
    number,
    total,
    issuedAt,
    pdf,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'contact') {
      return contact;
    }
    if (relationField == 'donations') {
      return __donations;
    }
    return null;
  }
}

class DonationReceiptInclude extends _is.IncludeObject {
  DonationReceiptInclude._({
    _imbxrfja.ContactInclude? contact,
    _isunzuoe.DonationIncludeList? donations,
  }) {
    _contact = contact;
    _donations = donations;
  }

  _imbxrfja.ContactInclude? _contact;

  _isunzuoe.DonationIncludeList? _donations;

  @override
  Map<String, _is.Include?> get includes => {
    'contact': _contact,
    'donations': _donations,
  };

  @override
  _is.Table<int?> get table => DonationReceipt.t;
}

class DonationReceiptIncludeList extends _is.IncludeList {
  DonationReceiptIncludeList._({
    _is.WhereExpressionBuilder<DonationReceiptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DonationReceipt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DonationReceipt.t;
}

class DonationReceiptRepository {
  const DonationReceiptRepository._();

  final attach = const DonationReceiptAttachRepository._();

  final attachRow = const DonationReceiptAttachRowRepository._();

  final detach = const DonationReceiptDetachRepository._();

  final detachRow = const DonationReceiptDetachRowRepository._();

  /// Returns a list of [DonationReceipt]s matching the given query parameters.
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
  Future<List<DonationReceipt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DonationReceiptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DonationReceiptTable>? orderBy,
    _is.OrderByListBuilder<DonationReceiptTable>? orderByList,
    _is.Transaction? transaction,
    DonationReceiptInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DonationReceipt>(
      where: where?.call(DonationReceipt.t),
      orderBy: orderBy?.call(DonationReceipt.t),
      orderByList: orderByList?.call(DonationReceipt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DonationReceipt] matching the given query parameters.
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
  Future<DonationReceipt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DonationReceiptTable>? where,
    int? offset,
    _is.OrderByBuilder<DonationReceiptTable>? orderBy,
    _is.OrderByListBuilder<DonationReceiptTable>? orderByList,
    _is.Transaction? transaction,
    DonationReceiptInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DonationReceipt>(
      where: where?.call(DonationReceipt.t),
      orderBy: orderBy?.call(DonationReceipt.t),
      orderByList: orderByList?.call(DonationReceipt.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DonationReceipt] by its [id] or null if no such row exists.
  Future<DonationReceipt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    DonationReceiptInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DonationReceipt>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DonationReceipt]s in the list and returns the inserted rows.
  ///
  /// The returned [DonationReceipt]s will have their `id` fields set.
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
  Future<List<DonationReceipt>> insert(
    _is.DatabaseSession session,
    List<DonationReceipt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DonationReceipt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DonationReceipt] and returns the inserted row.
  ///
  /// The returned [DonationReceipt] will have its `id` field set.
  Future<DonationReceipt> insertRow(
    _is.DatabaseSession session,
    DonationReceipt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DonationReceipt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DonationReceipt]s in the list and returns the resulting rows.
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
  /// The returned [DonationReceipt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DonationReceipt>> upsert(
    _is.DatabaseSession session,
    List<DonationReceipt> rows, {
    required _is.ColumnSelections<DonationReceiptTable> conflictColumns,
    _is.ColumnSelections<DonationReceiptTable>? updateColumns,
    _is.WhereExpressionBuilder<DonationReceiptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DonationReceipt>(
      rows,
      conflictColumns: conflictColumns(DonationReceipt.t),
      updateColumns: updateColumns?.call(DonationReceipt.t),
      updateWhere: updateWhere?.call(DonationReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DonationReceipt] and returns the resulting row.
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
  /// The returned [DonationReceipt] will have its `id` field set.
  Future<DonationReceipt?> upsertRow(
    _is.DatabaseSession session,
    DonationReceipt row, {
    required _is.ColumnSelections<DonationReceiptTable> conflictColumns,
    _is.ColumnSelections<DonationReceiptTable>? updateColumns,
    _is.WhereExpressionBuilder<DonationReceiptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DonationReceipt>(
      row,
      conflictColumns: conflictColumns(DonationReceipt.t),
      updateColumns: updateColumns?.call(DonationReceipt.t),
      updateWhere: updateWhere?.call(DonationReceipt.t),
      transaction: transaction,
    );
  }

  /// Updates all [DonationReceipt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DonationReceipt>> update(
    _is.DatabaseSession session,
    List<DonationReceipt> rows, {
    _is.ColumnSelections<DonationReceiptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DonationReceipt>(
      rows,
      columns: columns?.call(DonationReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DonationReceipt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DonationReceipt> updateRow(
    _is.DatabaseSession session,
    DonationReceipt row, {
    _is.ColumnSelections<DonationReceiptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DonationReceipt>(
      row,
      columns: columns?.call(DonationReceipt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DonationReceipt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DonationReceipt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DonationReceiptUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DonationReceipt>(
      id,
      columnValues: columnValues(DonationReceipt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DonationReceipt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DonationReceipt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DonationReceiptUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DonationReceiptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DonationReceiptTable>? orderBy,
    _is.OrderByListBuilder<DonationReceiptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DonationReceipt>(
      columnValues: columnValues(DonationReceipt.t.updateTable),
      where: where(DonationReceipt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DonationReceipt.t),
      orderByList: orderByList?.call(DonationReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DonationReceipt]s in the list and returns the deleted rows.
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
  Future<List<DonationReceipt>> delete(
    _is.DatabaseSession session,
    List<DonationReceipt> rows, {
    _is.OrderByBuilder<DonationReceiptTable>? orderBy,
    _is.OrderByListBuilder<DonationReceiptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DonationReceipt>(
      rows,
      orderBy: orderBy?.call(DonationReceipt.t),
      orderByList: orderByList?.call(DonationReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DonationReceipt].
  Future<DonationReceipt> deleteRow(
    _is.DatabaseSession session,
    DonationReceipt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DonationReceipt>(
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
  Future<List<DonationReceipt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DonationReceiptTable> where,
    _is.OrderByBuilder<DonationReceiptTable>? orderBy,
    _is.OrderByListBuilder<DonationReceiptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DonationReceipt>(
      where: where(DonationReceipt.t),
      orderBy: orderBy?.call(DonationReceipt.t),
      orderByList: orderByList?.call(DonationReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DonationReceiptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DonationReceipt>(
      where: where?.call(DonationReceipt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DonationReceipt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DonationReceiptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DonationReceipt>(
      where: where(DonationReceipt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DonationReceiptAttachRepository {
  const DonationReceiptAttachRepository._();

  /// Creates a relation between this [DonationReceipt] and the given [Donation]s
  /// by setting each [Donation]'s foreign key `receiptId` to refer to this [DonationReceipt].
  Future<void> donations(
    _is.DatabaseSession session,
    DonationReceipt donationReceipt,
    List<_isunzuoe.Donation> donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('donation.id');
    }
    if (donationReceipt.id == null) {
      throw ArgumentError.notNull('donationReceipt.id');
    }

    var $donation = donation
        .map((e) => e.copyWith(receiptId: donationReceipt.id))
        .toList();
    await session.db.update<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.receiptId],
      transaction: transaction,
    );
  }
}

class DonationReceiptAttachRowRepository {
  const DonationReceiptAttachRowRepository._();

  /// Creates a relation between the given [DonationReceipt] and [Contact]
  /// by setting the [DonationReceipt]'s foreign key `contactId` to refer to the [Contact].
  Future<void> contact(
    _is.DatabaseSession session,
    DonationReceipt donationReceipt,
    _imbxrfja.Contact contact, {
    _is.Transaction? transaction,
  }) async {
    if (donationReceipt.id == null) {
      throw ArgumentError.notNull('donationReceipt.id');
    }
    if (contact.id == null) {
      throw ArgumentError.notNull('contact.id');
    }

    var $donationReceipt = donationReceipt.copyWith(contactId: contact.id);
    await session.db.updateRow<DonationReceipt>(
      $donationReceipt,
      columns: [DonationReceipt.t.contactId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [DonationReceipt] and the given [Donation]
  /// by setting the [Donation]'s foreign key `receiptId` to refer to this [DonationReceipt].
  Future<void> donations(
    _is.DatabaseSession session,
    DonationReceipt donationReceipt,
    _isunzuoe.Donation donation, {
    _is.Transaction? transaction,
  }) async {
    if (donation.id == null) {
      throw ArgumentError.notNull('donation.id');
    }
    if (donationReceipt.id == null) {
      throw ArgumentError.notNull('donationReceipt.id');
    }

    var $donation = donation.copyWith(receiptId: donationReceipt.id);
    await session.db.updateRow<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.receiptId],
      transaction: transaction,
    );
  }
}

class DonationReceiptDetachRepository {
  const DonationReceiptDetachRepository._();

  /// Detaches the relation between this [DonationReceipt] and the given [Donation]
  /// by setting the [Donation]'s foreign key `receiptId` to `null`.
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

    var $donation = donation.map((e) => e.copyWith(receiptId: null)).toList();
    await session.db.update<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.receiptId],
      transaction: transaction,
    );
  }
}

class DonationReceiptDetachRowRepository {
  const DonationReceiptDetachRowRepository._();

  /// Detaches the relation between this [DonationReceipt] and the given [Donation]
  /// by setting the [Donation]'s foreign key `receiptId` to `null`.
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

    var $donation = donation.copyWith(receiptId: null);
    await session.db.updateRow<_isunzuoe.Donation>(
      $donation,
      columns: [_isunzuoe.Donation.t.receiptId],
      transaction: transaction,
    );
  }
}
