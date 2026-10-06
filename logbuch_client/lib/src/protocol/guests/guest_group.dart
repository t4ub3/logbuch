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
import '../bookings/bookings.dart' as _i2jbfzmp;
import '../contacts/contact.dart' as _imbxrfja;
import '../guests/guest.dart' as _inwk3jth;

/// Guests of a booking who belong together, such as a family.
abstract class GuestGroup
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GuestGroup._({
    this.id,
    required this.bookingId,
    this.booking,
    required this.name,
    this.payerId,
    this.payer,
    int? sortOrder,
    this.guests,
  }) : sortOrder = sortOrder ?? 0;

  factory GuestGroup({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required String name,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? sortOrder,
    List<_inwk3jth.Guest>? guests,
  }) = _GuestGroupImpl;

  factory GuestGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuestGroup(
      id: jsonSerialization['id'] as int?,
      bookingId: jsonSerialization['bookingId'] as int,
      booking: jsonSerialization['booking'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i2jbfzmp.Booking>(
              jsonSerialization['booking'],
            ),
      name: jsonSerialization['name'] as String,
      payerId: jsonSerialization['payerId'] as int?,
      payer: jsonSerialization['payer'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['payer'],
            ),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      guests: jsonSerialization['guests'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_inwk3jth.Guest>>(
              jsonSerialization['guests'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookingId;

  _i2jbfzmp.Booking? booking;

  String name;

  int? payerId;

  /// Pays for the group if the booking is billed per group.
  _imbxrfja.Contact? payer;

  int sortOrder;

  List<_inwk3jth.Guest>? guests;

  /// Returns a shallow copy of this [GuestGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GuestGroup copyWith({
    int? id,
    int? bookingId,
    _i2jbfzmp.Booking? booking,
    String? name,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? sortOrder,
    List<_inwk3jth.Guest>? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GuestGroup',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJson(),
      'name': name,
      if (payerId != null) 'payerId': payerId,
      if (payer != null) 'payer': payer?.toJson(),
      'sortOrder': sortOrder,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GuestGroup',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJsonForProtocol(),
      'name': name,
      if (payerId != null) 'payerId': payerId,
      if (payer != null) 'payer': payer?.toJsonForProtocol(),
      'sortOrder': sortOrder,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestGroupImpl extends GuestGroup {
  _GuestGroupImpl({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required String name,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? sortOrder,
    List<_inwk3jth.Guest>? guests,
  }) : super._(
         id: id,
         bookingId: bookingId,
         booking: booking,
         name: name,
         payerId: payerId,
         payer: payer,
         sortOrder: sortOrder,
         guests: guests,
       );

  /// Returns a shallow copy of this [GuestGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GuestGroup copyWith({
    Object? id = _Undefined,
    int? bookingId,
    Object? booking = _Undefined,
    String? name,
    Object? payerId = _Undefined,
    Object? payer = _Undefined,
    int? sortOrder,
    Object? guests = _Undefined,
  }) {
    return GuestGroup(
      id: id is int? ? id : this.id,
      bookingId: bookingId ?? this.bookingId,
      booking: booking is _i2jbfzmp.Booking?
          ? booking
          : this.booking?.copyWith(),
      name: name ?? this.name,
      payerId: payerId is int? ? payerId : this.payerId,
      payer: payer is _imbxrfja.Contact? ? payer : this.payer?.copyWith(),
      sortOrder: sortOrder ?? this.sortOrder,
      guests: guests is List<_inwk3jth.Guest>?
          ? guests
          : this.guests?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
