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
import 'package:serverpod/serverpod.dart' as _is;

enum PricingProblemReason implements _is.SerializableModel {
  datesMissing,
  ageUnknown,
  roomMissing,
  seasonMissing,
  roomRateMissing,
  mealRateMissing;

  static PricingProblemReason fromJson(String name) {
    switch (name) {
      case 'datesMissing':
        return PricingProblemReason.datesMissing;
      case 'ageUnknown':
        return PricingProblemReason.ageUnknown;
      case 'roomMissing':
        return PricingProblemReason.roomMissing;
      case 'seasonMissing':
        return PricingProblemReason.seasonMissing;
      case 'roomRateMissing':
        return PricingProblemReason.roomRateMissing;
      case 'mealRateMissing':
        return PricingProblemReason.mealRateMissing;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "PricingProblemReason"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
