import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'test_tools/serverpod_test_tools.dart';

const adminId = '550e8400-e29b-41d4-a716-446655440001';
const viewerId = '550e8400-e29b-41d4-a716-446655440002';
const newUserId = '550e8400-e29b-41d4-a716-446655440003';

extension Roles on TestSessionBuilder {
  TestSessionBuilder get asAdmin => _as(adminId, scopesOf(UserRole.admin));

  TestSessionBuilder get asViewer => _as(viewerId, scopesOf(UserRole.viewer));

  /// Signed in, but not given a role yet.
  TestSessionBuilder get withoutRole => _as(newUserId, {});

  TestSessionBuilder _as(String userId, Set<Scope> scopes) => copyWith(
    authentication: AuthenticationOverride.authenticationInfo(userId, scopes),
  );
}

/// Like [withServerpod], but the session builder is signed in as an admin.
void withAdmin(
  String testGroupName,
  TestClosure<TestEndpoints> testClosure, {
  RollbackDatabase? rollbackDatabase,
}) {
  withServerpod(
    testGroupName,
    (sessionBuilder, endpoints) =>
        testClosure(sessionBuilder.asAdmin, endpoints),
    rollbackDatabase: rollbackDatabase,
  );
}
