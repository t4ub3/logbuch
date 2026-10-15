import 'package:logbuch_server/src/auth/roles.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// Sets up how users sign in. The server does it when it starts; tests and
/// the seed, which run without it, do it themselves.
void setUpAuthServices() {
  AuthServices.set(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password
      // authentication. The default setup works with Serverpod Cloud without
      // configuration. In development the verification codes are logged to
      // the console, and in staging and production they are sent through the
      // Serverpod Cloud email service. If you want to use a custom provider
      // for sending emails, use `EmailIdpConfigFromPasswords`.
      ServerpodCloudEmailIdpConfig(
        appDisplayName: 'logbuch',
      ),
    ],
    // The first user to sign up becomes the admin who gives the others
    // their roles.
    authUsersConfig: const AuthUsersConfig(
      onBeforeAuthUserCreated: grantFirstUserAdmin,
    ),
  );
}
