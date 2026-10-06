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

abstract class PriceCategory
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PriceCategory._({
    this.id,
    required this.name,
    int? sortOrder,
  }) : sortOrder = sortOrder ?? 0;

  factory PriceCategory({
    int? id,
    required String name,
    int? sortOrder,
  }) = _PriceCategoryImpl;

  factory PriceCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return PriceCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int sortOrder;

  /// Returns a shallow copy of this [PriceCategory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PriceCategory copyWith({
    int? id,
    String? name,
    int? sortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PriceCategory',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PriceCategory',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PriceCategoryImpl extends PriceCategory {
  _PriceCategoryImpl({
    int? id,
    required String name,
    int? sortOrder,
  }) : super._(
         id: id,
         name: name,
         sortOrder: sortOrder,
       );

  /// Returns a shallow copy of this [PriceCategory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PriceCategory copyWith({
    Object? id = _Undefined,
    String? name,
    int? sortOrder,
  }) {
    return PriceCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
