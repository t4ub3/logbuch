import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/app_logo.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';

/// Shows [child] once the user is signed in, and until then the screens to
/// sign in or up next to the logo of the app.
class SignInScreen extends StatefulWidget {
  final Widget child;
  const SignInScreen({super.key, required this.child});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_isSignedIn) return widget.child;

    return SignInLayout(
      form: SignInWidget(
        client: client,
        onAuthenticated: () {
          context.showSnackBar(
            message: 'User authenticated.',
            backgroundColor: colors.primaryContainer,
            foregroundColor: colors.onPrimaryContainer,
          );
        },
        onError: (error) {
          context.showSnackBar(
            message: 'Authentication failed: $error',
            backgroundColor: colors.errorContainer,
            foregroundColor: colors.onErrorContainer,
          );
        },
      ),
    );
  }
}

/// The logo of the app on the accent color in one half of the screen, and
/// [form] to sign in or up in the other.
class SignInLayout extends StatelessWidget {
  const SignInLayout({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    final form = Center(child: SingleChildScrollView(child: this.form));

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Too narrow for two halves: the logo goes above the form.
          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _LogoSide(height: 160, large: false),
                Expanded(child: form),
              ],
            );
          }
          return Row(
            children: [
              const Expanded(child: _LogoSide()),
              Expanded(child: form),
            ],
          );
        },
      ),
    );
  }
}

/// The logo of the app on the accent color.
class _LogoSide extends StatelessWidget {
  const _LogoSide({this.height, this.large = true});

  final double? height;

  /// Whether the logo fills a half of the screen rather than a band.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final style = large
        ? theme.textTheme.displayLarge
        : theme.textTheme.displaySmall;

    return Container(
      height: height,
      color: colors.primary,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: AppLogo(
          style: style?.copyWith(
            color: colors.onPrimary,
            fontSize: large ? 112 : null,
          ),
          // The accent color would vanish on itself.
          barColor: colors.onPrimary.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
