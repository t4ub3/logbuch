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

/// A house, or a group of houses, that rooms are in.
abstract class Building
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Building._({
    this.id,
    required this.name,
    int? sortOrder,
  }) : sortOrder = sortOrder ?? 0;

  factory Building({
    int? id,
    required String name,
    int? sortOrder,
  }) = _BuildingImpl;

  factory Building.fromJson(Map<String, dynamic> jsonSerialization) {
    return Building(
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

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Building copyWith({
    int? id,
    String? name,
    int? sortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Building',
      if (id != null) 'id': id,
      'name': name,
      'sortOrder': sortOrder,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Building',
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

class _BuildingImpl extends Building {
  _BuildingImpl({
    int? id,
    required String name,
    int? sortOrder,
  }) : super._(
         id: id,
         name: name,
         sortOrder: sortOrder,
       );

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Building copyWith({
    Object? id = _Undefined,
    String? name,
    int? sortOrder,
  }) {
    return Building(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
