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
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../bookings/bookings.dart' as _i2jbfzmp;
import '../rooms/room.dart' as _ij8xg2ak;

/// An invoice that charges a room which bookings share for another split
/// than the one in force now, for example because it was written before
/// another booking joined.
abstract class OutdatedShare
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OutdatedShare._({
    required this.booking,
    required this.room,
    required this.invoiceNumber,
  });

  factory OutdatedShare({
    required _i2jbfzmp.Booking booking,
    required _ij8xg2ak.Room room,
    required String invoiceNumber,
  }) = _OutdatedShareImpl;

  factory OutdatedShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return OutdatedShare(
      booking: _iil9w69f.Protocol().deserialize<_i2jbfzmp.Booking>(
        jsonSerialization['booking'],
      ),
      room: _iil9w69f.Protocol().deserialize<_ij8xg2ak.Room>(
        jsonSerialization['room'],
      ),
      invoiceNumber: jsonSerialization['invoiceNumber'] as String,
    );
  }

  /// The booking the invoice belongs to, without its relations.
  _i2jbfzmp.Booking booking;

  _ij8xg2ak.Room room;

  String invoiceNumber;

  /// Returns a shallow copy of this [OutdatedShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OutdatedShare copyWith({
    _i2jbfzmp.Booking? booking,
    _ij8xg2ak.Room? room,
    String? invoiceNumber,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OutdatedShare',
      'booking': booking.toJson(),
      'room': room.toJson(),
      'invoiceNumber': invoiceNumber,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OutdatedShare',
      'booking': booking.toJsonForProtocol(),
      'room': room.toJsonForProtocol(),
      'invoiceNumber': invoiceNumber,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OutdatedShareImpl extends OutdatedShare {
  _OutdatedShareImpl({
    required _i2jbfzmp.Booking booking,
    required _ij8xg2ak.Room room,
    required String invoiceNumber,
  }) : super._(
         booking: booking,
         room: room,
         invoiceNumber: invoiceNumber,
       );

  /// Returns a shallow copy of this [OutdatedShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OutdatedShare copyWith({
    _i2jbfzmp.Booking? booking,
    _ij8xg2ak.Room? room,
    String? invoiceNumber,
  }) {
    return OutdatedShare(
      booking: booking ?? this.booking.copyWith(),
      room: room ?? this.room.copyWith(),
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    );
  }
}
