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
import '../auth/user_role.dart' as _ip8qv1h2;

/// A user account with its role in the app. Without a role the user is
/// signed in but cannot see anything yet.
abstract class AppUser
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AppUser._({
    required this.authUserId,
    this.email,
    this.role,
  });

  factory AppUser({
    required _is.UuidValue authUserId,
    String? email,
    _ip8qv1h2.UserRole? role,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      email: jsonSerialization['email'] as String?,
      role: jsonSerialization['role'] == null
          ? null
          : _ip8qv1h2.UserRole.fromJson((jsonSerialization['role'] as String)),
    );
  }

  _is.UuidValue authUserId;

  String? email;

  _ip8qv1h2.UserRole? role;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppUser copyWith({
    _is.UuidValue? authUserId,
    String? email,
    _ip8qv1h2.UserRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      'authUserId': authUserId.toJson(),
      if (email != null) 'email': email,
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      'authUserId': authUserId.toJson(),
      if (email != null) 'email': email,
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    required _is.UuidValue authUserId,
    String? email,
    _ip8qv1h2.UserRole? role,
  }) : super._(
         authUserId: authUserId,
         email: email,
         role: role,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppUser copyWith({
    _is.UuidValue? authUserId,
    Object? email = _Undefined,
    Object? role = _Undefined,
  }) {
    return AppUser(
      authUserId: authUserId ?? this.authUserId,
      email: email is String? ? email : this.email,
      role: role is _ip8qv1h2.UserRole? ? role : this.role,
    );
  }
}
