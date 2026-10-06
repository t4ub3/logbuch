import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// The users of the app and their roles. Unlike the other endpoints it can
/// be called without a role, so that new users can see that they have none.
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The signed-in user.
  Future<AppUser> me(Session session) async {
    final info = session.authenticated!;
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(info.authUserId),
    );
    return AppUser(
      authUserId: info.authUserId,
      email: profile?.email,
      role: roleOf({for (final scope in info.scopes) scope.name}),
    );
  }

  Future<List<AppUser>> getAll(Session session) async {
    requireAdmin(session);
    final users = await AuthUser.db.find(session, orderBy: (t) => t.createdAt);
    final profiles = await UserProfile.db.find(session);
    final emails = {for (final p in profiles) p.authUserId: p.email};
    return [
      for (final user in users)
        AppUser(
          authUserId: user.id!,
          email: emails[user.id],
          role: roleOf(user.scopeNames),
        ),
    ];
  }

  /// Gives the user a [role], or takes it away with null. Admins cannot
  /// change their own role, so there is always one left.
  Future<AppUser> setRole(
    Session session,
    UuidValue authUserId,
    UserRole? role,
  ) async {
    requireAdmin(session);
    if (authUserId == session.authenticated!.authUserId) {
      throw ValidationException(reason: ValidationError.ownRole);
    }
    final user = await AuthUser.db.findById(session, authUserId);
    if (user == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    // Scopes that are not roles are kept.
    final roleScopes = {...scopesOf(UserRole.admin).map((s) => s.name)};
    final updated = await AuthUser.db.updateRow(
      session,
      user.copyWith(
        scopeNames: {
          ...user.scopeNames.where((name) => !roleScopes.contains(name)),
          ...scopesOf(role).map((s) => s.name).nonNulls,
        },
      ),
    );
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return AppUser(
      authUserId: authUserId,
      email: profile?.email,
      role: roleOf(updated.scopeNames),
    );
  }
}
