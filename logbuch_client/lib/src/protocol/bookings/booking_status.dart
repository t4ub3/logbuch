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

enum BookingStatus implements _isc.SerializableModel {
  inquiry,
  option,
  confirmed,
  checkedIn,
  completed,
  cancelled;

  static BookingStatus fromJson(String name) {
    switch (name) {
      case 'inquiry':
        return BookingStatus.inquiry;
      case 'option':
        return BookingStatus.option;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'checkedIn':
        return BookingStatus.checkedIn;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.inquiry;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
