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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// What a guest of an age group pays per night in a unit of a type.
abstract class RoomRate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomRate._({
    this.id,
    required this.priceListId,
    required this.unitTypeId,
    required this.ageGroupId,
    required this.pricePerNight,
  });

  factory RoomRate({
    int? id,
    required int priceListId,
    required int unitTypeId,
    required int ageGroupId,
    required int pricePerNight,
  }) = _RoomRateImpl;

  factory RoomRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomRate(
      id: jsonSerialization['id'] as int?,
      priceListId: jsonSerialization['priceListId'] as int,
      unitTypeId: jsonSerialization['unitTypeId'] as int,
      ageGroupId: jsonSerialization['ageGroupId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int priceListId;

  int unitTypeId;

  int ageGroupId;

  int pricePerNight;

  /// Returns a shallow copy of this [RoomRate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomRate copyWith({
    int? id,
    int? priceListId,
    int? unitTypeId,
    int? ageGroupId,
    int? pricePerNight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomRate',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'unitTypeId': unitTypeId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomRate',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'unitTypeId': unitTypeId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomRateImpl extends RoomRate {
  _RoomRateImpl({
    int? id,
    required int priceListId,
    required int unitTypeId,
    required int ageGroupId,
    required int pricePerNight,
  }) : super._(
         id: id,
         priceListId: priceListId,
         unitTypeId: unitTypeId,
         ageGroupId: ageGroupId,
         pricePerNight: pricePerNight,
       );

  /// Returns a shallow copy of this [RoomRate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomRate copyWith({
    Object? id = _Undefined,
    int? priceListId,
    int? unitTypeId,
    int? ageGroupId,
    int? pricePerNight,
  }) {
    return RoomRate(
      id: id is int? ? id : this.id,
      priceListId: priceListId ?? this.priceListId,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      ageGroupId: ageGroupId ?? this.ageGroupId,
      pricePerNight: pricePerNight ?? this.pricePerNight,
    );
  }
}
