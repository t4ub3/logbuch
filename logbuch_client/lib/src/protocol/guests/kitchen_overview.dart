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
import '../guests/age_group_count.dart' as _i3vskobn;
import '../guests/dietary_need.dart' as _i6hkad28;

/// What the kitchen needs to know about a booking.
abstract class KitchenOverview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  KitchenOverview._({
    required this.guestCount,
    required this.ageGroups,
    required this.unknownAge,
    required this.dietaryNeeds,
  });

  factory KitchenOverview({
    required int guestCount,
    required List<_i3vskobn.AgeGroupCount> ageGroups,
    required int unknownAge,
    required List<_i6hkad28.DietaryNeed> dietaryNeeds,
  }) = _KitchenOverviewImpl;

  factory KitchenOverview.fromJson(Map<String, dynamic> jsonSerialization) {
    return KitchenOverview(
      guestCount: jsonSerialization['guestCount'] as int,
      ageGroups: _i7rf0d0e.Protocol()
          .deserialize<List<_i3vskobn.AgeGroupCount>>(
            jsonSerialization['ageGroups'],
          ),
      unknownAge: jsonSerialization['unknownAge'] as int,
      dietaryNeeds: _i7rf0d0e.Protocol()
          .deserialize<List<_i6hkad28.DietaryNeed>>(
            jsonSerialization['dietaryNeeds'],
          ),
    );
  }

  int guestCount;

  /// Every age group, youngest first, with the number of its guests.
  List<_i3vskobn.AgeGroupCount> ageGroups;

  /// Guests with neither a birth date nor an age group.
  int unknownAge;

  List<_i6hkad28.DietaryNeed> dietaryNeeds;

  /// Returns a shallow copy of this [KitchenOverview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  KitchenOverview copyWith({
    int? guestCount,
    List<_i3vskobn.AgeGroupCount>? ageGroups,
    int? unknownAge,
    List<_i6hkad28.DietaryNeed>? dietaryNeeds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KitchenOverview',
      'guestCount': guestCount,
      'ageGroups': ageGroups.toJson(valueToJson: (v) => v.toJson()),
      'unknownAge': unknownAge,
      'dietaryNeeds': dietaryNeeds.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'KitchenOverview',
      'guestCount': guestCount,
      'ageGroups': ageGroups.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'unknownAge': unknownAge,
      'dietaryNeeds': dietaryNeeds.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _KitchenOverviewImpl extends KitchenOverview {
  _KitchenOverviewImpl({
    required int guestCount,
    required List<_i3vskobn.AgeGroupCount> ageGroups,
    required int unknownAge,
    required List<_i6hkad28.DietaryNeed> dietaryNeeds,
  }) : super._(
         guestCount: guestCount,
         ageGroups: ageGroups,
         unknownAge: unknownAge,
         dietaryNeeds: dietaryNeeds,
       );

  /// Returns a shallow copy of this [KitchenOverview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  KitchenOverview copyWith({
    int? guestCount,
    List<_i3vskobn.AgeGroupCount>? ageGroups,
    int? unknownAge,
    List<_i6hkad28.DietaryNeed>? dietaryNeeds,
  }) {
    return KitchenOverview(
      guestCount: guestCount ?? this.guestCount,
      ageGroups:
          ageGroups ?? this.ageGroups.map((e0) => e0.copyWith()).toList(),
      unknownAge: unknownAge ?? this.unknownAge,
      dietaryNeeds:
          dietaryNeeds ?? this.dietaryNeeds.map((e0) => e0.copyWith()).toList(),
    );
  }
}
