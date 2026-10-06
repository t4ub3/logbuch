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
import '../contacts/contact.dart' as _imbxrfja;
import '../contacts/household.dart' as _iv1t9w35;

/// A contact in a household. A contact can be in several households.
abstract class HouseholdMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  HouseholdMember._({
    this.id,
    required this.householdId,
    this.household,
    required this.contactId,
    this.contact,
  });

  factory HouseholdMember({
    int? id,
    required int householdId,
    _iv1t9w35.Household? household,
    required int contactId,
    _imbxrfja.Contact? contact,
  }) = _HouseholdMemberImpl;

  factory HouseholdMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return HouseholdMember(
      id: jsonSerialization['id'] as int?,
      householdId: jsonSerialization['householdId'] as int,
      household: jsonSerialization['household'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_iv1t9w35.Household>(
              jsonSerialization['household'],
            ),
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int householdId;

  _iv1t9w35.Household? household;

  int contactId;

  _imbxrfja.Contact? contact;

  /// Returns a shallow copy of this [HouseholdMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  HouseholdMember copyWith({
    int? id,
    int? householdId,
    _iv1t9w35.Household? household,
    int? contactId,
    _imbxrfja.Contact? contact,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HouseholdMember',
      if (id != null) 'id': id,
      'householdId': householdId,
      if (household != null) 'household': household?.toJson(),
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HouseholdMember',
      if (id != null) 'id': id,
      'householdId': householdId,
      if (household != null) 'household': household?.toJsonForProtocol(),
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HouseholdMemberImpl extends HouseholdMember {
  _HouseholdMemberImpl({
    int? id,
    required int householdId,
    _iv1t9w35.Household? household,
    required int contactId,
    _imbxrfja.Contact? contact,
  }) : super._(
         id: id,
         householdId: householdId,
         household: household,
         contactId: contactId,
         contact: contact,
       );

  /// Returns a shallow copy of this [HouseholdMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  HouseholdMember copyWith({
    Object? id = _Undefined,
    int? householdId,
    Object? household = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
  }) {
    return HouseholdMember(
      id: id is int? ? id : this.id,
      householdId: householdId ?? this.householdId,
      household: household is _iv1t9w35.Household?
          ? household
          : this.household?.copyWith(),
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
    );
  }
}
