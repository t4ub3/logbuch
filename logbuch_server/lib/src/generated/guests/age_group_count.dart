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
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../pricing/age_group.dart' as _iwfwnbly;

/// How many guests of a booking are in an age group.
abstract class AgeGroupCount
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AgeGroupCount._({
    required this.ageGroup,
    required this.count,
  });

  factory AgeGroupCount({
    required _iwfwnbly.AgeGroup ageGroup,
    required int count,
  }) = _AgeGroupCountImpl;

  factory AgeGroupCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgeGroupCount(
      ageGroup: _iil9w69f.Protocol().deserialize<_iwfwnbly.AgeGroup>(
        jsonSerialization['ageGroup'],
      ),
      count: jsonSerialization['count'] as int,
    );
  }

  _iwfwnbly.AgeGroup ageGroup;

  int count;

  /// Returns a shallow copy of this [AgeGroupCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AgeGroupCount copyWith({
    _iwfwnbly.AgeGroup? ageGroup,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgeGroupCount',
      'ageGroup': ageGroup.toJson(),
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgeGroupCount',
      'ageGroup': ageGroup.toJsonForProtocol(),
      'count': count,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AgeGroupCountImpl extends AgeGroupCount {
  _AgeGroupCountImpl({
    required _iwfwnbly.AgeGroup ageGroup,
    required int count,
  }) : super._(
         ageGroup: ageGroup,
         count: count,
       );

  /// Returns a shallow copy of this [AgeGroupCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AgeGroupCount copyWith({
    _iwfwnbly.AgeGroup? ageGroup,
    int? count,
  }) {
    return AgeGroupCount(
      ageGroup: ageGroup ?? this.ageGroup.copyWith(),
      count: count ?? this.count,
    );
  }
}
