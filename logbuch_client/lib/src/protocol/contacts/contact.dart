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
import 'package:logbuch_client/src/protocol/protocol.dart' as _i7rf0d0e;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../contacts/organization.dart' as _i0w1hmpk;

abstract class Contact
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Contact._({
    this.id,
    DateTime? createdAt,
    required this.firstName,
    required this.lastName,
    this.mail,
    this.phone,
    this.birthDate,
    this.street,
    this.zip,
    this.city,
    this.country,
    this.organizationId,
    this.organization,
    this.notes,
    this.privacyConsentAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Contact({
    int? id,
    DateTime? createdAt,
    required String firstName,
    required String lastName,
    String? mail,
    String? phone,
    DateTime? birthDate,
    String? street,
    String? zip,
    String? city,
    String? country,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    String? notes,
    DateTime? privacyConsentAt,
  }) = _ContactImpl;

  factory Contact.fromJson(Map<String, dynamic> jsonSerialization) {
    return Contact(
      id: jsonSerialization['id'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      mail: jsonSerialization['mail'] as String?,
      phone: jsonSerialization['phone'] as String?,
      birthDate: jsonSerialization['birthDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['birthDate']),
      street: jsonSerialization['street'] as String?,
      zip: jsonSerialization['zip'] as String?,
      city: jsonSerialization['city'] as String?,
      country: jsonSerialization['country'] as String?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i0w1hmpk.Organization>(
              jsonSerialization['organization'],
            ),
      notes: jsonSerialization['notes'] as String?,
      privacyConsentAt: jsonSerialization['privacyConsentAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['privacyConsentAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime createdAt;

  String firstName;

  String lastName;

  String? mail;

  String? phone;

  DateTime? birthDate;

  String? street;

  String? zip;

  String? city;

  String? country;

  int? organizationId;

  _i0w1hmpk.Organization? organization;

  String? notes;

  DateTime? privacyConsentAt;

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Contact copyWith({
    int? id,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    String? mail,
    String? phone,
    DateTime? birthDate,
    String? street,
    String? zip,
    String? city,
    String? country,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    String? notes,
    DateTime? privacyConsentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Contact',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      if (mail != null) 'mail': mail,
      if (phone != null) 'phone': phone,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (street != null) 'street': street,
      if (zip != null) 'zip': zip,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (notes != null) 'notes': notes,
      if (privacyConsentAt != null)
        'privacyConsentAt': privacyConsentAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Contact',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      if (mail != null) 'mail': mail,
      if (phone != null) 'phone': phone,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (street != null) 'street': street,
      if (zip != null) 'zip': zip,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
      if (privacyConsentAt != null)
        'privacyConsentAt': privacyConsentAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactImpl extends Contact {
  _ContactImpl({
    int? id,
    DateTime? createdAt,
    required String firstName,
    required String lastName,
    String? mail,
    String? phone,
    DateTime? birthDate,
    String? street,
    String? zip,
    String? city,
    String? country,
    int? organizationId,
    _i0w1hmpk.Organization? organization,
    String? notes,
    DateTime? privacyConsentAt,
  }) : super._(
         id: id,
         createdAt: createdAt,
         firstName: firstName,
         lastName: lastName,
         mail: mail,
         phone: phone,
         birthDate: birthDate,
         street: street,
         zip: zip,
         city: city,
         country: country,
         organizationId: organizationId,
         organization: organization,
         notes: notes,
         privacyConsentAt: privacyConsentAt,
       );

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Contact copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    Object? mail = _Undefined,
    Object? phone = _Undefined,
    Object? birthDate = _Undefined,
    Object? street = _Undefined,
    Object? zip = _Undefined,
    Object? city = _Undefined,
    Object? country = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    Object? notes = _Undefined,
    Object? privacyConsentAt = _Undefined,
  }) {
    return Contact(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mail: mail is String? ? mail : this.mail,
      phone: phone is String? ? phone : this.phone,
      birthDate: birthDate is DateTime? ? birthDate : this.birthDate,
      street: street is String? ? street : this.street,
      zip: zip is String? ? zip : this.zip,
      city: city is String? ? city : this.city,
      country: country is String? ? country : this.country,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i0w1hmpk.Organization?
          ? organization
          : this.organization?.copyWith(),
      notes: notes is String? ? notes : this.notes,
      privacyConsentAt: privacyConsentAt is DateTime?
          ? privacyConsentAt
          : this.privacyConsentAt,
    );
  }
}
