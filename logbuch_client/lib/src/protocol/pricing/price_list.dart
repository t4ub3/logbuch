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

/// The prices from a day on, until the next price list begins. A night is
/// priced by the list that is in force on the day it starts.
abstract class PriceList
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PriceList._({
    this.id,
    required this.name,
    required this.validFrom,
  });

  factory PriceList({
    int? id,
    required String name,
    required DateTime validFrom,
  }) = _PriceListImpl;

  factory PriceList.fromJson(Map<String, dynamic> jsonSerialization) {
    return PriceList(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      validFrom: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['validFrom'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  DateTime validFrom;

  /// Returns a shallow copy of this [PriceList]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PriceList copyWith({
    int? id,
    String? name,
    DateTime? validFrom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PriceList',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PriceList',
      if (id != null) 'id': id,
      'name': name,
      'validFrom': validFrom.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PriceListImpl extends PriceList {
  _PriceListImpl({
    int? id,
    required String name,
    required DateTime validFrom,
  }) : super._(
         id: id,
         name: name,
         validFrom: validFrom,
       );

  /// Returns a shallow copy of this [PriceList]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PriceList copyWith({
    Object? id = _Undefined,
    String? name,
    DateTime? validFrom,
  }) {
    return PriceList(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      validFrom: validFrom ?? this.validFrom,
    );
  }
}
