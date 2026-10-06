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

enum ValidationError implements _isc.SerializableModel {
  nameRequired,
  invalidDate,
  invalidDateRange,
  seasonOverlap,
  invalidAgeRange,
  ageGroupOverlap,
  invalidAmount,
  invalidTaxRate,
  invalidBedAmount,
  invalidGuestCount,
  duplicateRate,
  inUse,
  notFound,
  datesRequired,
  roomUnavailable,
  roomNotHeld,
  adminRequired,
  ownRole,
  alreadyInvoiced,
  nothingToInvoice,
  pricingIncomplete,
  notOverpaid,
  alreadyReceipted,
  operatorIncomplete;

  static ValidationError fromJson(String name) {
    switch (name) {
      case 'nameRequired':
        return ValidationError.nameRequired;
      case 'invalidDate':
        return ValidationError.invalidDate;
      case 'invalidDateRange':
        return ValidationError.invalidDateRange;
      case 'seasonOverlap':
        return ValidationError.seasonOverlap;
      case 'invalidAgeRange':
        return ValidationError.invalidAgeRange;
      case 'ageGroupOverlap':
        return ValidationError.ageGroupOverlap;
      case 'invalidAmount':
        return ValidationError.invalidAmount;
      case 'invalidTaxRate':
        return ValidationError.invalidTaxRate;
      case 'invalidBedAmount':
        return ValidationError.invalidBedAmount;
      case 'invalidGuestCount':
        return ValidationError.invalidGuestCount;
      case 'duplicateRate':
        return ValidationError.duplicateRate;
      case 'inUse':
        return ValidationError.inUse;
      case 'notFound':
        return ValidationError.notFound;
      case 'datesRequired':
        return ValidationError.datesRequired;
      case 'roomUnavailable':
        return ValidationError.roomUnavailable;
      case 'roomNotHeld':
        return ValidationError.roomNotHeld;
      case 'adminRequired':
        return ValidationError.adminRequired;
      case 'ownRole':
        return ValidationError.ownRole;
      case 'alreadyInvoiced':
        return ValidationError.alreadyInvoiced;
      case 'nothingToInvoice':
        return ValidationError.nothingToInvoice;
      case 'pricingIncomplete':
        return ValidationError.pricingIncomplete;
      case 'notOverpaid':
        return ValidationError.notOverpaid;
      case 'alreadyReceipted':
        return ValidationError.alreadyReceipted;
      case 'operatorIncomplete':
        return ValidationError.operatorIncomplete;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ValidationError"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
