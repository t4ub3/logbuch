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
import '../bookings/booking_room.dart' as _icgf4f53;
import '../contacts/contact.dart' as _imbxrfja;
import '../guests/guest_group.dart' as _it76xumr;
import '../pricing/age_group.dart' as _iwfwnbly;

/// A contact staying with a booking, in one of the rooms it holds.
abstract class Guest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Guest._({
    this.id,
    required this.groupId,
    this.group,
    required this.contactId,
    this.contact,
    this.bookingRoomId,
    this.bookingRoom,
    bool? needsCrib,
    this.ageGroupOverrideId,
    this.ageGroupOverride,
    this.arrivalOverride,
    this.departureOverride,
    this.dietaryNotes,
  }) : needsCrib = needsCrib ?? false;

  factory Guest({
    int? id,
    required int groupId,
    _it76xumr.GuestGroup? group,
    required int contactId,
    _imbxrfja.Contact? contact,
    int? bookingRoomId,
    _icgf4f53.BookingRoom? bookingRoom,
    bool? needsCrib,
    int? ageGroupOverrideId,
    _iwfwnbly.AgeGroup? ageGroupOverride,
    DateTime? arrivalOverride,
    DateTime? departureOverride,
    String? dietaryNotes,
  }) = _GuestImpl;

  factory Guest.fromJson(Map<String, dynamic> jsonSerialization) {
    return Guest(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      group: jsonSerialization['group'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_it76xumr.GuestGroup>(
              jsonSerialization['group'],
            ),
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
      bookingRoomId: jsonSerialization['bookingRoomId'] as int?,
      bookingRoom: jsonSerialization['bookingRoom'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_icgf4f53.BookingRoom>(
              jsonSerialization['bookingRoom'],
            ),
      needsCrib: jsonSerialization['needsCrib'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['needsCrib']),
      ageGroupOverrideId: jsonSerialization['ageGroupOverrideId'] as int?,
      ageGroupOverride: jsonSerialization['ageGroupOverride'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_iwfwnbly.AgeGroup>(
              jsonSerialization['ageGroupOverride'],
            ),
      arrivalOverride: jsonSerialization['arrivalOverride'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['arrivalOverride'],
            ),
      departureOverride: jsonSerialization['departureOverride'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['departureOverride'],
            ),
      dietaryNotes: jsonSerialization['dietaryNotes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int groupId;

  _it76xumr.GuestGroup? group;

  int contactId;

  _imbxrfja.Contact? contact;

  int? bookingRoomId;

  /// Null while the guest is not assigned to a room yet.
  _icgf4f53.BookingRoom? bookingRoom;

  bool needsCrib;

  int? ageGroupOverrideId;

  /// Used instead of the age from the birth date of the contact.
  _iwfwnbly.AgeGroup? ageGroupOverride;

  /// Set for the rare guest who arrives later or departs earlier than the
  /// booking.
  DateTime? arrivalOverride;

  DateTime? departureOverride;

  String? dietaryNotes;

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Guest copyWith({
    int? id,
    int? groupId,
    _it76xumr.GuestGroup? group,
    int? contactId,
    _imbxrfja.Contact? contact,
    int? bookingRoomId,
    _icgf4f53.BookingRoom? bookingRoom,
    bool? needsCrib,
    int? ageGroupOverrideId,
    _iwfwnbly.AgeGroup? ageGroupOverride,
    DateTime? arrivalOverride,
    DateTime? departureOverride,
    String? dietaryNotes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'groupId': groupId,
      if (group != null) 'group': group?.toJson(),
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
      if (bookingRoomId != null) 'bookingRoomId': bookingRoomId,
      if (bookingRoom != null) 'bookingRoom': bookingRoom?.toJson(),
      'needsCrib': needsCrib,
      if (ageGroupOverrideId != null) 'ageGroupOverrideId': ageGroupOverrideId,
      if (ageGroupOverride != null)
        'ageGroupOverride': ageGroupOverride?.toJson(),
      if (arrivalOverride != null) 'arrivalOverride': arrivalOverride?.toJson(),
      if (departureOverride != null)
        'departureOverride': departureOverride?.toJson(),
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'groupId': groupId,
      if (group != null) 'group': group?.toJsonForProtocol(),
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
      if (bookingRoomId != null) 'bookingRoomId': bookingRoomId,
      if (bookingRoom != null) 'bookingRoom': bookingRoom?.toJsonForProtocol(),
      'needsCrib': needsCrib,
      if (ageGroupOverrideId != null) 'ageGroupOverrideId': ageGroupOverrideId,
      if (ageGroupOverride != null)
        'ageGroupOverride': ageGroupOverride?.toJsonForProtocol(),
      if (arrivalOverride != null) 'arrivalOverride': arrivalOverride?.toJson(),
      if (departureOverride != null)
        'departureOverride': departureOverride?.toJson(),
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required int groupId,
    _it76xumr.GuestGroup? group,
    required int contactId,
    _imbxrfja.Contact? contact,
    int? bookingRoomId,
    _icgf4f53.BookingRoom? bookingRoom,
    bool? needsCrib,
    int? ageGroupOverrideId,
    _iwfwnbly.AgeGroup? ageGroupOverride,
    DateTime? arrivalOverride,
    DateTime? departureOverride,
    String? dietaryNotes,
  }) : super._(
         id: id,
         groupId: groupId,
         group: group,
         contactId: contactId,
         contact: contact,
         bookingRoomId: bookingRoomId,
         bookingRoom: bookingRoom,
         needsCrib: needsCrib,
         ageGroupOverrideId: ageGroupOverrideId,
         ageGroupOverride: ageGroupOverride,
         arrivalOverride: arrivalOverride,
         departureOverride: departureOverride,
         dietaryNotes: dietaryNotes,
       );

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Guest copyWith({
    Object? id = _Undefined,
    int? groupId,
    Object? group = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
    Object? bookingRoomId = _Undefined,
    Object? bookingRoom = _Undefined,
    bool? needsCrib,
    Object? ageGroupOverrideId = _Undefined,
    Object? ageGroupOverride = _Undefined,
    Object? arrivalOverride = _Undefined,
    Object? departureOverride = _Undefined,
    Object? dietaryNotes = _Undefined,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      group: group is _it76xumr.GuestGroup? ? group : this.group?.copyWith(),
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
      bookingRoomId: bookingRoomId is int? ? bookingRoomId : this.bookingRoomId,
      bookingRoom: bookingRoom is _icgf4f53.BookingRoom?
          ? bookingRoom
          : this.bookingRoom?.copyWith(),
      needsCrib: needsCrib ?? this.needsCrib,
      ageGroupOverrideId: ageGroupOverrideId is int?
          ? ageGroupOverrideId
          : this.ageGroupOverrideId,
      ageGroupOverride: ageGroupOverride is _iwfwnbly.AgeGroup?
          ? ageGroupOverride
          : this.ageGroupOverride?.copyWith(),
      arrivalOverride: arrivalOverride is DateTime?
          ? arrivalOverride
          : this.arrivalOverride,
      departureOverride: departureOverride is DateTime?
          ? departureOverride
          : this.departureOverride,
      dietaryNotes: dietaryNotes is String? ? dietaryNotes : this.dietaryNotes,
    );
  }
}
