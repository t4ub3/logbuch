import 'package:logbuch_server/src/auth/auth_setup.dart';
import 'package:logbuch_server/src/demo/demo_seed.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the demo seeded into an empty database', (
    sessionBuilder,
    endpoints,
  ) {
    final now = DateTime.now();

    Future<void> seed() => seedDemo(
      sessionBuilder.build(),
      today: DateTime.utc(now.year, now.month, now.day),
      log: (_) {},
    );

    setUpAll(() async {
      setUpAuthServices();
      await seed();
    });

    test('then the demo admin signs in with the short password', () async {
      final signedIn = await endpoints.emailIdp.login(
        sessionBuilder,
        email: demoAdminEmail,
        password: demoAdminPassword,
      );

      final users = await endpoints.user.getAll(sessionBuilder.asAdmin);
      final admin = users.single;
      expect(admin.authUserId, signedIn.authUserId);
      expect(admin.email, demoAdminEmail);
      expect(admin.role, UserRole.admin);
    });

    test('then the bookings were made', () async {
      final bookings = await endpoints.booking.getAll(sessionBuilder.asAdmin);
      expect(bookings, isNotEmpty);
    });

    test('when it is seeded again then there is still one admin', () async {
      await seed();

      expect(await endpoints.user.getAll(sessionBuilder.asAdmin), hasLength(1));
    });
  }, rollbackDatabase: RollbackDatabase.disabled);
}
