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

abstract class AgeGroup
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgeGroup._({
    this.id,
    required this.name,
    required this.minAge,
    this.maxAge,
  });

  factory AgeGroup({
    int? id,
    required String name,
    required int minAge,
    int? maxAge,
  }) = _AgeGroupImpl;

  factory AgeGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgeGroup(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      minAge: jsonSerialization['minAge'] as int,
      maxAge: jsonSerialization['maxAge'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int minAge;

  int? maxAge;

  /// Returns a shallow copy of this [AgeGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgeGroup copyWith({
    int? id,
    String? name,
    int? minAge,
    int? maxAge,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgeGroup',
      if (id != null) 'id': id,
      'name': name,
      'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgeGroup',
      if (id != null) 'id': id,
      'name': name,
      'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgeGroupImpl extends AgeGroup {
  _AgeGroupImpl({
    int? id,
    required String name,
    required int minAge,
    int? maxAge,
  }) : super._(
         id: id,
         name: name,
         minAge: minAge,
         maxAge: maxAge,
       );

  /// Returns a shallow copy of this [AgeGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgeGroup copyWith({
    Object? id = _Undefined,
    String? name,
    int? minAge,
    Object? maxAge = _Undefined,
  }) {
    return AgeGroup(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge is int? ? maxAge : this.maxAge,
    );
  }
}
