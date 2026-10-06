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

/// What a guest of a booking cannot or does not eat.
abstract class DietaryNeed
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DietaryNeed._({
    required this.guestName,
    required this.groupName,
    this.ageGroupName,
    required this.notes,
  });

  factory DietaryNeed({
    required String guestName,
    required String groupName,
    String? ageGroupName,
    required String notes,
  }) = _DietaryNeedImpl;

  factory DietaryNeed.fromJson(Map<String, dynamic> jsonSerialization) {
    return DietaryNeed(
      guestName: jsonSerialization['guestName'] as String,
      groupName: jsonSerialization['groupName'] as String,
      ageGroupName: jsonSerialization['ageGroupName'] as String?,
      notes: jsonSerialization['notes'] as String,
    );
  }

  String guestName;

  String groupName;

  /// Null if the age of the guest is not known.
  String? ageGroupName;

  String notes;

  /// Returns a shallow copy of this [DietaryNeed]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DietaryNeed copyWith({
    String? guestName,
    String? groupName,
    String? ageGroupName,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DietaryNeed',
      'guestName': guestName,
      'groupName': groupName,
      if (ageGroupName != null) 'ageGroupName': ageGroupName,
      'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DietaryNeed',
      'guestName': guestName,
      'groupName': groupName,
      if (ageGroupName != null) 'ageGroupName': ageGroupName,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DietaryNeedImpl extends DietaryNeed {
  _DietaryNeedImpl({
    required String guestName,
    required String groupName,
    String? ageGroupName,
    required String notes,
  }) : super._(
         guestName: guestName,
         groupName: groupName,
         ageGroupName: ageGroupName,
         notes: notes,
       );

  /// Returns a shallow copy of this [DietaryNeed]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DietaryNeed copyWith({
    String? guestName,
    String? groupName,
    Object? ageGroupName = _Undefined,
    String? notes,
  }) {
    return DietaryNeed(
      guestName: guestName ?? this.guestName,
      groupName: groupName ?? this.groupName,
      ageGroupName: ageGroupName is String? ? ageGroupName : this.ageGroupName,
      notes: notes ?? this.notes,
    );
  }
}
