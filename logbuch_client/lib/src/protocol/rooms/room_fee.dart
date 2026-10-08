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
import '../pricing/fee.dart' as _iudlpryb;
import '../rooms/room.dart' as _ij8xg2ak;

/// A surcharge that a room has.
abstract class RoomFee
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomFee._({
    this.id,
    required this.roomId,
    this.room,
    required this.feeId,
    this.fee,
  });

  factory RoomFee({
    int? id,
    required int roomId,
    _ij8xg2ak.Room? room,
    required int feeId,
    _iudlpryb.Fee? fee,
  }) = _RoomFeeImpl;

  factory RoomFee.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomFee(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_ij8xg2ak.Room>(
              jsonSerialization['room'],
            ),
      feeId: jsonSerialization['feeId'] as int,
      fee: jsonSerialization['fee'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_iudlpryb.Fee>(
              jsonSerialization['fee'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  _ij8xg2ak.Room? room;

  int feeId;

  _iudlpryb.Fee? fee;

  /// Returns a shallow copy of this [RoomFee]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomFee copyWith({
    int? id,
    int? roomId,
    _ij8xg2ak.Room? room,
    int? feeId,
    _iudlpryb.Fee? fee,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomFee',
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'feeId': feeId,
      if (fee != null) 'fee': fee?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomFee',
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
      'feeId': feeId,
      if (fee != null) 'fee': fee?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomFeeImpl extends RoomFee {
  _RoomFeeImpl({
    int? id,
    required int roomId,
    _ij8xg2ak.Room? room,
    required int feeId,
    _iudlpryb.Fee? fee,
  }) : super._(
         id: id,
         roomId: roomId,
         room: room,
         feeId: feeId,
         fee: fee,
       );

  /// Returns a shallow copy of this [RoomFee]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomFee copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    int? feeId,
    Object? fee = _Undefined,
  }) {
    return RoomFee(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _ij8xg2ak.Room? ? room : this.room?.copyWith(),
      feeId: feeId ?? this.feeId,
      fee: fee is _iudlpryb.Fee? ? fee : this.fee?.copyWith(),
    );
  }
}
