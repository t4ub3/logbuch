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
import '../contacts/organization.dart' as _i0w1hmpk;

abstract class Contact
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Contact._({
    this.id,
    DateTime? createdAt,
    required this.firstName,
    required this.lastName,
    this.mail,
    this.phone,
    this.birthDate,
    this.street,
    this.zip,
    this.city,
    this.country,
    this.organizationId,
    this.organization,
    this.notes,
    this.privacyConsentAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Contact({
    int? id,
    DateTime? createdAt,
    required String firstName,
    required String lastName,
    String? mail,
    String? phone,
    DateTime? birthDate,
    String? street,
    String? zip,
    String? city,
    String? country,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    String? notes,
    DateTime? privacyConsentAt,
  }) = _ContactImpl;

  factory Contact.fromJson(Map<String, dynamic> jsonSerialization) {
    return Contact(
      id: jsonSerialization['id'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      mail: jsonSerialization['mail'] as String?,
      phone: jsonSerialization['phone'] as String?,
      birthDate: jsonSerialization['birthDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['birthDate']),
      street: jsonSerialization['street'] as String?,
      zip: jsonSerialization['zip'] as String?,
      city: jsonSerialization['city'] as String?,
      country: jsonSerialization['country'] as String?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i0w1hmpk.Organization>(
              jsonSerialization['organization'],
            ),
      notes: jsonSerialization['notes'] as String?,
      privacyConsentAt: jsonSerialization['privacyConsentAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['privacyConsentAt'],
            ),
    );
  }

  static final t = ContactTable();

  static const db = ContactRepository._();

  @override
  int? id;

  DateTime createdAt;

  String firstName;

  String lastName;

  String? mail;

  String? phone;

  DateTime? birthDate;

  String? street;

  String? zip;

  String? city;

  String? country;

  int? organizationId;

  _i0w1hmpk.Organization? organization;

  String? notes;

  DateTime? privacyConsentAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Contact copyWith({
    int? id,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    String? mail,
    String? phone,
    DateTime? birthDate,
    String? street,
    String? zip,
    String? city,
    String? country,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    String? notes,
    DateTime? privacyConsentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Contact',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      if (mail != null) 'mail': mail,
      if (phone != null) 'phone': phone,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (street != null) 'street': street,
      if (zip != null) 'zip': zip,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (notes != null) 'notes': notes,
      if (privacyConsentAt != null)
        'privacyConsentAt': privacyConsentAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Contact',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      if (mail != null) 'mail': mail,
      if (phone != null) 'phone': phone,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (street != null) 'street': street,
      if (zip != null) 'zip': zip,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
      if (privacyConsentAt != null)
        'privacyConsentAt': privacyConsentAt?.toJson(),
    };
  }

  static ContactInclude include({_i0w1hmpk.OrganizationInclude? organization}) {
    return ContactInclude._(organization: organization);
  }

  static ContactIncludeList includeList({
    _is.WhereExpressionBuilder<ContactTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactTable>? orderBy,
    _is.OrderByListBuilder<ContactTable>? orderByList,
    ContactInclude? include,
  }) {
    return ContactIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactImpl extends Contact {
  _ContactImpl({
    int? id,
    DateTime? createdAt,
    required String firstName,
    required String lastName,
    String? mail,
    String? phone,
    DateTime? birthDate,
    String? street,
    String? zip,
    String? city,
    String? country,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    String? notes,
    DateTime? privacyConsentAt,
  }) : super._(
         id: id,
         createdAt: createdAt,
         firstName: firstName,
         lastName: lastName,
         mail: mail,
         phone: phone,
         birthDate: birthDate,
         street: street,
         zip: zip,
         city: city,
         country: country,
         organizationId: organizationId,
         organization: organization,
         notes: notes,
         privacyConsentAt: privacyConsentAt,
       );

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Contact copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    Object? mail = _Undefined,
    Object? phone = _Undefined,
    Object? birthDate = _Undefined,
    Object? street = _Undefined,
    Object? zip = _Undefined,
    Object? city = _Undefined,
    Object? country = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    Object? notes = _Undefined,
    Object? privacyConsentAt = _Undefined,
  }) {
    return Contact(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mail: mail is String? ? mail : this.mail,
      phone: phone is String? ? phone : this.phone,
      birthDate: birthDate is DateTime? ? birthDate : this.birthDate,
      street: street is String? ? street : this.street,
      zip: zip is String? ? zip : this.zip,
      city: city is String? ? city : this.city,
      country: country is String? ? country : this.country,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i0w1hmpk.Organization?
          ? organization
          : this.organization?.copyWith(),
      notes: notes is String? ? notes : this.notes,
      privacyConsentAt: privacyConsentAt is DateTime?
          ? privacyConsentAt
          : this.privacyConsentAt,
    );
  }
}

class ContactUpdateTable extends _is.UpdateTable<ContactTable> {
  ContactUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> firstName(String value) => _is.ColumnValue(
    table.firstName,
    value,
  );

  _is.ColumnValue<String, String> lastName(String value) => _is.ColumnValue(
    table.lastName,
    value,
  );

  _is.ColumnValue<String, String> mail(String? value) => _is.ColumnValue(
    table.mail,
    value,
  );

  _is.ColumnValue<String, String> phone(String? value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> birthDate(DateTime? value) =>
      _is.ColumnValue(
        table.birthDate,
        value,
      );

  _is.ColumnValue<String, String> street(String? value) => _is.ColumnValue(
    table.street,
    value,
  );

  _is.ColumnValue<String, String> zip(String? value) => _is.ColumnValue(
    table.zip,
    value,
  );

  _is.ColumnValue<String, String> city(String? value) => _is.ColumnValue(
    table.city,
    value,
  );

  _is.ColumnValue<String, String> country(String? value) => _is.ColumnValue(
    table.country,
    value,
  );

  _is.ColumnValue<int, int> organizationId(int? value) => _is.ColumnValue(
    table.organizationId,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> privacyConsentAt(DateTime? value) =>
      _is.ColumnValue(
        table.privacyConsentAt,
        value,
      );
}

class ContactTable extends _is.Table<int?> {
  ContactTable({super.tableRelation}) : super(tableName: 'contacts') {
    updateTable = ContactUpdateTable(this);
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    firstName = _is.ColumnString(
      'firstName',
      this,
    );
    lastName = _is.ColumnString(
      'lastName',
      this,
    );
    mail = _is.ColumnString(
      'mail',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    birthDate = _is.ColumnDateTime(
      'birthDate',
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
    country = _is.ColumnString(
      'country',
      this,
    );
    organizationId = _is.ColumnInt(
      'organizationId',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    privacyConsentAt = _is.ColumnDateTime(
      'privacyConsentAt',
      this,
    );
  }

  late final ContactUpdateTable updateTable;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lastName;

  late final _is.ColumnString mail;

  late final _is.ColumnString phone;

  late final _is.ColumnDateTime birthDate;

  late final _is.ColumnString street;

  late final _is.ColumnString zip;

  late final _is.ColumnString city;

  late final _is.ColumnString country;

  late final _is.ColumnInt organizationId;

  _i0w1hmpk.OrganizationTable? _organization;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime privacyConsentAt;

  _i0w1hmpk.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _is.createRelationTable(
      relationFieldName: 'organization',
      field: Contact.t.organizationId,
      foreignField: _i0w1hmpk.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i0w1hmpk.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    createdAt,
    firstName,
    lastName,
    mail,
    phone,
    birthDate,
    street,
    zip,
    city,
    country,
    organizationId,
    notes,
    privacyConsentAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class ContactInclude extends _is.IncludeObject {
  ContactInclude._({_i0w1hmpk.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i0w1hmpk.OrganizationInclude? _organization;

  @override
  Map<String, _is.Include?> get includes => {'organization': _organization};

  @override
  _is.Table<int?> get table => Contact.t;
}

class ContactIncludeList extends _is.IncludeList {
  ContactIncludeList._({
    _is.WhereExpressionBuilder<ContactTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Contact.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Contact.t;
}

class ContactRepository {
  const ContactRepository._();

  final attachRow = const ContactAttachRowRepository._();

  final detachRow = const ContactDetachRowRepository._();

  /// Returns a list of [Contact]s matching the given query parameters.
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
  Future<List<Contact>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactTable>? orderBy,
    _is.OrderByListBuilder<ContactTable>? orderByList,
    _is.Transaction? transaction,
    ContactInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Contact>(
      where: where?.call(Contact.t),
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Contact] matching the given query parameters.
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
  Future<Contact?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactTable>? where,
    int? offset,
    _is.OrderByBuilder<ContactTable>? orderBy,
    _is.OrderByListBuilder<ContactTable>? orderByList,
    _is.Transaction? transaction,
    ContactInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Contact>(
      where: where?.call(Contact.t),
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Contact] by its [id] or null if no such row exists.
  Future<Contact?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ContactInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Contact>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Contact]s in the list and returns the inserted rows.
  ///
  /// The returned [Contact]s will have their `id` fields set.
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
  Future<List<Contact>> insert(
    _is.DatabaseSession session,
    List<Contact> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Contact>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Contact] and returns the inserted row.
  ///
  /// The returned [Contact] will have its `id` field set.
  Future<Contact> insertRow(
    _is.DatabaseSession session,
    Contact row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Contact>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Contact]s in the list and returns the resulting rows.
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
  /// The returned [Contact]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Contact>> upsert(
    _is.DatabaseSession session,
    List<Contact> rows, {
    required _is.ColumnSelections<ContactTable> conflictColumns,
    _is.ColumnSelections<ContactTable>? updateColumns,
    _is.WhereExpressionBuilder<ContactTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Contact>(
      rows,
      conflictColumns: conflictColumns(Contact.t),
      updateColumns: updateColumns?.call(Contact.t),
      updateWhere: updateWhere?.call(Contact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Contact] and returns the resulting row.
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
  /// The returned [Contact] will have its `id` field set.
  Future<Contact?> upsertRow(
    _is.DatabaseSession session,
    Contact row, {
    required _is.ColumnSelections<ContactTable> conflictColumns,
    _is.ColumnSelections<ContactTable>? updateColumns,
    _is.WhereExpressionBuilder<ContactTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Contact>(
      row,
      conflictColumns: conflictColumns(Contact.t),
      updateColumns: updateColumns?.call(Contact.t),
      updateWhere: updateWhere?.call(Contact.t),
      transaction: transaction,
    );
  }

  /// Updates all [Contact]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Contact>> update(
    _is.DatabaseSession session,
    List<Contact> rows, {
    _is.ColumnSelections<ContactTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Contact>(
      rows,
      columns: columns?.call(Contact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Contact]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Contact> updateRow(
    _is.DatabaseSession session,
    Contact row, {
    _is.ColumnSelections<ContactTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Contact>(
      row,
      columns: columns?.call(Contact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Contact] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Contact?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ContactUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Contact>(
      id,
      columnValues: columnValues(Contact.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Contact]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Contact>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ContactUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ContactTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactTable>? orderBy,
    _is.OrderByListBuilder<ContactTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Contact>(
      columnValues: columnValues(Contact.t.updateTable),
      where: where(Contact.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Contact]s in the list and returns the deleted rows.
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
  Future<List<Contact>> delete(
    _is.DatabaseSession session,
    List<Contact> rows, {
    _is.OrderByBuilder<ContactTable>? orderBy,
    _is.OrderByListBuilder<ContactTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Contact>(
      rows,
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Contact].
  Future<Contact> deleteRow(
    _is.DatabaseSession session,
    Contact row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Contact>(
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
  Future<List<Contact>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ContactTable> where,
    _is.OrderByBuilder<ContactTable>? orderBy,
    _is.OrderByListBuilder<ContactTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Contact>(
      where: where(Contact.t),
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Contact>(
      where: where?.call(Contact.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Contact] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ContactTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Contact>(
      where: where(Contact.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ContactAttachRowRepository {
  const ContactAttachRowRepository._();

  /// Creates a relation between the given [Contact] and [Organization]
  /// by setting the [Contact]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _is.DatabaseSession session,
    Contact contact,
    _i0w1hmpk.Organization organization, {
    _is.Transaction? transaction,
  }) async {
    if (contact.id == null) {
      throw ArgumentError.notNull('contact.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $contact = contact.copyWith(organizationId: organization.id);
    await session.db.updateRow<Contact>(
      $contact,
      columns: [Contact.t.organizationId],
      transaction: transaction,
    );
  }
}

class ContactDetachRowRepository {
  const ContactDetachRowRepository._();

  /// Detaches the relation between this [Contact] and the [Organization] set in `organization`
  /// by setting the [Contact]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _is.DatabaseSession session,
    Contact contact, {
    _is.Transaction? transaction,
  }) async {
    if (contact.id == null) {
      throw ArgumentError.notNull('contact.id');
    }

    var $contact = contact.copyWith(organizationId: null);
    await session.db.updateRow<Contact>(
      $contact,
      columns: [Contact.t.organizationId],
      transaction: transaction,
    );
  }
}
