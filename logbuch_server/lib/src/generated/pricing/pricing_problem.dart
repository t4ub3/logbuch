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
import 'package:serverpod/serverpod.dart' as _is;
import '../pricing/pricing_problem_reason.dart' as _igu9rfdc;

/// Something that keeps a part of a booking from being priced.
abstract class PricingProblem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PricingProblem._({
    required this.reason,
    this.guestId,
    this.detail,
  });

  factory PricingProblem({
    required _igu9rfdc.PricingProblemReason reason,
    int? guestId,
    String? detail,
  }) = _PricingProblemImpl;

  factory PricingProblem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PricingProblem(
      reason: _igu9rfdc.PricingProblemReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      guestId: jsonSerialization['guestId'] as int?,
      detail: jsonSerialization['detail'] as String?,
    );
  }

  _igu9rfdc.PricingProblemReason reason;

  int? guestId;

  /// What is missing: a night, or the names a rate is missing for.
  String? detail;

  /// Returns a shallow copy of this [PricingProblem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PricingProblem copyWith({
    _igu9rfdc.PricingProblemReason? reason,
    int? guestId,
    String? detail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PricingProblem',
      'reason': reason.toJson(),
      if (guestId != null) 'guestId': guestId,
      if (detail != null) 'detail': detail,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PricingProblem',
      'reason': reason.toJson(),
      if (guestId != null) 'guestId': guestId,
      if (detail != null) 'detail': detail,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PricingProblemImpl extends PricingProblem {
  _PricingProblemImpl({
    required _igu9rfdc.PricingProblemReason reason,
    int? guestId,
    String? detail,
  }) : super._(
         reason: reason,
         guestId: guestId,
         detail: detail,
       );

  /// Returns a shallow copy of this [PricingProblem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PricingProblem copyWith({
    _igu9rfdc.PricingProblemReason? reason,
    Object? guestId = _Undefined,
    Object? detail = _Undefined,
  }) {
    return PricingProblem(
      reason: reason ?? this.reason,
      guestId: guestId is int? ? guestId : this.guestId,
      detail: detail is String? ? detail : this.detail,
    );
  }
}
