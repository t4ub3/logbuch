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

abstract class RoomRate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomRate._({
    this.id,
    required this.seasonId,
    required this.priceCategoryId,
    required this.ageGroupId,
    required this.pricePerNight,
  });

  factory RoomRate({
    int? id,
    required int seasonId,
    required int priceCategoryId,
    required int ageGroupId,
    required int pricePerNight,
  }) = _RoomRateImpl;

  factory RoomRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomRate(
      id: jsonSerialization['id'] as int?,
      seasonId: jsonSerialization['seasonId'] as int,
      priceCategoryId: jsonSerialization['priceCategoryId'] as int,
      ageGroupId: jsonSerialization['ageGroupId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int seasonId;

  int priceCategoryId;

  int ageGroupId;

  int pricePerNight;

  /// Returns a shallow copy of this [RoomRate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomRate copyWith({
    int? id,
    int? seasonId,
    int? priceCategoryId,
    int? ageGroupId,
    int? pricePerNight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'priceCategoryId': priceCategoryId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'priceCategoryId': priceCategoryId,
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
    required int seasonId,
    required int priceCategoryId,
    required int ageGroupId,
    required int pricePerNight,
  }) : super._(
         id: id,
         seasonId: seasonId,
         priceCategoryId: priceCategoryId,
         ageGroupId: ageGroupId,
         pricePerNight: pricePerNight,
       );

  /// Returns a shallow copy of this [RoomRate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomRate copyWith({
    Object? id = _Undefined,
    int? seasonId,
    int? priceCategoryId,
    int? ageGroupId,
    int? pricePerNight,
  }) {
    return RoomRate(
      id: id is int? ? id : this.id,
      seasonId: seasonId ?? this.seasonId,
      priceCategoryId: priceCategoryId ?? this.priceCategoryId,
      ageGroupId: ageGroupId ?? this.ageGroupId,
      pricePerNight: pricePerNight ?? this.pricePerNight,
    );
  }
}
