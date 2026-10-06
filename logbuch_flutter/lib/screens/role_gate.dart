import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:yaru/yaru.dart';

/// Shows [child] to signed-in users who have a role. A user who just signed
/// up has none and waits here until an admin gives them one.
class RoleGate extends ConsumerWidget {
  const RoleGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return switch (ref.watch(currentUserProvider)) {
      AsyncValue(value: final user?) when user.role != null => child,
      AsyncValue(value: final user?) => _Notice(
        title: t.auth.waitingTitle,
        text: t.auth.waitingText(email: user.email ?? ''),
        actionLabel: t.auth.checkAgain,
      ),
      AsyncError(:final error) => _Notice(
        text: t.common.loadFailed(error: error),
        actionLabel: t.common.retry,
      ),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}

/// A message with buttons to ask the server again and to sign out.
class _Notice extends ConsumerWidget {
  const _Notice({this.title, required this.text, required this.actionLabel});

  final String? title;
  final String text;
  final String actionLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(kYaruPagePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title case final title?) ...[
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                ],
                Text(text, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => ref
                          .read(serverpodClientProvider)
                          .auth
                          .signOutDevice(),
                      child: Text(context.t.common.signOut),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => ref.invalidate(currentUserProvider),
                      child: Text(actionLabel),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
