import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'prices.dart';
import 'roles.dart';
import 'test_tools/serverpod_test_tools.dart';
import 'validation_matcher.dart';

void main() {
  withServerpod('Given users with different roles', (
    sessionBuilder,
    endpoints,
  ) {
    setUp(() async {
      await endpoints.unitType.add(
        sessionBuilder.asAdmin,
        UnitType(name: 'Standard'),
      );
    });

    test('when a viewer reads then the data is returned', () async {
      final categories = await endpoints.unitType.getAll(
        sessionBuilder.asViewer,
      );

      expect(categories, hasLength(1));
    });

    test('when a viewer changes data then it is rejected', () async {
      final viewer = sessionBuilder.asViewer;
      final category = UnitType(id: 1, name: 'Comfort');
      final rejected = throwsValidation(ValidationError.adminRequired);

      await expectLater(
        endpoints.unitType.add(viewer, category),
        rejected,
      );
      await expectLater(
        endpoints.unitType.update(viewer, category),
        rejected,
      );
      await expectLater(endpoints.unitType.delete(viewer, 1), rejected);
      await expectLater(
        endpoints.priceList.savePrices(viewer, 1, prices()),
        rejected,
      );
      await expectLater(endpoints.booking.setRooms(viewer, 1, []), rejected);
      await expectLater(
        endpoints.contact.add(viewer, Contact(firstName: 'A', lastName: 'B')),
        rejected,
      );
    });

    test('when a user without a role reads then it is rejected', () async {
      await expectLater(
        endpoints.unitType.getAll(sessionBuilder.withoutRole),
        throwsA(isA<ServerpodInsufficientAccessException>()),
      );
    });

    test('when nobody is signed in then reading is rejected', () async {
      await expectLater(
        endpoints.unitType.getAll(sessionBuilder),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test('when users ask who they are then they get their role', () async {
      final admin = await endpoints.user.me(sessionBuilder.asAdmin);
      final viewer = await endpoints.user.me(sessionBuilder.asViewer);
      final newUser = await endpoints.user.me(sessionBuilder.withoutRole);

      expect(admin.role, UserRole.admin);
      expect(viewer.role, UserRole.viewer);
      expect(newUser.role, isNull);
      expect(newUser.authUserId, UuidValue.fromString(newUserId));
    });

    test('when a viewer lists the users then it is rejected', () async {
      await expectLater(
        endpoints.user.getAll(sessionBuilder.asViewer),
        throwsValidation(ValidationError.adminRequired),
      );
    });
  });

  withServerpod('Given a user who signed up', (sessionBuilder, endpoints) {
    final session = sessionBuilder.build();
    late AuthUser user;

    setUp(() async {
      user = await AuthUser.db.insertRow(
        session,
        AuthUser(scopeNames: {'other'}),
      );
    });

    test('when an admin lists the users then the user has no role', () async {
      final users = await endpoints.user.getAll(sessionBuilder.asAdmin);

      expect(users.single.authUserId, user.id);
      expect(users.single.role, isNull);
    });

    test('when an admin gives and takes a role '
        'then only the role scopes change', () async {
      final admin = sessionBuilder.asAdmin;

      var updated = await endpoints.user.setRole(
        admin,
        user.id!,
        UserRole.admin,
      );
      expect(updated.role, UserRole.admin);

      updated = await endpoints.user.setRole(admin, user.id!, UserRole.viewer);
      expect(updated.role, UserRole.viewer);
      var stored = await AuthUser.db.findById(session, user.id!);
      expect(stored!.scopeNames, {'other', viewerScope.name});

      updated = await endpoints.user.setRole(admin, user.id!, null);
      expect(updated.role, isNull);
      stored = await AuthUser.db.findById(session, user.id!);
      expect(stored!.scopeNames, {'other'});
    });

    test('when admins change their own role then it is rejected', () async {
      await expectLater(
        endpoints.user.setRole(
          sessionBuilder.asAdmin,
          UuidValue.fromString(adminId),
          UserRole.viewer,
        ),
        throwsValidation(ValidationError.ownRole),
      );
    });

    test('when a viewer gives a role then it is rejected', () async {
      await expectLater(
        endpoints.user.setRole(
          sessionBuilder.asViewer,
          user.id!,
          UserRole.admin,
        ),
        throwsValidation(ValidationError.adminRequired),
      );
    });

    test('when another user signs up then that user gets no role', () async {
      final created = await session.db.transaction(
        (transaction) =>
            grantFirstUserAdmin(session, {}, false, transaction: transaction),
      );

      expect(created.scopes, isEmpty);
    });

    group('when a call arrives with a token from before a role change', () {
      Future<AuthenticationInfo?> staleAdminToken(Session _, String _) async =>
          AuthenticationInfo(user.id!.uuid, {Scope.admin}, authId: 'token');

      test('then the scopes stored for the user apply', () async {
        final info = await withCurrentScopes(staleAdminToken)(session, '');

        expect(info!.scopes, {const Scope('other')});
      });

      test('then a blocked user is not signed in', () async {
        await AuthUser.db.updateRow(session, user.copyWith(blocked: true));

        final info = await withCurrentScopes(staleAdminToken)(session, '');

        expect(info, isNull);
      });
    });
  });

  withServerpod('Given no users', (sessionBuilder, endpoints) {
    final session = sessionBuilder.build();

    test('when the first user signs up then that user is an admin', () async {
      final created = await session.db.transaction(
        (transaction) =>
            grantFirstUserAdmin(session, {}, false, transaction: transaction),
      );

      expect(created.scopes, {Scope.admin, viewerScope});
      expect(created.blocked, isFalse);
    });
  });
}
