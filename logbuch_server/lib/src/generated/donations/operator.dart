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
import '../donations/tax_notice_type.dart' as _i8bqfpik;

/// The organisation that runs the house. Its details are printed on
/// donation receipts.
abstract class Operator
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Operator._({
    this.id,
    required this.name,
    required this.street,
    required this.zip,
    required this.city,
    required this.taxOffice,
    required this.taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    this.noticeDate,
    this.assessmentPeriod,
    required this.purposes,
    this.purposesObject,
    required this.place,
    this.signatory,
  }) : noticeType = noticeType ?? _i8bqfpik.TaxNoticeType.statutoryCompliance;

  factory Operator({
    int? id,
    required String name,
    required String street,
    required String zip,
    required String city,
    required String taxOffice,
    required String taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    DateTime? noticeDate,
    String? assessmentPeriod,
    required String purposes,
    String? purposesObject,
    required String place,
    String? signatory,
  }) = _OperatorImpl;

  factory Operator.fromJson(Map<String, dynamic> jsonSerialization) {
    return Operator(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      street: jsonSerialization['street'] as String,
      zip: jsonSerialization['zip'] as String,
      city: jsonSerialization['city'] as String,
      taxOffice: jsonSerialization['taxOffice'] as String,
      taxNumber: jsonSerialization['taxNumber'] as String,
      noticeType: jsonSerialization['noticeType'] == null
          ? null
          : _i8bqfpik.TaxNoticeType.fromJson(
              (jsonSerialization['noticeType'] as String),
            ),
      noticeDate: jsonSerialization['noticeDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['noticeDate']),
      assessmentPeriod: jsonSerialization['assessmentPeriod'] as String?,
      purposes: jsonSerialization['purposes'] as String,
      purposesObject: jsonSerialization['purposesObject'] as String?,
      place: jsonSerialization['place'] as String,
      signatory: jsonSerialization['signatory'] as String?,
    );
  }

  static final t = OperatorTable();

  static const db = OperatorRepository._();

  @override
  int? id;

  String name;

  String street;

  String zip;

  String city;

  String taxOffice;

  String taxNumber;

  _i8bqfpik.TaxNoticeType noticeType;

  DateTime? noticeDate;

  /// The year an exemption notice was issued for.
  String? assessmentPeriod;

  /// What the operator promotes, worded to follow "zur Foerderung", such as
  /// "der Jugendhilfe".
  String purposes;

  /// The same, worded to follow "Wir foerdern nach unserer Satzung", such
  /// as "die Jugendhilfe". Only a notice by Paragraph 60a AO needs it.
  String? purposesObject;

  /// Where receipts are signed.
  String place;

  /// Who signs the receipts.
  String? signatory;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Operator]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Operator copyWith({
    int? id,
    String? name,
    String? street,
    String? zip,
    String? city,
    String? taxOffice,
    String? taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    DateTime? noticeDate,
    String? assessmentPeriod,
    String? purposes,
    String? purposesObject,
    String? place,
    String? signatory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Operator',
      if (id != null) 'id': id,
      'name': name,
      'street': street,
      'zip': zip,
      'city': city,
      'taxOffice': taxOffice,
      'taxNumber': taxNumber,
      'noticeType': noticeType.toJson(),
      if (noticeDate != null) 'noticeDate': noticeDate?.toJson(),
      if (assessmentPeriod != null) 'assessmentPeriod': assessmentPeriod,
      'purposes': purposes,
      if (purposesObject != null) 'purposesObject': purposesObject,
      'place': place,
      if (signatory != null) 'signatory': signatory,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Operator',
      if (id != null) 'id': id,
      'name': name,
      'street': street,
      'zip': zip,
      'city': city,
      'taxOffice': taxOffice,
      'taxNumber': taxNumber,
      'noticeType': noticeType.toJson(),
      if (noticeDate != null) 'noticeDate': noticeDate?.toJson(),
      if (assessmentPeriod != null) 'assessmentPeriod': assessmentPeriod,
      'purposes': purposes,
      if (purposesObject != null) 'purposesObject': purposesObject,
      'place': place,
      if (signatory != null) 'signatory': signatory,
    };
  }

  static OperatorInclude include() {
    return OperatorInclude._();
  }

  static OperatorIncludeList includeList({
    _is.WhereExpressionBuilder<OperatorTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OperatorTable>? orderBy,
    _is.OrderByListBuilder<OperatorTable>? orderByList,
    OperatorInclude? include,
  }) {
    return OperatorIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Operator.t),
      orderByList: orderByList?.call(Operator.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OperatorImpl extends Operator {
  _OperatorImpl({
    int? id,
    required String name,
    required String street,
    required String zip,
    required String city,
    required String taxOffice,
    required String taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    DateTime? noticeDate,
    String? assessmentPeriod,
    required String purposes,
    String? purposesObject,
    required String place,
    String? signatory,
  }) : super._(
         id: id,
         name: name,
         street: street,
         zip: zip,
         city: city,
         taxOffice: taxOffice,
         taxNumber: taxNumber,
         noticeType: noticeType,
         noticeDate: noticeDate,
         assessmentPeriod: assessmentPeriod,
         purposes: purposes,
         purposesObject: purposesObject,
         place: place,
         signatory: signatory,
       );

  /// Returns a shallow copy of this [Operator]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Operator copyWith({
    Object? id = _Undefined,
    String? name,
    String? street,
    String? zip,
    String? city,
    String? taxOffice,
    String? taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    Object? noticeDate = _Undefined,
    Object? assessmentPeriod = _Undefined,
    String? purposes,
    Object? purposesObject = _Undefined,
    String? place,
    Object? signatory = _Undefined,
  }) {
    return Operator(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      street: street ?? this.street,
      zip: zip ?? this.zip,
      city: city ?? this.city,
      taxOffice: taxOffice ?? this.taxOffice,
      taxNumber: taxNumber ?? this.taxNumber,
      noticeType: noticeType ?? this.noticeType,
      noticeDate: noticeDate is DateTime? ? noticeDate : this.noticeDate,
      assessmentPeriod: assessmentPeriod is String?
          ? assessmentPeriod
          : this.assessmentPeriod,
      purposes: purposes ?? this.purposes,
      purposesObject: purposesObject is String?
          ? purposesObject
          : this.purposesObject,
      place: place ?? this.place,
      signatory: signatory is String? ? signatory : this.signatory,
    );
  }
}

class OperatorUpdateTable extends _is.UpdateTable<OperatorTable> {
  OperatorUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> street(String value) => _is.ColumnValue(
    table.street,
    value,
  );

  _is.ColumnValue<String, String> zip(String value) => _is.ColumnValue(
    table.zip,
    value,
  );

  _is.ColumnValue<String, String> city(String value) => _is.ColumnValue(
    table.city,
    value,
  );

  _is.ColumnValue<String, String> taxOffice(String value) => _is.ColumnValue(
    table.taxOffice,
    value,
  );

  _is.ColumnValue<String, String> taxNumber(String value) => _is.ColumnValue(
    table.taxNumber,
    value,
  );

  _is.ColumnValue<_i8bqfpik.TaxNoticeType, _i8bqfpik.TaxNoticeType> noticeType(
    _i8bqfpik.TaxNoticeType value,
  ) => _is.ColumnValue(
    table.noticeType,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> noticeDate(DateTime? value) =>
      _is.ColumnValue(
        table.noticeDate,
        value,
      );

  _is.ColumnValue<String, String> assessmentPeriod(String? value) =>
      _is.ColumnValue(
        table.assessmentPeriod,
        value,
      );

  _is.ColumnValue<String, String> purposes(String value) => _is.ColumnValue(
    table.purposes,
    value,
  );

  _is.ColumnValue<String, String> purposesObject(String? value) =>
      _is.ColumnValue(
        table.purposesObject,
        value,
      );

  _is.ColumnValue<String, String> place(String value) => _is.ColumnValue(
    table.place,
    value,
  );

  _is.ColumnValue<String, String> signatory(String? value) => _is.ColumnValue(
    table.signatory,
    value,
  );
}

class OperatorTable extends _is.Table<int?> {
  OperatorTable({super.tableRelation}) : super(tableName: 'operator') {
    updateTable = OperatorUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    street = _is.ColumnString(
      'street',
      this,
    );
    zip = _is.ColumnString(
      'zip',
      this,
    );
    city = _is.ColumnString(
      'city',
      this,
    );
    taxOffice = _is.ColumnString(
      'taxOffice',
      this,
    );
    taxNumber = _is.ColumnString(
      'taxNumber',
      this,
    );
    noticeType = _is.ColumnEnum(
      'noticeType',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    noticeDate = _is.ColumnDateTime(
      'noticeDate',
      this,
    );
    assessmentPeriod = _is.ColumnString(
      'assessmentPeriod',
      this,
    );
    purposes = _is.ColumnString(
      'purposes',
      this,
    );
    purposesObject = _is.ColumnString(
      'purposesObject',
      this,
    );
    place = _is.ColumnString(
      'place',
      this,
    );
    signatory = _is.ColumnString(
      'signatory',
      this,
    );
  }

  late final OperatorUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString street;

  late final _is.ColumnString zip;

  late final _is.ColumnString city;

  late final _is.ColumnString taxOffice;

  late final _is.ColumnString taxNumber;

  late final _is.ColumnEnum<_i8bqfpik.TaxNoticeType> noticeType;

  late final _is.ColumnDateTime noticeDate;

  /// The year an exemption notice was issued for.
  late final _is.ColumnString assessmentPeriod;

  /// What the operator promotes, worded to follow "zur Foerderung", such as
  /// "der Jugendhilfe".
  late final _is.ColumnString purposes;

  /// The same, worded to follow "Wir foerdern nach unserer Satzung", such
  /// as "die Jugendhilfe". Only a notice by Paragraph 60a AO needs it.
  late final _is.ColumnString purposesObject;

  /// Where receipts are signed.
  late final _is.ColumnString place;

  /// Who signs the receipts.
  late final _is.ColumnString signatory;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    street,
    zip,
    city,
    taxOffice,
    taxNumber,
    noticeType,
    noticeDate,
    assessmentPeriod,
    purposes,
    purposesObject,
    place,
    signatory,
  ];
}

class OperatorInclude extends _is.IncludeObject {
  OperatorInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Operator.t;
}

class OperatorIncludeList extends _is.IncludeList {
  OperatorIncludeList._({
    _is.WhereExpressionBuilder<OperatorTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Operator.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Operator.t;
}

class OperatorRepository {
  const OperatorRepository._();

  /// Returns a list of [Operator]s matching the given query parameters.
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
  Future<List<Operator>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OperatorTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OperatorTable>? orderBy,
    _is.OrderByListBuilder<OperatorTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Operator>(
      where: where?.call(Operator.t),
      orderBy: orderBy?.call(Operator.t),
      orderByList: orderByList?.call(Operator.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Operator] matching the given query parameters.
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
  Future<Operator?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OperatorTable>? where,
    int? offset,
    _is.OrderByBuilder<OperatorTable>? orderBy,
    _is.OrderByListBuilder<OperatorTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Operator>(
      where: where?.call(Operator.t),
      orderBy: orderBy?.call(Operator.t),
      orderByList: orderByList?.call(Operator.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Operator] by its [id] or null if no such row exists.
  Future<Operator?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Operator>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Operator]s in the list and returns the inserted rows.
  ///
  /// The returned [Operator]s will have their `id` fields set.
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
  Future<List<Operator>> insert(
    _is.DatabaseSession session,
    List<Operator> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Operator>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Operator] and returns the inserted row.
  ///
  /// The returned [Operator] will have its `id` field set.
  Future<Operator> insertRow(
    _is.DatabaseSession session,
    Operator row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Operator>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Operator]s in the list and returns the resulting rows.
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
  /// The returned [Operator]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Operator>> upsert(
    _is.DatabaseSession session,
    List<Operator> rows, {
    required _is.ColumnSelections<OperatorTable> conflictColumns,
    _is.ColumnSelections<OperatorTable>? updateColumns,
    _is.WhereExpressionBuilder<OperatorTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Operator>(
      rows,
      conflictColumns: conflictColumns(Operator.t),
      updateColumns: updateColumns?.call(Operator.t),
      updateWhere: updateWhere?.call(Operator.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Operator] and returns the resulting row.
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
  /// The returned [Operator] will have its `id` field set.
  Future<Operator?> upsertRow(
    _is.DatabaseSession session,
    Operator row, {
    required _is.ColumnSelections<OperatorTable> conflictColumns,
    _is.ColumnSelections<OperatorTable>? updateColumns,
    _is.WhereExpressionBuilder<OperatorTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Operator>(
      row,
      conflictColumns: conflictColumns(Operator.t),
      updateColumns: updateColumns?.call(Operator.t),
      updateWhere: updateWhere?.call(Operator.t),
      transaction: transaction,
    );
  }

  /// Updates all [Operator]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Operator>> update(
    _is.DatabaseSession session,
    List<Operator> rows, {
    _is.ColumnSelections<OperatorTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Operator>(
      rows,
      columns: columns?.call(Operator.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Operator]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Operator> updateRow(
    _is.DatabaseSession session,
    Operator row, {
    _is.ColumnSelections<OperatorTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Operator>(
      row,
      columns: columns?.call(Operator.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Operator] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Operator?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OperatorUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Operator>(
      id,
      columnValues: columnValues(Operator.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Operator]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Operator>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OperatorUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OperatorTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OperatorTable>? orderBy,
    _is.OrderByListBuilder<OperatorTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Operator>(
      columnValues: columnValues(Operator.t.updateTable),
      where: where(Operator.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Operator.t),
      orderByList: orderByList?.call(Operator.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Operator]s in the list and returns the deleted rows.
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
  Future<List<Operator>> delete(
    _is.DatabaseSession session,
    List<Operator> rows, {
    _is.OrderByBuilder<OperatorTable>? orderBy,
    _is.OrderByListBuilder<OperatorTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Operator>(
      rows,
      orderBy: orderBy?.call(Operator.t),
      orderByList: orderByList?.call(Operator.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Operator].
  Future<Operator> deleteRow(
    _is.DatabaseSession session,
    Operator row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Operator>(
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
  Future<List<Operator>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OperatorTable> where,
    _is.OrderByBuilder<OperatorTable>? orderBy,
    _is.OrderByListBuilder<OperatorTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Operator>(
      where: where(Operator.t),
      orderBy: orderBy?.call(Operator.t),
      orderByList: orderByList?.call(Operator.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OperatorTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Operator>(
      where: where?.call(Operator.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Operator] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OperatorTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Operator>(
      where: where(Operator.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
