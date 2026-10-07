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
import '../bookings/booking_category_color.dart' as _iei1rmwk;
import '../bookings/booking_category_icon.dart' as _igtfv0zf;

abstract class BookingCategory
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookingCategory._({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory BookingCategory({
    int? id,
    required String name,
    required _igtfv0zf.BookingCategoryIcon icon,
    required _iei1rmwk.BookingCategoryColor color,
  }) = _BookingCategoryImpl;

  factory BookingCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      icon: _igtfv0zf.BookingCategoryIcon.fromJson(
        (jsonSerialization['icon'] as String),
      ),
      color: _iei1rmwk.BookingCategoryColor.fromJson(
        (jsonSerialization['color'] as String),
      ),
    );
  }

  static final t = BookingCategoryTable();

  static const db = BookingCategoryRepository._();

  @override
  int? id;

  String name;

  _igtfv0zf.BookingCategoryIcon icon;

  _iei1rmwk.BookingCategoryColor color;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookingCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingCategory copyWith({
    int? id,
    String? name,
    _igtfv0zf.BookingCategoryIcon? icon,
    _iei1rmwk.BookingCategoryColor? color,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingCategory',
      if (id != null) 'id': id,
      'name': name,
      'icon': icon.toJson(),
      'color': color.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingCategory',
      if (id != null) 'id': id,
      'name': name,
      'icon': icon.toJson(),
      'color': color.toJson(),
    };
  }

  static BookingCategoryInclude include() {
    return BookingCategoryInclude._();
  }

  static BookingCategoryIncludeList includeList({
    _is.WhereExpressionBuilder<BookingCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookingCategoryTable>? orderByList,
    BookingCategoryInclude? include,
  }) {
    return BookingCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookingCategory.t),
      orderByList: orderByList?.call(BookingCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingCategoryImpl extends BookingCategory {
  _BookingCategoryImpl({
    int? id,
    required String name,
    required _igtfv0zf.BookingCategoryIcon icon,
    required _iei1rmwk.BookingCategoryColor color,
  }) : super._(
         id: id,
         name: name,
         icon: icon,
         color: color,
       );

  /// Returns a shallow copy of this [BookingCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingCategory copyWith({
    Object? id = _Undefined,
    String? name,
    _igtfv0zf.BookingCategoryIcon? icon,
    _iei1rmwk.BookingCategoryColor? color,
  }) {
    return BookingCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}

class BookingCategoryUpdateTable extends _is.UpdateTable<BookingCategoryTable> {
  BookingCategoryUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_igtfv0zf.BookingCategoryIcon, _igtfv0zf.BookingCategoryIcon>
  icon(_igtfv0zf.BookingCategoryIcon value) => _is.ColumnValue(
    table.icon,
    value,
  );

  _is.ColumnValue<
    _iei1rmwk.BookingCategoryColor,
    _iei1rmwk.BookingCategoryColor
  >
  color(_iei1rmwk.BookingCategoryColor value) => _is.ColumnValue(
    table.color,
    value,
  );
}

class BookingCategoryTable extends _is.Table<int?> {
  BookingCategoryTable({super.tableRelation})
    : super(tableName: 'booking_categories') {
    updateTable = BookingCategoryUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    icon = _is.ColumnEnum(
      'icon',
      this,
      _is.EnumSerialization.byName,
    );
    color = _is.ColumnEnum(
      'color',
      this,
      _is.EnumSerialization.byName,
    );
  }

  late final BookingCategoryUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_igtfv0zf.BookingCategoryIcon> icon;

  late final _is.ColumnEnum<_iei1rmwk.BookingCategoryColor> color;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    icon,
    color,
  ];
}

class BookingCategoryInclude extends _is.IncludeObject {
  BookingCategoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookingCategory.t;
}

class BookingCategoryIncludeList extends _is.IncludeList {
  BookingCategoryIncludeList._({
    _is.WhereExpressionBuilder<BookingCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookingCategory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookingCategory.t;
}

class BookingCategoryRepository {
  const BookingCategoryRepository._();

  /// Returns a list of [BookingCategory]s matching the given query parameters.
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
  Future<List<BookingCategory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookingCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookingCategory>(
      where: where?.call(BookingCategory.t),
      orderBy: orderBy?.call(BookingCategory.t),
      orderByList: orderByList?.call(BookingCategory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookingCategory] matching the given query parameters.
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
  Future<BookingCategory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingCategoryTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookingCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookingCategory>(
      where: where?.call(BookingCategory.t),
      orderBy: orderBy?.call(BookingCategory.t),
      orderByList: orderByList?.call(BookingCategory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookingCategory] by its [id] or null if no such row exists.
  Future<BookingCategory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookingCategory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookingCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [BookingCategory]s will have their `id` fields set.
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
  Future<List<BookingCategory>> insert(
    _is.DatabaseSession session,
    List<BookingCategory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookingCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookingCategory] and returns the inserted row.
  ///
  /// The returned [BookingCategory] will have its `id` field set.
  Future<BookingCategory> insertRow(
    _is.DatabaseSession session,
    BookingCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookingCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BookingCategory]s in the list and returns the resulting rows.
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
  /// The returned [BookingCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingCategory>> upsert(
    _is.DatabaseSession session,
    List<BookingCategory> rows, {
    required _is.ColumnSelections<BookingCategoryTable> conflictColumns,
    _is.ColumnSelections<BookingCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingCategoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookingCategory>(
      rows,
      conflictColumns: conflictColumns(BookingCategory.t),
      updateColumns: updateColumns?.call(BookingCategory.t),
      updateWhere: updateWhere?.call(BookingCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookingCategory] and returns the resulting row.
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
  /// The returned [BookingCategory] will have its `id` field set.
  Future<BookingCategory?> upsertRow(
    _is.DatabaseSession session,
    BookingCategory row, {
    required _is.ColumnSelections<BookingCategoryTable> conflictColumns,
    _is.ColumnSelections<BookingCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingCategoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookingCategory>(
      row,
      conflictColumns: conflictColumns(BookingCategory.t),
      updateColumns: updateColumns?.call(BookingCategory.t),
      updateWhere: updateWhere?.call(BookingCategory.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookingCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingCategory>> update(
    _is.DatabaseSession session,
    List<BookingCategory> rows, {
    _is.ColumnSelections<BookingCategoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookingCategory>(
      rows,
      columns: columns?.call(BookingCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookingCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookingCategory> updateRow(
    _is.DatabaseSession session,
    BookingCategory row, {
    _is.ColumnSelections<BookingCategoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookingCategory>(
      row,
      columns: columns?.call(BookingCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookingCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookingCategory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingCategoryUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookingCategory>(
      id,
      columnValues: columnValues(BookingCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookingCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingCategory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingCategoryUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<BookingCategoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookingCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookingCategory>(
      columnValues: columnValues(BookingCategory.t.updateTable),
      where: where(BookingCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookingCategory.t),
      orderByList: orderByList?.call(BookingCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookingCategory]s in the list and returns the deleted rows.
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
  Future<List<BookingCategory>> delete(
    _is.DatabaseSession session,
    List<BookingCategory> rows, {
    _is.OrderByBuilder<BookingCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookingCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookingCategory>(
      rows,
      orderBy: orderBy?.call(BookingCategory.t),
      orderByList: orderByList?.call(BookingCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookingCategory].
  Future<BookingCategory> deleteRow(
    _is.DatabaseSession session,
    BookingCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookingCategory>(
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
  Future<List<BookingCategory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingCategoryTable> where,
    _is.OrderByBuilder<BookingCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookingCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookingCategory>(
      where: where(BookingCategory.t),
      orderBy: orderBy?.call(BookingCategory.t),
      orderByList: orderByList?.call(BookingCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingCategoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookingCategory>(
      where: where?.call(BookingCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookingCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingCategoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookingCategory>(
      where: where(BookingCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
