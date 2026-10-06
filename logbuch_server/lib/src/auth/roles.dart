import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// Lets a user read everything. Admins have it next to [Scope.admin], which
/// lets them change data as well.
const viewerScope = Scope('viewer');

/// The scopes that make up a [role]; without a role a user has none.
Set<Scope> scopesOf(UserRole? role) => switch (role) {
  UserRole.admin => {Scope.admin, viewerScope},
  UserRole.viewer => {viewerScope},
  null => {},
};

UserRole? roleOf(Set<String?> scopeNames) {
  if (scopeNames.contains(Scope.admin.name)) return UserRole.admin;
  if (scopeNames.contains(viewerScope.name)) return UserRole.viewer;
  return null;
}

/// An endpoint of the app. All of its calls need a signed-in user with a
/// role. Methods that change data call [requireAdmin] first.
abstract class AppEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {viewerScope};
}

/// Rejects the call unless the signed-in user is an admin.
void requireAdmin(Session session) {
  final scopes = session.authenticated?.scopes ?? {};
  if (!scopes.contains(Scope.admin)) {
    throw ValidationException(reason: ValidationError.adminRequired);
  }
}

/// Makes the very first user an admin, so that somebody can give roles to
/// the users who sign up later. Those start without a role.
Future<({Set<Scope> scopes, bool blocked})> grantFirstUserAdmin(
  Session session,
  Set<Scope> scopes,
  bool blocked, {
  required Transaction transaction,
}) async {
  final users = await AuthUser.db.count(session, transaction: transaction);
  return (
    scopes: users == 0 ? {...scopes, ...scopesOf(UserRole.admin)} : scopes,
    blocked: blocked,
  );
}

/// Wraps [handler] so that a signed-in user always has the scopes that are
/// stored for them now. The tokens checked by [handler] carry the scopes
/// from the time of the sign-in, which would let a changed or withdrawn
/// role go unnoticed until the user signs in again.
AuthenticationHandler withCurrentScopes(AuthenticationHandler handler) {
  return (session, token) async {
    final info = await handler(session, token);
    if (info == null) return null;
    final user = await AuthUser.db.findById(session, info.authUserId);
    if (user == null || user.blocked) return null;
    return AuthenticationInfo(
      info.userIdentifier,
      {for (final name in user.scopeNames) Scope(name)},
      authId: info.authId,
    );
  };
}
