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
import '../bookings/billing_mode.dart' as _ikjlxdwh;
import '../bookings/booking_category.dart' as _i1nxuzrq;
import '../bookings/booking_room.dart' as _icgf4f53;
import '../bookings/booking_status.dart' as _ilk1qg37;
import '../contacts/contact.dart' as _imbxrfja;
import '../contacts/organization.dart' as _i0w1hmpk;
import '../pricing/meal_plan.dart' as _iqp4km0h;

abstract class Booking
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Booking._({
    this.id,
    DateTime? createdAt,
    required this.title,
    this.arrival,
    this.departure,
    required this.leadId,
    this.lead,
    this.organizationId,
    this.organization,
    this.categoryId,
    this.category,
    _ilk1qg37.BookingStatus? status,
    this.optionExpiresAt,
    this.mealPlanId,
    this.mealPlan,
    _ikjlxdwh.BillingMode? billingMode,
    this.expectedGuestCount,
    this.notes,
    this.rooms,
  }) : createdAt = createdAt ?? DateTime.now(),
       status = status ?? _ilk1qg37.BookingStatus.inquiry,
       billingMode = billingMode ?? _ikjlxdwh.BillingMode.single;

  factory Booking({
    int? id,
    DateTime? createdAt,
    required String title,
    DateTime? arrival,
    DateTime? departure,
    required int leadId,
    _imbxrfja.Contact? lead,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    int? categoryId,
    _i1nxuzrq.BookingCategory? category,
    _ilk1qg37.BookingStatus? status,
    DateTime? optionExpiresAt,
    int? mealPlanId,
    _iqp4km0h.MealPlan? mealPlan,
    _ikjlxdwh.BillingMode? billingMode,
    int? expectedGuestCount,
    String? notes,
    List<_icgf4f53.BookingRoom>? rooms,
  }) = _BookingImpl;

  factory Booking.fromJson(Map<String, dynamic> jsonSerialization) {
    return Booking(
      id: jsonSerialization['id'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      title: jsonSerialization['title'] as String,
      arrival: jsonSerialization['arrival'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['arrival']),
      departure: jsonSerialization['departure'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['departure']),
      leadId: jsonSerialization['leadId'] as int,
      lead: jsonSerialization['lead'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['lead'],
            ),
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i0w1hmpk.Organization>(
              jsonSerialization['organization'],
            ),
      categoryId: jsonSerialization['categoryId'] as int?,
      category: jsonSerialization['category'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_i1nxuzrq.BookingCategory>(
              jsonSerialization['category'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _ilk1qg37.BookingStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      optionExpiresAt: jsonSerialization['optionExpiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['optionExpiresAt'],
            ),
      mealPlanId: jsonSerialization['mealPlanId'] as int?,
      mealPlan: jsonSerialization['mealPlan'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<_iqp4km0h.MealPlan>(
              jsonSerialization['mealPlan'],
            ),
      billingMode: jsonSerialization['billingMode'] == null
          ? null
          : _ikjlxdwh.BillingMode.fromJson(
              (jsonSerialization['billingMode'] as String),
            ),
      expectedGuestCount: jsonSerialization['expectedGuestCount'] as int?,
      notes: jsonSerialization['notes'] as String?,
      rooms: jsonSerialization['rooms'] == null
          ? null
          : _iil9w69f.Protocol().deserialize<List<_icgf4f53.BookingRoom>>(
              jsonSerialization['rooms'],
            ),
    );
  }

  static final t = BookingTable();

  static const db = BookingRepository._();

  @override
  int? id;

  DateTime createdAt;

  String title;

  DateTime? arrival;

  DateTime? departure;

  int leadId;

  _imbxrfja.Contact? lead;

  int? organizationId;

  _i0w1hmpk.Organization? organization;

  int? categoryId;

  _i1nxuzrq.BookingCategory? category;

  _ilk1qg37.BookingStatus status;

  DateTime? optionExpiresAt;

  int? mealPlanId;

  _iqp4km0h.MealPlan? mealPlan;

  _ikjlxdwh.BillingMode billingMode;

  int? expectedGuestCount;

  String? notes;

  List<_icgf4f53.BookingRoom>? rooms;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Booking copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    DateTime? arrival,
    DateTime? departure,
    int? leadId,
    _imbxrfja.Contact? lead,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    int? categoryId,
    _i1nxuzrq.BookingCategory? category,
    _ilk1qg37.BookingStatus? status,
    DateTime? optionExpiresAt,
    int? mealPlanId,
    _iqp4km0h.MealPlan? mealPlan,
    _ikjlxdwh.BillingMode? billingMode,
    int? expectedGuestCount,
    String? notes,
    List<_icgf4f53.BookingRoom>? rooms,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'title': title,
      if (arrival != null) 'arrival': arrival?.toJson(),
      if (departure != null) 'departure': departure?.toJson(),
      'leadId': leadId,
      if (lead != null) 'lead': lead?.toJson(),
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (categoryId != null) 'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
      'status': status.toJson(),
      if (optionExpiresAt != null) 'optionExpiresAt': optionExpiresAt?.toJson(),
      if (mealPlanId != null) 'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJson(),
      'billingMode': billingMode.toJson(),
      if (expectedGuestCount != null) 'expectedGuestCount': expectedGuestCount,
      if (notes != null) 'notes': notes,
      if (rooms != null) 'rooms': rooms?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'title': title,
      if (arrival != null) 'arrival': arrival?.toJson(),
      if (departure != null) 'departure': departure?.toJson(),
      'leadId': leadId,
      if (lead != null) 'lead': lead?.toJsonForProtocol(),
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (categoryId != null) 'categoryId': categoryId,
      if (category != null) 'category': category?.toJsonForProtocol(),
      'status': status.toJson(),
      if (optionExpiresAt != null) 'optionExpiresAt': optionExpiresAt?.toJson(),
      if (mealPlanId != null) 'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJsonForProtocol(),
      'billingMode': billingMode.toJson(),
      if (expectedGuestCount != null) 'expectedGuestCount': expectedGuestCount,
      if (notes != null) 'notes': notes,
      if (rooms != null)
        'rooms': rooms?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static BookingInclude include({
    _imbxrfja.ContactInclude? lead,
    _i0w1hmpk.OrganizationInclude? organization,
    _i1nxuzrq.BookingCategoryInclude? category,
    _iqp4km0h.MealPlanInclude? mealPlan,
    _icgf4f53.BookingRoomIncludeList? rooms,
  }) {
    return BookingInclude._(
      lead: lead,
      organization: organization,
      category: category,
      mealPlan: mealPlan,
      rooms: rooms,
    );
  }

  static BookingIncludeList includeList({
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    BookingInclude? include,
  }) {
    return BookingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingImpl extends Booking {
  _BookingImpl({
    int? id,
    DateTime? createdAt,
    required String title,
    DateTime? arrival,
    DateTime? departure,
    required int leadId,
    _imbxrfja.Contact? lead,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    int? categoryId,
    _i1nxuzrq.BookingCategory? category,
    _ilk1qg37.BookingStatus? status,
    DateTime? optionExpiresAt,
    int? mealPlanId,
    _iqp4km0h.MealPlan? mealPlan,
    _ikjlxdwh.BillingMode? billingMode,
    int? expectedGuestCount,
    String? notes,
    List<_icgf4f53.BookingRoom>? rooms,
  }) : super._(
         id: id,
         createdAt: createdAt,
         title: title,
         arrival: arrival,
         departure: departure,
         leadId: leadId,
         lead: lead,
         organizationId: organizationId,
         organization: organization,
         categoryId: categoryId,
         category: category,
         status: status,
         optionExpiresAt: optionExpiresAt,
         mealPlanId: mealPlanId,
         mealPlan: mealPlan,
         billingMode: billingMode,
         expectedGuestCount: expectedGuestCount,
         notes: notes,
         rooms: rooms,
       );

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Booking copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    String? title,
    Object? arrival = _Undefined,
    Object? departure = _Undefined,
    int? leadId,
    Object? lead = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    Object? categoryId = _Undefined,
    Object? category = _Undefined,
    _ilk1qg37.BookingStatus? status,
    Object? optionExpiresAt = _Undefined,
    Object? mealPlanId = _Undefined,
    Object? mealPlan = _Undefined,
    _ikjlxdwh.BillingMode? billingMode,
    Object? expectedGuestCount = _Undefined,
    Object? notes = _Undefined,
    Object? rooms = _Undefined,
  }) {
    return Booking(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      arrival: arrival is DateTime? ? arrival : this.arrival,
      departure: departure is DateTime? ? departure : this.departure,
      leadId: leadId ?? this.leadId,
      lead: lead is _imbxrfja.Contact? ? lead : this.lead?.copyWith(),
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i0w1hmpk.Organization?
          ? organization
          : this.organization?.copyWith(),
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      category: category is _i1nxuzrq.BookingCategory?
          ? category
          : this.category?.copyWith(),
      status: status ?? this.status,
      optionExpiresAt: optionExpiresAt is DateTime?
          ? optionExpiresAt
          : this.optionExpiresAt,
      mealPlanId: mealPlanId is int? ? mealPlanId : this.mealPlanId,
      mealPlan: mealPlan is _iqp4km0h.MealPlan?
          ? mealPlan
          : this.mealPlan?.copyWith(),
      billingMode: billingMode ?? this.billingMode,
      expectedGuestCount: expectedGuestCount is int?
          ? expectedGuestCount
          : this.expectedGuestCount,
      notes: notes is String? ? notes : this.notes,
      rooms: rooms is List<_icgf4f53.BookingRoom>?
          ? rooms
          : this.rooms?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class BookingUpdateTable extends _is.UpdateTable<BookingTable> {
  BookingUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> arrival(DateTime? value) =>
      _is.ColumnValue(
        table.arrival,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> departure(DateTime? value) =>
      _is.ColumnValue(
        table.departure,
        value,
      );

  _is.ColumnValue<int, int> leadId(int value) => _is.ColumnValue(
    table.leadId,
    value,
  );

  _is.ColumnValue<int, int> organizationId(int? value) => _is.ColumnValue(
    table.organizationId,
    value,
  );

  _is.ColumnValue<int, int> categoryId(int? value) => _is.ColumnValue(
    table.categoryId,
    value,
  );

  _is.ColumnValue<_ilk1qg37.BookingStatus, _ilk1qg37.BookingStatus> status(
    _ilk1qg37.BookingStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> optionExpiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.optionExpiresAt,
        value,
      );

  _is.ColumnValue<int, int> mealPlanId(int? value) => _is.ColumnValue(
    table.mealPlanId,
    value,
  );

  _is.ColumnValue<_ikjlxdwh.BillingMode, _ikjlxdwh.BillingMode> billingMode(
    _ikjlxdwh.BillingMode value,
  ) => _is.ColumnValue(
    table.billingMode,
    value,
  );

  _is.ColumnValue<int, int> expectedGuestCount(int? value) => _is.ColumnValue(
    table.expectedGuestCount,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );
}

class BookingTable extends _is.Table<int?> {
  BookingTable({super.tableRelation}) : super(tableName: 'bookings') {
    updateTable = BookingUpdateTable(this);
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    arrival = _is.ColumnDateTime(
      'arrival',
      this,
    );
    departure = _is.ColumnDateTime(
      'departure',
      this,
    );
    leadId = _is.ColumnInt(
      'leadId',
      this,
    );
    organizationId = _is.ColumnInt(
      'organizationId',
      this,
    );
    categoryId = _is.ColumnInt(
      'categoryId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    optionExpiresAt = _is.ColumnDateTime(
      'optionExpiresAt',
      this,
    );
    mealPlanId = _is.ColumnInt(
      'mealPlanId',
      this,
    );
    billingMode = _is.ColumnEnum(
      'billingMode',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    expectedGuestCount = _is.ColumnInt(
      'expectedGuestCount',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
  }

  late final BookingUpdateTable updateTable;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString title;

  late final _is.ColumnDateTime arrival;

  late final _is.ColumnDateTime departure;

  late final _is.ColumnInt leadId;

  _imbxrfja.ContactTable? _lead;

  late final _is.ColumnInt organizationId;

  _i0w1hmpk.OrganizationTable? _organization;

  late final _is.ColumnInt categoryId;

  _i1nxuzrq.BookingCategoryTable? _category;

  late final _is.ColumnEnum<_ilk1qg37.BookingStatus> status;

  late final _is.ColumnDateTime optionExpiresAt;

  late final _is.ColumnInt mealPlanId;

  _iqp4km0h.MealPlanTable? _mealPlan;

  late final _is.ColumnEnum<_ikjlxdwh.BillingMode> billingMode;

  late final _is.ColumnInt expectedGuestCount;

  late final _is.ColumnString notes;

  _icgf4f53.BookingRoomTable? ___rooms;

  _is.ManyRelation<_icgf4f53.BookingRoomTable>? _rooms;

  _imbxrfja.ContactTable get lead {
    if (_lead != null) return _lead!;
    _lead = _is.createRelationTable(
      relationFieldName: 'lead',
      field: Booking.t.leadId,
      foreignField: _imbxrfja.Contact.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imbxrfja.ContactTable(tableRelation: foreignTableRelation),
    );
    return _lead!;
  }

  _i0w1hmpk.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _is.createRelationTable(
      relationFieldName: 'organization',
      field: Booking.t.organizationId,
      foreignField: _i0w1hmpk.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i0w1hmpk.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i1nxuzrq.BookingCategoryTable get category {
    if (_category != null) return _category!;
    _category = _is.createRelationTable(
      relationFieldName: 'category',
      field: Booking.t.categoryId,
      foreignField: _i1nxuzrq.BookingCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1nxuzrq.BookingCategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  _iqp4km0h.MealPlanTable get mealPlan {
    if (_mealPlan != null) return _mealPlan!;
    _mealPlan = _is.createRelationTable(
      relationFieldName: 'mealPlan',
      field: Booking.t.mealPlanId,
      foreignField: _iqp4km0h.MealPlan.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iqp4km0h.MealPlanTable(tableRelation: foreignTableRelation),
    );
    return _mealPlan!;
  }

  _icgf4f53.BookingRoomTable get __rooms {
    if (___rooms != null) return ___rooms!;
    ___rooms = _is.createRelationTable(
      relationFieldName: '__rooms',
      field: Booking.t.id,
      foreignField: _icgf4f53.BookingRoom.t.bookingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _icgf4f53.BookingRoomTable(tableRelation: foreignTableRelation),
    );
    return ___rooms!;
  }

  _is.ManyRelation<_icgf4f53.BookingRoomTable> get rooms {
    if (_rooms != null) return _rooms!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'rooms',
      field: Booking.t.id,
      foreignField: _icgf4f53.BookingRoom.t.bookingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _icgf4f53.BookingRoomTable(tableRelation: foreignTableRelation),
    );
    _rooms = _is.ManyRelation<_icgf4f53.BookingRoomTable>(
      tableWithRelations: relationTable,
      table: _icgf4f53.BookingRoomTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _rooms!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    createdAt,
    title,
    arrival,
    departure,
    leadId,
    organizationId,
    categoryId,
    status,
    optionExpiresAt,
    mealPlanId,
    billingMode,
    expectedGuestCount,
    notes,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'lead') {
      return lead;
    }
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'category') {
      return category;
    }
    if (relationField == 'mealPlan') {
      return mealPlan;
    }
    if (relationField == 'rooms') {
      return __rooms;
    }
    return null;
  }
}

class BookingInclude extends _is.IncludeObject {
  BookingInclude._({
    _imbxrfja.ContactInclude? lead,
    _i0w1hmpk.OrganizationInclude? organization,
    _i1nxuzrq.BookingCategoryInclude? category,
    _iqp4km0h.MealPlanInclude? mealPlan,
    _icgf4f53.BookingRoomIncludeList? rooms,
  }) {
    _lead = lead;
    _organization = organization;
    _category = category;
    _mealPlan = mealPlan;
    _rooms = rooms;
  }

  _imbxrfja.ContactInclude? _lead;

  _i0w1hmpk.OrganizationInclude? _organization;

  _i1nxuzrq.BookingCategoryInclude? _category;

  _iqp4km0h.MealPlanInclude? _mealPlan;

  _icgf4f53.BookingRoomIncludeList? _rooms;

  @override
  Map<String, _is.Include?> get includes => {
    'lead': _lead,
    'organization': _organization,
    'category': _category,
    'mealPlan': _mealPlan,
    'rooms': _rooms,
  };

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingIncludeList extends _is.IncludeList {
  BookingIncludeList._({
    _is.WhereExpressionBuilder<BookingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Booking.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingRepository {
  const BookingRepository._();

  final attach = const BookingAttachRepository._();

  final attachRow = const BookingAttachRowRepository._();

  final detachRow = const BookingDetachRowRepository._();

  /// Returns a list of [Booking]s matching the given query parameters.
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
  Future<List<Booking>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    BookingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Booking] matching the given query parameters.
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
  Future<Booking?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    BookingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Booking] by its [id] or null if no such row exists.
  Future<Booking?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    BookingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Booking>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Booking]s in the list and returns the inserted rows.
  ///
  /// The returned [Booking]s will have their `id` fields set.
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
  Future<List<Booking>> insert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Booking>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Booking] and returns the inserted row.
  ///
  /// The returned [Booking] will have its `id` field set.
  Future<Booking> insertRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Booking>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Booking]s in the list and returns the resulting rows.
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
  /// The returned [Booking]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> upsert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Booking>(
      rows,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Booking] and returns the resulting row.
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
  /// The returned [Booking] will have its `id` field set.
  Future<Booking?> upsertRow(
    _is.DatabaseSession session,
    Booking row, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Booking>(
      row,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> update(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Booking>(
      rows,
      columns: columns?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Booking]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Booking> updateRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Booking>(
      row,
      columns: columns?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Booking] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Booking?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Booking>(
      id,
      columnValues: columnValues(Booking.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Booking>(
      columnValues: columnValues(Booking.t.updateTable),
      where: where(Booking.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Booking]s in the list and returns the deleted rows.
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
  Future<List<Booking>> delete(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Booking>(
      rows,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Booking].
  Future<Booking> deleteRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Booking>(
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
  Future<List<Booking>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Booking>(
      where: where(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Booking>(
      where: where?.call(Booking.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Booking] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Booking>(
      where: where(Booking.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BookingAttachRepository {
  const BookingAttachRepository._();

  /// Creates a relation between this [Booking] and the given [BookingRoom]s
  /// by setting each [BookingRoom]'s foreign key `bookingId` to refer to this [Booking].
  Future<void> rooms(
    _is.DatabaseSession session,
    Booking booking,
    List<_icgf4f53.BookingRoom> bookingRoom, {
    _is.Transaction? transaction,
  }) async {
    if (bookingRoom.any((e) => e.id == null)) {
      throw ArgumentError.notNull('bookingRoom.id');
    }
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $bookingRoom = bookingRoom
        .map((e) => e.copyWith(bookingId: booking.id))
        .toList();
    await session.db.update<_icgf4f53.BookingRoom>(
      $bookingRoom,
      columns: [_icgf4f53.BookingRoom.t.bookingId],
      transaction: transaction,
    );
  }
}

class BookingAttachRowRepository {
  const BookingAttachRowRepository._();

  /// Creates a relation between the given [Booking] and [Contact]
  /// by setting the [Booking]'s foreign key `leadId` to refer to the [Contact].
  Future<void> lead(
    _is.DatabaseSession session,
    Booking booking,
    _imbxrfja.Contact lead, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }
    if (lead.id == null) {
      throw ArgumentError.notNull('lead.id');
    }

    var $booking = booking.copyWith(leadId: lead.id);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.leadId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Booking] and [Organization]
  /// by setting the [Booking]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _is.DatabaseSession session,
    Booking booking,
    _i0w1hmpk.Organization organization, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $booking = booking.copyWith(organizationId: organization.id);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Booking] and [BookingCategory]
  /// by setting the [Booking]'s foreign key `categoryId` to refer to the [BookingCategory].
  Future<void> category(
    _is.DatabaseSession session,
    Booking booking,
    _i1nxuzrq.BookingCategory category, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $booking = booking.copyWith(categoryId: category.id);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.categoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Booking] and [MealPlan]
  /// by setting the [Booking]'s foreign key `mealPlanId` to refer to the [MealPlan].
  Future<void> mealPlan(
    _is.DatabaseSession session,
    Booking booking,
    _iqp4km0h.MealPlan mealPlan, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }

    var $booking = booking.copyWith(mealPlanId: mealPlan.id);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.mealPlanId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Booking] and the given [BookingRoom]
  /// by setting the [BookingRoom]'s foreign key `bookingId` to refer to this [Booking].
  Future<void> rooms(
    _is.DatabaseSession session,
    Booking booking,
    _icgf4f53.BookingRoom bookingRoom, {
    _is.Transaction? transaction,
  }) async {
    if (bookingRoom.id == null) {
      throw ArgumentError.notNull('bookingRoom.id');
    }
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $bookingRoom = bookingRoom.copyWith(bookingId: booking.id);
    await session.db.updateRow<_icgf4f53.BookingRoom>(
      $bookingRoom,
      columns: [_icgf4f53.BookingRoom.t.bookingId],
      transaction: transaction,
    );
  }
}

class BookingDetachRowRepository {
  const BookingDetachRowRepository._();

  /// Detaches the relation between this [Booking] and the [Organization] set in `organization`
  /// by setting the [Booking]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _is.DatabaseSession session,
    Booking booking, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $booking = booking.copyWith(organizationId: null);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.organizationId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Booking] and the [BookingCategory] set in `category`
  /// by setting the [Booking]'s foreign key `categoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> category(
    _is.DatabaseSession session,
    Booking booking, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $booking = booking.copyWith(categoryId: null);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.categoryId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Booking] and the [MealPlan] set in `mealPlan`
  /// by setting the [Booking]'s foreign key `mealPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> mealPlan(
    _is.DatabaseSession session,
    Booking booking, {
    _is.Transaction? transaction,
  }) async {
    if (booking.id == null) {
      throw ArgumentError.notNull('booking.id');
    }

    var $booking = booking.copyWith(mealPlanId: null);
    await session.db.updateRow<Booking>(
      $booking,
      columns: [Booking.t.mealPlanId],
      transaction: transaction,
    );
  }
}
