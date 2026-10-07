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
import 'package:logbuch_client/src/protocol/protocol.dart' as _i7rf0d0e;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../bookings/billing_mode.dart' as _ikjlxdwh;
import '../bookings/booking_category.dart' as _i1nxuzrq;
import '../bookings/booking_room.dart' as _icgf4f53;
import '../bookings/booking_status.dart' as _ilk1qg37;
import '../contacts/contact.dart' as _imbxrfja;
import '../contacts/organization.dart' as _i0w1hmpk;
import '../pricing/meal_plan.dart' as _iqp4km0h;

abstract class Booking
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      title: jsonSerialization['title'] as String,
      arrival: jsonSerialization['arrival'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['arrival']),
      departure: jsonSerialization['departure'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['departure']),
      leadId: jsonSerialization['leadId'] as int,
      lead: jsonSerialization['lead'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['lead'],
            ),
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i0w1hmpk.Organization>(
              jsonSerialization['organization'],
            ),
      categoryId: jsonSerialization['categoryId'] as int?,
      category: jsonSerialization['category'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i1nxuzrq.BookingCategory>(
              jsonSerialization['category'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _ilk1qg37.BookingStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      optionExpiresAt: jsonSerialization['optionExpiresAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['optionExpiresAt'],
            ),
      mealPlanId: jsonSerialization['mealPlanId'] as int?,
      mealPlan: jsonSerialization['mealPlan'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_iqp4km0h.MealPlan>(
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
          : _i7rf0d0e.Protocol().deserialize<List<_icgf4f53.BookingRoom>>(
              jsonSerialization['rooms'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
