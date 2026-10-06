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

abstract class Organization
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Organization._({
    this.id,
    required this.name,
    this.street,
    this.zip,
    this.city,
    this.country,
  });

  factory Organization({
    int? id,
    required String name,
    String? street,
    String? zip,
    String? city,
    String? country,
  }) = _OrganizationImpl;

  factory Organization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Organization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      street: jsonSerialization['street'] as String?,
      zip: jsonSerialization['zip'] as String?,
      city: jsonSerialization['city'] as String?,
      country: jsonSerialization['country'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? street;

  String? zip;

  String? city;

  String? country;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Organization copyWith({
    int? id,
    String? name,
    String? street,
    String? zip,
    String? city,
    String? country,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Organization',
      if (id != null) 'id': id,
      'name': name,
      if (street != null) 'street': street,
      if (zip != null) 'zip': zip,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Organization',
      if (id != null) 'id': id,
      'name': name,
      if (street != null) 'street': street,
      if (zip != null) 'zip': zip,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationImpl extends Organization {
  _OrganizationImpl({
    int? id,
    required String name,
    String? street,
    String? zip,
    String? city,
    String? country,
  }) : super._(
         id: id,
         name: name,
         street: street,
         zip: zip,
         city: city,
         country: country,
       );

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Organization copyWith({
    Object? id = _Undefined,
    String? name,
    Object? street = _Undefined,
    Object? zip = _Undefined,
    Object? city = _Undefined,
    Object? country = _Undefined,
  }) {
    return Organization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      street: street is String? ? street : this.street,
      zip: zip is String? ? zip : this.zip,
      city: city is String? ? city : this.city,
      country: country is String? ? country : this.country,
    );
  }
}
