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
import '../bookings/booking_category_color.dart' as _iei1rmwk;
import '../bookings/booking_category_icon.dart' as _igtfv0zf;

abstract class BookingCategory
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BookingCategory._({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory BookingCategory({
    int? id,
    required String name,
    required _igtfv0zf.BookingCategoryIcon icon,
    required _iei1rmwk.BookingCategoryColor color,
  }) = _BookingCategoryImpl;

  factory BookingCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      icon: _igtfv0zf.BookingCategoryIcon.fromJson(
        (jsonSerialization['icon'] as String),
      ),
      color: _iei1rmwk.BookingCategoryColor.fromJson(
        (jsonSerialization['color'] as String),
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  _igtfv0zf.BookingCategoryIcon icon;

  _iei1rmwk.BookingCategoryColor color;

  /// Returns a shallow copy of this [BookingCategory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BookingCategory copyWith({
    int? id,
    String? name,
    _igtfv0zf.BookingCategoryIcon? icon,
    _iei1rmwk.BookingCategoryColor? color,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingCategory',
      if (id != null) 'id': id,
      'name': name,
      'icon': icon.toJson(),
      'color': color.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingCategory',
      if (id != null) 'id': id,
      'name': name,
      'icon': icon.toJson(),
      'color': color.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingCategoryImpl extends BookingCategory {
  _BookingCategoryImpl({
    int? id,
    required String name,
    required _igtfv0zf.BookingCategoryIcon icon,
    required _iei1rmwk.BookingCategoryColor color,
  }) : super._(
         id: id,
         name: name,
         icon: icon,
         color: color,
       );

  /// Returns a shallow copy of this [BookingCategory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BookingCategory copyWith({
    Object? id = _Undefined,
    String? name,
    _igtfv0zf.BookingCategoryIcon? icon,
    _iei1rmwk.BookingCategoryColor? color,
  }) {
    return BookingCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}
