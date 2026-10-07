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

enum BookingCategoryColor implements _isc.SerializableModel {
  orange,
  bark,
  sage,
  olive,
  viridian,
  prussianGreen,
  blue,
  purple,
  magenta,
  red,
  wartyBrown,
  adwaitaBlue,
  adwaitaTeal,
  adwaitaGreen,
  adwaitaYellow,
  adwaitaOrange,
  adwaitaRed,
  adwaitaPink,
  adwaitaPurple,
  adwaitaSlate;

  static BookingCategoryColor fromJson(String name) {
    switch (name) {
      case 'orange':
        return BookingCategoryColor.orange;
      case 'bark':
        return BookingCategoryColor.bark;
      case 'sage':
        return BookingCategoryColor.sage;
      case 'olive':
        return BookingCategoryColor.olive;
      case 'viridian':
        return BookingCategoryColor.viridian;
      case 'prussianGreen':
        return BookingCategoryColor.prussianGreen;
      case 'blue':
        return BookingCategoryColor.blue;
      case 'purple':
        return BookingCategoryColor.purple;
      case 'magenta':
        return BookingCategoryColor.magenta;
      case 'red':
        return BookingCategoryColor.red;
      case 'wartyBrown':
        return BookingCategoryColor.wartyBrown;
      case 'adwaitaBlue':
        return BookingCategoryColor.adwaitaBlue;
      case 'adwaitaTeal':
        return BookingCategoryColor.adwaitaTeal;
      case 'adwaitaGreen':
        return BookingCategoryColor.adwaitaGreen;
      case 'adwaitaYellow':
        return BookingCategoryColor.adwaitaYellow;
      case 'adwaitaOrange':
        return BookingCategoryColor.adwaitaOrange;
      case 'adwaitaRed':
        return BookingCategoryColor.adwaitaRed;
      case 'adwaitaPink':
        return BookingCategoryColor.adwaitaPink;
      case 'adwaitaPurple':
        return BookingCategoryColor.adwaitaPurple;
      case 'adwaitaSlate':
        return BookingCategoryColor.adwaitaSlate;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "BookingCategoryColor"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
