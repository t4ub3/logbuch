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

abstract class MealRate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MealRate._({
    this.id,
    required this.seasonId,
    required this.mealPlanId,
    required this.ageGroupId,
    required this.pricePerNight,
  });

  factory MealRate({
    int? id,
    required int seasonId,
    required int mealPlanId,
    required int ageGroupId,
    required int pricePerNight,
  }) = _MealRateImpl;

  factory MealRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealRate(
      id: jsonSerialization['id'] as int?,
      seasonId: jsonSerialization['seasonId'] as int,
      mealPlanId: jsonSerialization['mealPlanId'] as int,
      ageGroupId: jsonSerialization['ageGroupId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int seasonId;

  int mealPlanId;

  int ageGroupId;

  int pricePerNight;

  /// Returns a shallow copy of this [MealRate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MealRate copyWith({
    int? id,
    int? seasonId,
    int? mealPlanId,
    int? ageGroupId,
    int? pricePerNight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'mealPlanId': mealPlanId,
      'ageGroupId': ageGroupId,
      'pricePerNight': pricePerNight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealRate',
      if (id != null) 'id': id,
      'seasonId': seasonId,
      'mealPlanId': mealPlanId,
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

class _MealRateImpl extends MealRate {
  _MealRateImpl({
    int? id,
    required int seasonId,
    required int mealPlanId,
    required int ageGroupId,
    required int pricePerNight,
  }) : super._(
         id: id,
         seasonId: seasonId,
         mealPlanId: mealPlanId,
         ageGroupId: ageGroupId,
         pricePerNight: pricePerNight,
       );

  /// Returns a shallow copy of this [MealRate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MealRate copyWith({
    Object? id = _Undefined,
    int? seasonId,
    int? mealPlanId,
    int? ageGroupId,
    int? pricePerNight,
  }) {
    return MealRate(
      id: id is int? ? id : this.id,
      seasonId: seasonId ?? this.seasonId,
      mealPlanId: mealPlanId ?? this.mealPlanId,
      ageGroupId: ageGroupId ?? this.ageGroupId,
      pricePerNight: pricePerNight ?? this.pricePerNight,
    );
  }
}
