import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:logbuch_flutter/theme/dimmed_accent.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:yaru/yaru.dart';

/// The bar below the main screen: what the app is doing or has just done,
/// and next to it, on the right, the signed-in user.
class StatusBarComponent extends StatelessWidget {
  const StatusBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.dimmedPrimary,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            const Expanded(child: _StatusNotice()),
            VerticalDivider(width: 1, color: colorScheme.onSurface),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: _AccountMenu(),
            ),
          ],
        ),
      ),
    );
  }
}

/// What [statusProvider] holds: an animation while data is loaded, and for
/// a while what has just happened. The whole part takes the color that a
/// [YaruInfoBox] of that kind is filled with, and is the color of the bar
/// while there is nothing to say.
class _StatusNotice extends ConsumerWidget {
  const _StatusNotice();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final theme = Theme.of(context);
    final status = ref.watch(statusProvider);

    final (type, text) = switch (status.message) {
      DataLoaded() => (YaruInfoType.success, t.status.loaded),
      Saved() => (YaruInfoType.success, t.status.saved),
      Deleted() => (YaruInfoType.success, t.status.deleted),
      DocumentCreated(:final name) => (
        YaruInfoType.success,
        t.status.documentCreated(name: name),
      ),
      Done(:final text) => (YaruInfoType.success, text),
      LoadFailed(:final error) => (
        YaruInfoType.danger,
        t.common.loadFailed(error: error),
      ),
      null => (
        YaruInfoType.information,
        status.loading ? t.status.loading : null,
      ),
    };
    final accent = type.getColor(context);
    final color = text == null
        ? theme.colorScheme.dimmedPrimary
        // As see-through as YaruTranslucentContainer makes it.
        : Color.alphaBlend(
            accent.withValues(alpha: 0.3),
            theme.colorScheme.surface,
          );
    final spinner = SizedBox.square(
      dimension: 12,
      child: CircularProgressIndicator(strokeWidth: 2, color: accent),
    );

    return Semantics(
      liveRegion: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: text == null
              ? const SizedBox.shrink()
              // A long error is cut off, so it can be read in full here.
              : Tooltip(
                  key: ValueKey((type, text)),
                  message: text,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status.message == null)
                        spinner
                      else
                        Icon(type.iconData, size: 16, color: accent),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      // Data is loaded again while the message still shows.
                      if (status.message != null && status.loading) ...[
                        const SizedBox(width: 8),
                        spinner,
                      ],
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

/// The signed-in user. A click opens a menu, which so far only signs out.
class _AccountMenu extends ConsumerWidget {
  const _AccountMenu();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider).value;
    if (user == null) return const SizedBox.shrink();

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(YaruIcons.log_out),
          onPressed: () =>
              ref.read(serverpodClientProvider).auth.signOutDevice(),
          child: Text(context.t.common.signOut),
        ),
      ],
      builder: (context, controller, child) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.onSurface,
            iconColor: theme.colorScheme.onSurface,
            textStyle: theme.textTheme.bodySmall,
            visualDensity: VisualDensity.compact,
          ),
          icon: const Icon(YaruIcons.user, size: 16),
          label: Text(
            user.email ?? context.t.auth.account,
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
        ),
      ),
    );
  }
}
