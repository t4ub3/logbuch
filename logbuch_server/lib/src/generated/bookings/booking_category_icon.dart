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

enum BookingCategoryIcon implements _is.SerializableModel {
  calendar,
  users,
  family,
  education,
  book,
  presentation,
  music,
  sport,
  tree,
  compass,
  sun,
  heart,
  star,
  home,
  puzzle,
  flag;

  static BookingCategoryIcon fromJson(String name) {
    switch (name) {
      case 'calendar':
        return BookingCategoryIcon.calendar;
      case 'users':
        return BookingCategoryIcon.users;
      case 'family':
        return BookingCategoryIcon.family;
      case 'education':
        return BookingCategoryIcon.education;
      case 'book':
        return BookingCategoryIcon.book;
      case 'presentation':
        return BookingCategoryIcon.presentation;
      case 'music':
        return BookingCategoryIcon.music;
      case 'sport':
        return BookingCategoryIcon.sport;
      case 'tree':
        return BookingCategoryIcon.tree;
      case 'compass':
        return BookingCategoryIcon.compass;
      case 'sun':
        return BookingCategoryIcon.sun;
      case 'heart':
        return BookingCategoryIcon.heart;
      case 'star':
        return BookingCategoryIcon.star;
      case 'home':
        return BookingCategoryIcon.home;
      case 'puzzle':
        return BookingCategoryIcon.puzzle;
      case 'flag':
        return BookingCategoryIcon.flag;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "BookingCategoryIcon"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
