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
import '../contacts/household_member.dart' as _iju6dw84;

/// Contacts who usually travel together, such as a family. A household can
/// be added to a booking as a guest group in one step.
abstract class Household
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Household._({
    this.id,
    required this.name,
    this.members,
  });

  factory Household({
    int? id,
    required String name,
    List<_iju6dw84.HouseholdMember>? members,
  }) = _HouseholdImpl;

  factory Household.fromJson(Map<String, dynamic> jsonSerialization) {
    return Household(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      members: jsonSerialization['members'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_iju6dw84.HouseholdMember>>(
              jsonSerialization['members'],
            ),
    );
  }

  static final t = HouseholdTable();

  static const db = HouseholdRepository._();

  @override
  int? id;

  String name;

  List<_iju6dw84.HouseholdMember>? members;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Household]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Household copyWith({
    int? id,
    String? name,
    List<_iju6dw84.HouseholdMember>? members,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Household',
      if (id != null) 'id': id,
      'name': name,
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Household',
      if (id != null) 'id': id,
      'name': name,
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static HouseholdInclude include({
    _iju6dw84.HouseholdMemberIncludeList? members,
  }) {
    return HouseholdInclude._(members: members);
  }

  static HouseholdIncludeList includeList({
    _is.WhereExpressionBuilder<HouseholdTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HouseholdTable>? orderBy,
    _is.OrderByListBuilder<HouseholdTable>? orderByList,
    HouseholdInclude? include,
  }) {
    return HouseholdIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Household.t),
      orderByList: orderByList?.call(Household.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HouseholdImpl extends Household {
  _HouseholdImpl({
    int? id,
    required String name,
    List<_iju6dw84.HouseholdMember>? members,
  }) : super._(
         id: id,
         name: name,
         members: members,
       );

  /// Returns a shallow copy of this [Household]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Household copyWith({
    Object? id = _Undefined,
    String? name,
    Object? members = _Undefined,
  }) {
    return Household(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      members: members is List<_iju6dw84.HouseholdMember>?
          ? members
          : this.members?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class HouseholdUpdateTable extends _is.UpdateTable<HouseholdTable> {
  HouseholdUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );
}

class HouseholdTable extends _is.Table<int?> {
  HouseholdTable({super.tableRelation}) : super(tableName: 'households') {
    updateTable = HouseholdUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
  }

  late final HouseholdUpdateTable updateTable;

  late final _is.ColumnString name;

  _iju6dw84.HouseholdMemberTable? ___members;

  _is.ManyRelation<_iju6dw84.HouseholdMemberTable>? _members;

  _iju6dw84.HouseholdMemberTable get __members {
    if (___members != null) return ___members!;
    ___members = _is.createRelationTable(
      relationFieldName: '__members',
      field: Household.t.id,
      foreignField: _iju6dw84.HouseholdMember.t.householdId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iju6dw84.HouseholdMemberTable(tableRelation: foreignTableRelation),
    );
    return ___members!;
  }

  _is.ManyRelation<_iju6dw84.HouseholdMemberTable> get members {
    if (_members != null) return _members!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'members',
      field: Household.t.id,
      foreignField: _iju6dw84.HouseholdMember.t.householdId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iju6dw84.HouseholdMemberTable(tableRelation: foreignTableRelation),
    );
    _members = _is.ManyRelation<_iju6dw84.HouseholdMemberTable>(
      tableWithRelations: relationTable,
      table: _iju6dw84.HouseholdMemberTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _members!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    name,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'members') {
      return __members;
    }
    return null;
  }
}

class HouseholdInclude extends _is.IncludeObject {
  HouseholdInclude._({_iju6dw84.HouseholdMemberIncludeList? members}) {
    _members = members;
  }

  _iju6dw84.HouseholdMemberIncludeList? _members;

  @override
  Map<String, _is.Include?> get includes => {'members': _members};

  @override
  _is.Table<int?> get table => Household.t;
}

class HouseholdIncludeList extends _is.IncludeList {
  HouseholdIncludeList._({
    _is.WhereExpressionBuilder<HouseholdTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Household.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Household.t;
}

class HouseholdRepository {
  const HouseholdRepository._();

  final attach = const HouseholdAttachRepository._();

  final attachRow = const HouseholdAttachRowRepository._();

  /// Returns a list of [Household]s matching the given query parameters.
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
  Future<List<Household>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HouseholdTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HouseholdTable>? orderBy,
    _is.OrderByListBuilder<HouseholdTable>? orderByList,
    _is.Transaction? transaction,
    HouseholdInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Household>(
      where: where?.call(Household.t),
      orderBy: orderBy?.call(Household.t),
      orderByList: orderByList?.call(Household.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Household] matching the given query parameters.
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
  Future<Household?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HouseholdTable>? where,
    int? offset,
    _is.OrderByBuilder<HouseholdTable>? orderBy,
    _is.OrderByListBuilder<HouseholdTable>? orderByList,
    _is.Transaction? transaction,
    HouseholdInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Household>(
      where: where?.call(Household.t),
      orderBy: orderBy?.call(Household.t),
      orderByList: orderByList?.call(Household.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Household] by its [id] or null if no such row exists.
  Future<Household?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    HouseholdInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Household>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Household]s in the list and returns the inserted rows.
  ///
  /// The returned [Household]s will have their `id` fields set.
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
  Future<List<Household>> insert(
    _is.DatabaseSession session,
    List<Household> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Household>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Household] and returns the inserted row.
  ///
  /// The returned [Household] will have its `id` field set.
  Future<Household> insertRow(
    _is.DatabaseSession session,
    Household row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Household>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Household]s in the list and returns the resulting rows.
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
  /// The returned [Household]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Household>> upsert(
    _is.DatabaseSession session,
    List<Household> rows, {
    required _is.ColumnSelections<HouseholdTable> conflictColumns,
    _is.ColumnSelections<HouseholdTable>? updateColumns,
    _is.WhereExpressionBuilder<HouseholdTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Household>(
      rows,
      conflictColumns: conflictColumns(Household.t),
      updateColumns: updateColumns?.call(Household.t),
      updateWhere: updateWhere?.call(Household.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Household] and returns the resulting row.
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
  /// The returned [Household] will have its `id` field set.
  Future<Household?> upsertRow(
    _is.DatabaseSession session,
    Household row, {
    required _is.ColumnSelections<HouseholdTable> conflictColumns,
    _is.ColumnSelections<HouseholdTable>? updateColumns,
    _is.WhereExpressionBuilder<HouseholdTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Household>(
      row,
      conflictColumns: conflictColumns(Household.t),
      updateColumns: updateColumns?.call(Household.t),
      updateWhere: updateWhere?.call(Household.t),
      transaction: transaction,
    );
  }

  /// Updates all [Household]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Household>> update(
    _is.DatabaseSession session,
    List<Household> rows, {
    _is.ColumnSelections<HouseholdTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Household>(
      rows,
      columns: columns?.call(Household.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Household]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Household> updateRow(
    _is.DatabaseSession session,
    Household row, {
    _is.ColumnSelections<HouseholdTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Household>(
      row,
      columns: columns?.call(Household.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Household] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Household?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<HouseholdUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Household>(
      id,
      columnValues: columnValues(Household.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Household]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Household>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<HouseholdUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<HouseholdTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HouseholdTable>? orderBy,
    _is.OrderByListBuilder<HouseholdTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Household>(
      columnValues: columnValues(Household.t.updateTable),
      where: where(Household.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Household.t),
      orderByList: orderByList?.call(Household.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Household]s in the list and returns the deleted rows.
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
  Future<List<Household>> delete(
    _is.DatabaseSession session,
    List<Household> rows, {
    _is.OrderByBuilder<HouseholdTable>? orderBy,
    _is.OrderByListBuilder<HouseholdTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Household>(
      rows,
      orderBy: orderBy?.call(Household.t),
      orderByList: orderByList?.call(Household.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Household].
  Future<Household> deleteRow(
    _is.DatabaseSession session,
    Household row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Household>(
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
  Future<List<Household>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HouseholdTable> where,
    _is.OrderByBuilder<HouseholdTable>? orderBy,
    _is.OrderByListBuilder<HouseholdTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Household>(
      where: where(Household.t),
      orderBy: orderBy?.call(Household.t),
      orderByList: orderByList?.call(Household.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HouseholdTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Household>(
      where: where?.call(Household.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Household] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HouseholdTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Household>(
      where: where(Household.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class HouseholdAttachRepository {
  const HouseholdAttachRepository._();

  /// Creates a relation between this [Household] and the given [HouseholdMember]s
  /// by setting each [HouseholdMember]'s foreign key `householdId` to refer to this [Household].
  Future<void> members(
    _is.DatabaseSession session,
    Household household,
    List<_iju6dw84.HouseholdMember> householdMember, {
    _is.Transaction? transaction,
  }) async {
    if (householdMember.any((e) => e.id == null)) {
      throw ArgumentError.notNull('householdMember.id');
    }
    if (household.id == null) {
      throw ArgumentError.notNull('household.id');
    }

    var $householdMember = householdMember
        .map((e) => e.copyWith(householdId: household.id))
        .toList();
    await session.db.update<_iju6dw84.HouseholdMember>(
      $householdMember,
      columns: [_iju6dw84.HouseholdMember.t.householdId],
      transaction: transaction,
    );
  }
}

class HouseholdAttachRowRepository {
  const HouseholdAttachRowRepository._();

  /// Creates a relation between this [Household] and the given [HouseholdMember]
  /// by setting the [HouseholdMember]'s foreign key `householdId` to refer to this [Household].
  Future<void> members(
    _is.DatabaseSession session,
    Household household,
    _iju6dw84.HouseholdMember householdMember, {
    _is.Transaction? transaction,
  }) async {
    if (householdMember.id == null) {
      throw ArgumentError.notNull('householdMember.id');
    }
    if (household.id == null) {
      throw ArgumentError.notNull('household.id');
    }

    var $householdMember = householdMember.copyWith(householdId: household.id);
    await session.db.updateRow<_iju6dw84.HouseholdMember>(
      $householdMember,
      columns: [_iju6dw84.HouseholdMember.t.householdId],
      transaction: transaction,
    );
  }
}
