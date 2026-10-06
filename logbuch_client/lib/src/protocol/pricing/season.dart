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

abstract class Season
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Season._({
    this.id,
    required this.name,
    required this.validFrom,
    required this.validTo,
  });

  factory Season({
    int? id,
    required String name,
    required DateTime validFrom,
    required DateTime validTo,
  }) = _SeasonImpl;

  factory Season.fromJson(Map<String, dynamic> jsonSerialization) {
    return Season(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      validFrom: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['validFrom'],
      ),
      validTo: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['validTo'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  DateTime validFrom;

  DateTime validTo;

  /// Returns a shallow copy of this [Season]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Season copyWith({
    int? id,
    String? name,
    DateTime? validFrom,
    DateTime? validTo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Season',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
      'validTo': validTo.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Season',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
      'validTo': validTo.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonImpl extends Season {
  _SeasonImpl({
    int? id,
    required String name,
    required DateTime validFrom,
    required DateTime validTo,
  }) : super._(
         id: id,
         name: name,
         validFrom: validFrom,
         validTo: validTo,
       );

  /// Returns a shallow copy of this [Season]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Season copyWith({
    Object? id = _Undefined,
    String? name,
    DateTime? validFrom,
    DateTime? validTo,
  }) {
    return Season(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
    );
  }
}
