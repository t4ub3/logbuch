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
import '../rooms/room.dart' as _ij8xg2ak;

/// A room that a booking holds for all of its nights.
abstract class BookingRoom
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BookingRoom._({
    this.id,
    required this.bookingId,
    this.booking,
    required this.roomId,
    this.room,
  });

  factory BookingRoom({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int roomId,
    _ij8xg2ak.Room? room,
  }) = _BookingRoomImpl;

  factory BookingRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingRoom(
      id: jsonSerialization['id'] as int?,
      bookingId: jsonSerialization['bookingId'] as int,
      booking: jsonSerialization['booking'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i2jbfzmp.Booking>(
              jsonSerialization['booking'],
            ),
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_ij8xg2ak.Room>(
              jsonSerialization['room'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookingId;

  _i2jbfzmp.Booking? booking;

  int roomId;

  _ij8xg2ak.Room? room;

  /// Returns a shallow copy of this [BookingRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BookingRoom copyWith({
    int? id,
    int? bookingId,
    _i2jbfzmp.Booking? booking,
    int? roomId,
    _ij8xg2ak.Room? room,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingRoom',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJson(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingRoom',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJsonForProtocol(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingRoomImpl extends BookingRoom {
  _BookingRoomImpl({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int roomId,
    _ij8xg2ak.Room? room,
  }) : super._(
         id: id,
         bookingId: bookingId,
         booking: booking,
         roomId: roomId,
         room: room,
       );

  /// Returns a shallow copy of this [BookingRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BookingRoom copyWith({
    Object? id = _Undefined,
    int? bookingId,
    Object? booking = _Undefined,
    int? roomId,
    Object? room = _Undefined,
  }) {
    return BookingRoom(
      id: id is int? ? id : this.id,
      bookingId: bookingId ?? this.bookingId,
      booking: booking is _i2jbfzmp.Booking?
          ? booking
          : this.booking?.copyWith(),
      roomId: roomId ?? this.roomId,
      room: room is _ij8xg2ak.Room? ? room : this.room?.copyWith(),
    );
  }
}
