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
import '../billing/folio.dart' as _i7r42ton;

/// The invoice of a folio as a PDF, kept as it was first produced.
abstract class InvoiceDocument
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InvoiceDocument._({
    this.id,
    required this.folioId,
    this.folio,
    required this.pdf,
  });

  factory InvoiceDocument({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    required _idt.ByteData pdf,
  }) = _InvoiceDocumentImpl;

  factory InvoiceDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceDocument(
      id: jsonSerialization['id'] as int?,
      folioId: jsonSerialization['folioId'] as int,
      folio: jsonSerialization['folio'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i7r42ton.Folio>(
              jsonSerialization['folio'],
            ),
      pdf: _is.ByteDataJsonExtension.fromJson(jsonSerialization['pdf']),
    );
  }

  static final t = InvoiceDocumentTable();

  static const db = InvoiceDocumentRepository._();

  @override
  int? id;

  int folioId;

  _i7r42ton.Folio? folio;

  _idt.ByteData pdf;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InvoiceDocument]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvoiceDocument copyWith({
    int? id,
    int? folioId,
    _i7r42ton.Folio? folio,
    _idt.ByteData? pdf,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceDocument',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJson(),
      'pdf': pdf.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static InvoiceDocumentInclude include({_i7r42ton.FolioInclude? folio}) {
    return InvoiceDocumentInclude._(folio: folio);
  }

  static InvoiceDocumentIncludeList includeList({
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceDocumentTable>? orderBy,
    _is.OrderByListBuilder<InvoiceDocumentTable>? orderByList,
    InvoiceDocumentInclude? include,
  }) {
    return InvoiceDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InvoiceDocument.t),
      orderByList: orderByList?.call(InvoiceDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceDocumentImpl extends InvoiceDocument {
  _InvoiceDocumentImpl({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    required _idt.ByteData pdf,
  }) : super._(
         id: id,
         folioId: folioId,
         folio: folio,
         pdf: pdf,
       );

  /// Returns a shallow copy of this [InvoiceDocument]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvoiceDocument copyWith({
    Object? id = _Undefined,
    int? folioId,
    Object? folio = _Undefined,
    _idt.ByteData? pdf,
  }) {
    return InvoiceDocument(
      id: id is int? ? id : this.id,
      folioId: folioId ?? this.folioId,
      folio: folio is _i7r42ton.Folio? ? folio : this.folio?.copyWith(),
      pdf: pdf ?? this.pdf.clone(),
    );
  }
}

class InvoiceDocumentUpdateTable extends _is.UpdateTable<InvoiceDocumentTable> {
  InvoiceDocumentUpdateTable(super.table);

  _is.ColumnValue<int, int> folioId(int value) => _is.ColumnValue(
    table.folioId,
    value,
  );

  _is.ColumnValue<_idt.ByteData, _idt.ByteData> pdf(_idt.ByteData value) =>
      _is.ColumnValue(
        table.pdf,
        value,
      );
}

class InvoiceDocumentTable extends _is.Table<int?> {
  InvoiceDocumentTable({super.tableRelation})
    : super(tableName: 'invoice_documents') {
    updateTable = InvoiceDocumentUpdateTable(this);
    folioId = _is.ColumnInt(
      'folioId',
      this,
    );
    pdf = _is.ColumnByteData(
      'pdf',
      this,
    );
  }

  late final InvoiceDocumentUpdateTable updateTable;

  late final _is.ColumnInt folioId;

  _i7r42ton.FolioTable? _folio;

  late final _is.ColumnByteData pdf;

  _i7r42ton.FolioTable get folio {
    if (_folio != null) return _folio!;
    _folio = _is.createRelationTable(
      relationFieldName: 'folio',
      field: InvoiceDocument.t.folioId,
      foreignField: _i7r42ton.Folio.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7r42ton.FolioTable(tableRelation: foreignTableRelation),
    );
    return _folio!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    folioId,
    pdf,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'folio') {
      return folio;
    }
    return null;
  }
}

class InvoiceDocumentInclude extends _is.IncludeObject {
  InvoiceDocumentInclude._({_i7r42ton.FolioInclude? folio}) {
    _folio = folio;
  }

  _i7r42ton.FolioInclude? _folio;

  @override
  Map<String, _is.Include?> get includes => {'folio': _folio};

  @override
  _is.Table<int?> get table => InvoiceDocument.t;
}

class InvoiceDocumentIncludeList extends _is.IncludeList {
  InvoiceDocumentIncludeList._({
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InvoiceDocument.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InvoiceDocument.t;
}

class InvoiceDocumentRepository {
  const InvoiceDocumentRepository._();

  final attachRow = const InvoiceDocumentAttachRowRepository._();

  /// Returns a list of [InvoiceDocument]s matching the given query parameters.
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
  Future<List<InvoiceDocument>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceDocumentTable>? orderBy,
    _is.OrderByListBuilder<InvoiceDocumentTable>? orderByList,
    _is.Transaction? transaction,
    InvoiceDocumentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InvoiceDocument>(
      where: where?.call(InvoiceDocument.t),
      orderBy: orderBy?.call(InvoiceDocument.t),
      orderByList: orderByList?.call(InvoiceDocument.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InvoiceDocument] matching the given query parameters.
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
  Future<InvoiceDocument?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? where,
    int? offset,
    _is.OrderByBuilder<InvoiceDocumentTable>? orderBy,
    _is.OrderByListBuilder<InvoiceDocumentTable>? orderByList,
    _is.Transaction? transaction,
    InvoiceDocumentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InvoiceDocument>(
      where: where?.call(InvoiceDocument.t),
      orderBy: orderBy?.call(InvoiceDocument.t),
      orderByList: orderByList?.call(InvoiceDocument.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InvoiceDocument] by its [id] or null if no such row exists.
  Future<InvoiceDocument?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    InvoiceDocumentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InvoiceDocument>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InvoiceDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [InvoiceDocument]s will have their `id` fields set.
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
  Future<List<InvoiceDocument>> insert(
    _is.DatabaseSession session,
    List<InvoiceDocument> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InvoiceDocument>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InvoiceDocument] and returns the inserted row.
  ///
  /// The returned [InvoiceDocument] will have its `id` field set.
  Future<InvoiceDocument> insertRow(
    _is.DatabaseSession session,
    InvoiceDocument row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InvoiceDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InvoiceDocument]s in the list and returns the resulting rows.
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
  /// The returned [InvoiceDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InvoiceDocument>> upsert(
    _is.DatabaseSession session,
    List<InvoiceDocument> rows, {
    required _is.ColumnSelections<InvoiceDocumentTable> conflictColumns,
    _is.ColumnSelections<InvoiceDocumentTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InvoiceDocument>(
      rows,
      conflictColumns: conflictColumns(InvoiceDocument.t),
      updateColumns: updateColumns?.call(InvoiceDocument.t),
      updateWhere: updateWhere?.call(InvoiceDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InvoiceDocument] and returns the resulting row.
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
  /// The returned [InvoiceDocument] will have its `id` field set.
  Future<InvoiceDocument?> upsertRow(
    _is.DatabaseSession session,
    InvoiceDocument row, {
    required _is.ColumnSelections<InvoiceDocumentTable> conflictColumns,
    _is.ColumnSelections<InvoiceDocumentTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InvoiceDocument>(
      row,
      conflictColumns: conflictColumns(InvoiceDocument.t),
      updateColumns: updateColumns?.call(InvoiceDocument.t),
      updateWhere: updateWhere?.call(InvoiceDocument.t),
      transaction: transaction,
    );
  }

  /// Updates all [InvoiceDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InvoiceDocument>> update(
    _is.DatabaseSession session,
    List<InvoiceDocument> rows, {
    _is.ColumnSelections<InvoiceDocumentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InvoiceDocument>(
      rows,
      columns: columns?.call(InvoiceDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InvoiceDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InvoiceDocument> updateRow(
    _is.DatabaseSession session,
    InvoiceDocument row, {
    _is.ColumnSelections<InvoiceDocumentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InvoiceDocument>(
      row,
      columns: columns?.call(InvoiceDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InvoiceDocument] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InvoiceDocument?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InvoiceDocumentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InvoiceDocument>(
      id,
      columnValues: columnValues(InvoiceDocument.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InvoiceDocument]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InvoiceDocument>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InvoiceDocumentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InvoiceDocumentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceDocumentTable>? orderBy,
    _is.OrderByListBuilder<InvoiceDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InvoiceDocument>(
      columnValues: columnValues(InvoiceDocument.t.updateTable),
      where: where(InvoiceDocument.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InvoiceDocument.t),
      orderByList: orderByList?.call(InvoiceDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InvoiceDocument]s in the list and returns the deleted rows.
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
  Future<List<InvoiceDocument>> delete(
    _is.DatabaseSession session,
    List<InvoiceDocument> rows, {
    _is.OrderByBuilder<InvoiceDocumentTable>? orderBy,
    _is.OrderByListBuilder<InvoiceDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InvoiceDocument>(
      rows,
      orderBy: orderBy?.call(InvoiceDocument.t),
      orderByList: orderByList?.call(InvoiceDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InvoiceDocument].
  Future<InvoiceDocument> deleteRow(
    _is.DatabaseSession session,
    InvoiceDocument row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InvoiceDocument>(
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
  Future<List<InvoiceDocument>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceDocumentTable> where,
    _is.OrderByBuilder<InvoiceDocumentTable>? orderBy,
    _is.OrderByListBuilder<InvoiceDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InvoiceDocument>(
      where: where(InvoiceDocument.t),
      orderBy: orderBy?.call(InvoiceDocument.t),
      orderByList: orderByList?.call(InvoiceDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceDocumentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InvoiceDocument>(
      where: where?.call(InvoiceDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InvoiceDocument] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceDocumentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InvoiceDocument>(
      where: where(InvoiceDocument.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class InvoiceDocumentAttachRowRepository {
  const InvoiceDocumentAttachRowRepository._();

  /// Creates a relation between the given [InvoiceDocument] and [Folio]
  /// by setting the [InvoiceDocument]'s foreign key `folioId` to refer to the [Folio].
  Future<void> folio(
    _is.DatabaseSession session,
    InvoiceDocument invoiceDocument,
    _i7r42ton.Folio folio, {
    _is.Transaction? transaction,
  }) async {
    if (invoiceDocument.id == null) {
      throw ArgumentError.notNull('invoiceDocument.id');
    }
    if (folio.id == null) {
      throw ArgumentError.notNull('folio.id');
    }

    var $invoiceDocument = invoiceDocument.copyWith(folioId: folio.id);
    await session.db.updateRow<InvoiceDocument>(
      $invoiceDocument,
      columns: [InvoiceDocument.t.folioId],
      transaction: transaction,
    );
  }
}
