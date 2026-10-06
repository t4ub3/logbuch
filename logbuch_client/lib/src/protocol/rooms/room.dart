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
import '../pricing/price_category.dart' as _io5akotj;

abstract class Room
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Room._({
    this.id,
    required this.roomNumber,
    required this.bedAmount,
    this.building,
    this.floor,
    required this.priceCategoryId,
    this.priceCategory,
    bool? cribPossible,
    bool? active,
    this.notes,
  }) : cribPossible = cribPossible ?? false,
       active = active ?? true;

  factory Room({
    int? id,
    required String roomNumber,
    required int bedAmount,
    String? building,
    String? floor,
    required int priceCategoryId,
    _io5akotj.PriceCategory? priceCategory,
    bool? cribPossible,
    bool? active,
    String? notes,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      roomNumber: jsonSerialization['roomNumber'] as String,
      bedAmount: jsonSerialization['bedAmount'] as int,
      building: jsonSerialization['building'] as String?,
      floor: jsonSerialization['floor'] as String?,
      priceCategoryId: jsonSerialization['priceCategoryId'] as int,
      priceCategory: jsonSerialization['priceCategory'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_io5akotj.PriceCategory>(
              jsonSerialization['priceCategory'],
            ),
      cribPossible: jsonSerialization['cribPossible'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['cribPossible']),
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String roomNumber;

  int bedAmount;

  String? building;

  String? floor;

  int priceCategoryId;

  _io5akotj.PriceCategory? priceCategory;

  bool cribPossible;

  bool active;

  String? notes;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Room copyWith({
    int? id,
    String? roomNumber,
    int? bedAmount,
    String? building,
    String? floor,
    int? priceCategoryId,
    _io5akotj.PriceCategory? priceCategory,
    bool? cribPossible,
    bool? active,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      'bedAmount': bedAmount,
      if (building != null) 'building': building,
      if (floor != null) 'floor': floor,
      'priceCategoryId': priceCategoryId,
      if (priceCategory != null) 'priceCategory': priceCategory?.toJson(),
      'cribPossible': cribPossible,
      'active': active,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      'bedAmount': bedAmount,
      if (building != null) 'building': building,
      if (floor != null) 'floor': floor,
      'priceCategoryId': priceCategoryId,
      if (priceCategory != null)
        'priceCategory': priceCategory?.toJsonForProtocol(),
      'cribPossible': cribPossible,
      'active': active,
      if (notes != null) 'notes': notes,
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
    String? building,
    String? floor,
    required int priceCategoryId,
    _io5akotj.PriceCategory? priceCategory,
    bool? cribPossible,
    bool? active,
    String? notes,
  }) : super._(
         id: id,
         roomNumber: roomNumber,
         bedAmount: bedAmount,
         building: building,
         floor: floor,
         priceCategoryId: priceCategoryId,
         priceCategory: priceCategory,
         cribPossible: cribPossible,
         active: active,
         notes: notes,
       );

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    String? roomNumber,
    int? bedAmount,
    Object? building = _Undefined,
    Object? floor = _Undefined,
    int? priceCategoryId,
    Object? priceCategory = _Undefined,
    bool? cribPossible,
    bool? active,
    Object? notes = _Undefined,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      bedAmount: bedAmount ?? this.bedAmount,
      building: building is String? ? building : this.building,
      floor: floor is String? ? floor : this.floor,
      priceCategoryId: priceCategoryId ?? this.priceCategoryId,
      priceCategory: priceCategory is _io5akotj.PriceCategory?
          ? priceCategory
          : this.priceCategory?.copyWith(),
      cribPossible: cribPossible ?? this.cribPossible,
      active: active ?? this.active,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
