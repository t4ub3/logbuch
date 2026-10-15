import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/today.dart';
import 'package:logbuch_server/src/demo/demo_data.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// The environment variable that makes the server add the demo data each
/// time it starts, when it is `true`. Only a deployment for showing the app
/// sets it, such as the one on Serverpod Cloud.
const demoDataVariable = 'LOGBUCH_DEMO_DATA';

/// The admin who shows the app. The password is shorter than sign-up
/// allows, which only applies to users who sign up themselves.
const demoAdminEmail = 'admin@example.com';
const demoAdminPassword = 'admin';

/// Adds the demo admin, unless they exist, and then the [DemoData] around
/// [today], created as that admin. Like the demo data, running it again
/// adds nothing. Needs the auth services, see `setUpAuthServices`.
Future<void> seedDemo(
  Session session, {
  required DateTime today,
  void Function(String line) log = print,
}) async {
  final adminId = await addDemoAdmin(session, log: log);
  session.updateAuthenticated(
    // Signed in without a token, so there is no authentication to name.
    AuthenticationInfo(
      adminId.uuid,
      scopesOf(UserRole.admin),
      authId: 'demo-seed',
    ),
  );
  await DemoData(session, today: today, log: log).seed();
}

/// Adds [demoAdminEmail] as an admin who signs in with [demoAdminPassword],
/// unless there is an account with that email. Returns the id of the user.
Future<UuidValue> addDemoAdmin(
  Session session, {
  void Function(String line) log = print,
}) async {
  final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
  final account = await emailIdp.admin.findAccount(
    session,
    email: demoAdminEmail,
  );
  if (account != null) return account.authUserId;

  final adminId = await session.db.transaction((transaction) async {
    final user = await AuthServices.instance.authUsers.create(
      session,
      scopes: scopesOf(UserRole.admin),
      transaction: transaction,
    );
    await emailIdp.admin.createEmailAuthentication(
      session,
      authUserId: user.id,
      email: demoAdminEmail,
      password: demoAdminPassword,
      transaction: transaction,
    );
    await AuthServices.instance.userProfiles.createUserProfile(
      session,
      user.id,
      UserProfileData(email: demoAdminEmail),
      transaction: transaction,
    );
    return user.id;
  });
  log('+ admin $demoAdminEmail');
  return adminId;
}

/// Adds the demo data to the database of [pod] in a session of its own,
/// see [seedDemo]. The server is already running, so a failure is only
/// logged.
Future<void> seedDemoOnStart(Serverpod pod) async {
  final session = await pod.createSession();
  try {
    await seedDemo(
      session,
      today: await todayInGermany(session),
      log: session.log,
    );
    session.log('The demo data is up to date.');
  } catch (error, stackTrace) {
    session.log(
      'The demo data could not be added.',
      level: LogLevel.error,
      exception: error,
      stackTrace: stackTrace,
    );
  } finally {
    await session.close();
  }
}
