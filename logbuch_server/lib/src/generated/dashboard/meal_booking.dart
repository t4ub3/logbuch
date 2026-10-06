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
import '../guests/age_group_count.dart' as _i3vskobn;

/// The guests of one booking who are in the house on a day.
abstract class MealBooking
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MealBooking._({
    required this.bookingId,
    required this.title,
    this.mealPlan,
    required this.guestCount,
    required this.ageGroups,
    required this.unknownAge,
  });

  factory MealBooking({
    required int bookingId,
    required String title,
    String? mealPlan,
    required int guestCount,
    required List<_i3vskobn.AgeGroupCount> ageGroups,
    required int unknownAge,
  }) = _MealBookingImpl;

  factory MealBooking.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealBooking(
      bookingId: jsonSerialization['bookingId'] as int,
      title: jsonSerialization['title'] as String,
      mealPlan: jsonSerialization['mealPlan'] as String?,
      guestCount: jsonSerialization['guestCount'] as int,
      ageGroups: _iil9w69f.Protocol()
          .deserialize<List<_i3vskobn.AgeGroupCount>>(
            jsonSerialization['ageGroups'],
          ),
      unknownAge: jsonSerialization['unknownAge'] as int,
    );
  }

  int bookingId;

  String title;

  /// The name of its meal plan, if it has one.
  String? mealPlan;

  int guestCount;

  /// The age groups that have guests in this booking, youngest first.
  List<_i3vskobn.AgeGroupCount> ageGroups;

  int unknownAge;

  /// Returns a shallow copy of this [MealBooking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MealBooking copyWith({
    int? bookingId,
    String? title,
    String? mealPlan,
    int? guestCount,
    List<_i3vskobn.AgeGroupCount>? ageGroups,
    int? unknownAge,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealBooking',
      'bookingId': bookingId,
      'title': title,
      if (mealPlan != null) 'mealPlan': mealPlan,
      'guestCount': guestCount,
      'ageGroups': ageGroups.toJson(valueToJson: (v) => v.toJson()),
      'unknownAge': unknownAge,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealBooking',
      'bookingId': bookingId,
      'title': title,
      if (mealPlan != null) 'mealPlan': mealPlan,
      'guestCount': guestCount,
      'ageGroups': ageGroups.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'unknownAge': unknownAge,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealBookingImpl extends MealBooking {
  _MealBookingImpl({
    required int bookingId,
    required String title,
    String? mealPlan,
    required int guestCount,
    required List<_i3vskobn.AgeGroupCount> ageGroups,
    required int unknownAge,
  }) : super._(
         bookingId: bookingId,
         title: title,
         mealPlan: mealPlan,
         guestCount: guestCount,
         ageGroups: ageGroups,
         unknownAge: unknownAge,
       );

  /// Returns a shallow copy of this [MealBooking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MealBooking copyWith({
    int? bookingId,
    String? title,
    Object? mealPlan = _Undefined,
    int? guestCount,
    List<_i3vskobn.AgeGroupCount>? ageGroups,
    int? unknownAge,
  }) {
    return MealBooking(
      bookingId: bookingId ?? this.bookingId,
      title: title ?? this.title,
      mealPlan: mealPlan is String? ? mealPlan : this.mealPlan,
      guestCount: guestCount ?? this.guestCount,
      ageGroups:
          ageGroups ?? this.ageGroups.map((e0) => e0.copyWith()).toList(),
      unknownAge: unknownAge ?? this.unknownAge,
    );
  }
}
