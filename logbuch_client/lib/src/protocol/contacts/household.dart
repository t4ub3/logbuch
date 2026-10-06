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
import '../contacts/household_member.dart' as _iju6dw84;

/// Contacts who usually travel together, such as a family. A household can
/// be added to a booking as a guest group in one step.
abstract class Household
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Household._({
    this.id,
    required this.name,
    this.members,
  });

  factory Household({
    int? id,
    required String name,
    List<_iju6dw84.HouseholdMember>? members,
  }) = _HouseholdImpl;

  factory Household.fromJson(Map<String, dynamic> jsonSerialization) {
    return Household(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      members: jsonSerialization['members'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_iju6dw84.HouseholdMember>>(
              jsonSerialization['members'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  List<_iju6dw84.HouseholdMember>? members;

  /// Returns a shallow copy of this [Household]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Household copyWith({
    int? id,
    String? name,
    List<_iju6dw84.HouseholdMember>? members,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Household',
      if (id != null) 'id': id,
      'name': name,
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Household',
      if (id != null) 'id': id,
      'name': name,
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HouseholdImpl extends Household {
  _HouseholdImpl({
    int? id,
    required String name,
    List<_iju6dw84.HouseholdMember>? members,
  }) : super._(
         id: id,
         name: name,
         members: members,
       );

  /// Returns a shallow copy of this [Household]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Household copyWith({
    Object? id = _Undefined,
    String? name,
    Object? members = _Undefined,
  }) {
    return Household(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      members: members is List<_iju6dw84.HouseholdMember>?
          ? members
          : this.members?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
