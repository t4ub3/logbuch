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
import '../pricing/unit_type.dart' as _iwfco3zw;
import '../rooms/building.dart' as _ig4w4s7q;
import '../rooms/room_fee.dart' as _iv47he65;

/// A room, or a house that is booked as a whole, such as a bungalow.
abstract class Room
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Room._({
    this.id,
    required this.roomNumber,
    required this.bedAmount,
    this.buildingId,
    this.building,
    this.floor,
    required this.unitTypeId,
    this.unitType,
    bool? cribPossible,
    bool? active,
    this.notes,
    this.fees,
  }) : cribPossible = cribPossible ?? false,
       active = active ?? true;

  factory Room({
    int? id,
    required String roomNumber,
    required int bedAmount,
    int? buildingId,
    _ig4w4s7q.Building? building,
    String? floor,
    required int unitTypeId,
    _iwfco3zw.UnitType? unitType,
    bool? cribPossible,
    bool? active,
    String? notes,
    List<_iv47he65.RoomFee>? fees,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      roomNumber: jsonSerialization['roomNumber'] as String,
      bedAmount: jsonSerialization['bedAmount'] as int,
      buildingId: jsonSerialization['buildingId'] as int?,
      building: jsonSerialization['building'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_ig4w4s7q.Building>(
              jsonSerialization['building'],
            ),
      floor: jsonSerialization['floor'] as String?,
      unitTypeId: jsonSerialization['unitTypeId'] as int,
      unitType: jsonSerialization['unitType'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_iwfco3zw.UnitType>(
              jsonSerialization['unitType'],
            ),
      cribPossible: jsonSerialization['cribPossible'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['cribPossible']),
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      notes: jsonSerialization['notes'] as String?,
      fees: jsonSerialization['fees'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_iv47he65.RoomFee>>(
              jsonSerialization['fees'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String roomNumber;

  int bedAmount;

  int? buildingId;

  _ig4w4s7q.Building? building;

  String? floor;

  int unitTypeId;

  _iwfco3zw.UnitType? unitType;

  bool cribPossible;

  bool active;

  String? notes;

  /// The surcharges of the room.
  List<_iv47he65.RoomFee>? fees;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Room copyWith({
    int? id,
    String? roomNumber,
    int? bedAmount,
    int? buildingId,
    _ig4w4s7q.Building? building,
    String? floor,
    int? unitTypeId,
    _iwfco3zw.UnitType? unitType,
    bool? cribPossible,
    bool? active,
    String? notes,
    List<_iv47he65.RoomFee>? fees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      'bedAmount': bedAmount,
      if (buildingId != null) 'buildingId': buildingId,
      if (building != null) 'building': building?.toJson(),
      if (floor != null) 'floor': floor,
      'unitTypeId': unitTypeId,
      if (unitType != null) 'unitType': unitType?.toJson(),
      'cribPossible': cribPossible,
      'active': active,
      if (notes != null) 'notes': notes,
      if (fees != null) 'fees': fees?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      'bedAmount': bedAmount,
      if (buildingId != null) 'buildingId': buildingId,
      if (building != null) 'building': building?.toJsonForProtocol(),
      if (floor != null) 'floor': floor,
      'unitTypeId': unitTypeId,
      if (unitType != null) 'unitType': unitType?.toJsonForProtocol(),
      'cribPossible': cribPossible,
      'active': active,
      if (notes != null) 'notes': notes,
      if (fees != null)
        'fees': fees?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required String roomNumber,
    required int bedAmount,
    int? buildingId,
    _ig4w4s7q.Building? building,
    String? floor,
    required int unitTypeId,
    _iwfco3zw.UnitType? unitType,
    bool? cribPossible,
    bool? active,
    String? notes,
    List<_iv47he65.RoomFee>? fees,
  }) : super._(
         id: id,
         roomNumber: roomNumber,
         bedAmount: bedAmount,
         buildingId: buildingId,
         building: building,
         floor: floor,
         unitTypeId: unitTypeId,
         unitType: unitType,
         cribPossible: cribPossible,
         active: active,
         notes: notes,
         fees: fees,
       );

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    String? roomNumber,
    int? bedAmount,
    Object? buildingId = _Undefined,
    Object? building = _Undefined,
    Object? floor = _Undefined,
    int? unitTypeId,
    Object? unitType = _Undefined,
    bool? cribPossible,
    bool? active,
    Object? notes = _Undefined,
    Object? fees = _Undefined,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      bedAmount: bedAmount ?? this.bedAmount,
      buildingId: buildingId is int? ? buildingId : this.buildingId,
      building: building is _ig4w4s7q.Building?
          ? building
          : this.building?.copyWith(),
      floor: floor is String? ? floor : this.floor,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      unitType: unitType is _iwfco3zw.UnitType?
          ? unitType
          : this.unitType?.copyWith(),
      cribPossible: cribPossible ?? this.cribPossible,
      active: active ?? this.active,
      notes: notes is String? ? notes : this.notes,
      fees: fees is List<_iv47he65.RoomFee>?
          ? fees
          : this.fees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
