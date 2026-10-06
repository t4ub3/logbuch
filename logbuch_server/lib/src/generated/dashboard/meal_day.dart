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
import '../dashboard/meal_booking.dart' as _iir8l8yx;
import '../guests/age_group_count.dart' as _i3vskobn;

/// Everybody who is in the house on a day and is to be catered for.
abstract class MealDay
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MealDay._({
    required this.date,
    required this.bookings,
    required this.guestCount,
    required this.ageGroups,
    required this.unknownAge,
  });

  factory MealDay({
    required DateTime date,
    required List<_iir8l8yx.MealBooking> bookings,
    required int guestCount,
    required List<_i3vskobn.AgeGroupCount> ageGroups,
    required int unknownAge,
  }) = _MealDayImpl;

  factory MealDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealDay(
      date: _is.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      bookings: _iil9w69f.Protocol().deserialize<List<_iir8l8yx.MealBooking>>(
        jsonSerialization['bookings'],
      ),
      guestCount: jsonSerialization['guestCount'] as int,
      ageGroups: _iil9w69f.Protocol()
          .deserialize<List<_i3vskobn.AgeGroupCount>>(
            jsonSerialization['ageGroups'],
          ),
      unknownAge: jsonSerialization['unknownAge'] as int,
    );
  }

  DateTime date;

  List<_iir8l8yx.MealBooking> bookings;

  int guestCount;

  /// Every age group, youngest first, with the number of its guests.
  List<_i3vskobn.AgeGroupCount> ageGroups;

  int unknownAge;

  /// Returns a shallow copy of this [MealDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MealDay copyWith({
    DateTime? date,
    List<_iir8l8yx.MealBooking>? bookings,
    int? guestCount,
    List<_i3vskobn.AgeGroupCount>? ageGroups,
    int? unknownAge,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealDay',
      'date': date.toJson(),
      'bookings': bookings.toJson(valueToJson: (v) => v.toJson()),
      'guestCount': guestCount,
      'ageGroups': ageGroups.toJson(valueToJson: (v) => v.toJson()),
      'unknownAge': unknownAge,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealDay',
      'date': date.toJson(),
      'bookings': bookings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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

class _MealDayImpl extends MealDay {
  _MealDayImpl({
    required DateTime date,
    required List<_iir8l8yx.MealBooking> bookings,
    required int guestCount,
    required List<_i3vskobn.AgeGroupCount> ageGroups,
    required int unknownAge,
  }) : super._(
         date: date,
         bookings: bookings,
         guestCount: guestCount,
         ageGroups: ageGroups,
         unknownAge: unknownAge,
       );

  /// Returns a shallow copy of this [MealDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MealDay copyWith({
    DateTime? date,
    List<_iir8l8yx.MealBooking>? bookings,
    int? guestCount,
    List<_i3vskobn.AgeGroupCount>? ageGroups,
    int? unknownAge,
  }) {
    return MealDay(
      date: date ?? this.date,
      bookings: bookings ?? this.bookings.map((e0) => e0.copyWith()).toList(),
      guestCount: guestCount ?? this.guestCount,
      ageGroups:
          ageGroups ?? this.ageGroups.map((e0) => e0.copyWith()).toList(),
      unknownAge: unknownAge ?? this.unknownAge,
    );
  }
}
