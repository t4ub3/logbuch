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

/// A kind of room or house that is priced the same way, such as a room in
/// the main house or a bungalow. Its prices are in the price lists.
abstract class UnitType
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UnitType._({
    this.id,
    required this.name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) : sortOrder = sortOrder ?? 0,
       taxRate = taxRate ?? 700,
       shared = shared ?? false;

  factory UnitType({
    int? id,
    required String name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) = _UnitTypeImpl;

  factory UnitType.fromJson(Map<String, dynamic> jsonSerialization) {
    return UnitType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      taxRate: jsonSerialization['taxRate'] as int?,
      shared: jsonSerialization['shared'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['shared']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int sortOrder;

  /// What staying in a unit of this type is taxed with, in basis points.
  int taxRate;

  /// Several bookings may hold a unit of this type during the same night.
  /// They share what it costs per night.
  bool shared;

  /// Returns a shallow copy of this [UnitType]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UnitType copyWith({
    int? id,
    String? name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UnitType',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
      'taxRate': taxRate,
      'shared': shared,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UnitType',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
      'taxRate': taxRate,
      'shared': shared,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UnitTypeImpl extends UnitType {
  _UnitTypeImpl({
    int? id,
    required String name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) : super._(
         id: id,
         name: name,
         sortOrder: sortOrder,
         taxRate: taxRate,
         shared: shared,
       );

  /// Returns a shallow copy of this [UnitType]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UnitType copyWith({
    Object? id = _Undefined,
    String? name,
    int? sortOrder,
    int? taxRate,
    bool? shared,
  }) {
    return UnitType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      taxRate: taxRate ?? this.taxRate,
      shared: shared ?? this.shared,
    );
  }
}
