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
import '../common/validation_error.dart' as _imgdhari;

abstract class ValidationException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  ValidationException._({
    required this.reason,
    this.detail,
  });

  factory ValidationException({
    required _imgdhari.ValidationError reason,
    String? detail,
  }) = _ValidationExceptionImpl;

  factory ValidationException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ValidationException(
      reason: _imgdhari.ValidationError.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      detail: jsonSerialization['detail'] as String?,
    );
  }

  _imgdhari.ValidationError reason;

  String? detail;

  /// Returns a shallow copy of this [ValidationException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ValidationException copyWith({
    _imgdhari.ValidationError? reason,
    String? detail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ValidationException',
      'reason': reason.toJson(),
      if (detail != null) 'detail': detail,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ValidationException',
      'reason': reason.toJson(),
      if (detail != null) 'detail': detail,
    };
  }

  @override
  String toString() {
    return 'ValidationException(reason: $reason, detail: $detail)';
  }
}

class _Undefined {}

class _ValidationExceptionImpl extends ValidationException {
  _ValidationExceptionImpl({
    required _imgdhari.ValidationError reason,
    String? detail,
  }) : super._(
         reason: reason,
         detail: detail,
       );

  /// Returns a shallow copy of this [ValidationException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ValidationException copyWith({
    _imgdhari.ValidationError? reason,
    Object? detail = _Undefined,
  }) {
    return ValidationException(
      reason: reason ?? this.reason,
      detail: detail is String? ? detail : this.detail,
    );
  }
}
