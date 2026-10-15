import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/async_list_view.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:logbuch_flutter/providers/users_provider.dart';
import 'package:yaru/yaru.dart';

extension UserRoleLabel on UserRole? {
  String label(BuildContext context) {
    final t = context.t.auth.roles;
    return switch (this) {
      UserRole.admin => t.admin,
      UserRole.viewer => t.viewer,
      null => t.none,
    };
  }
}

/// The accounts that signed up, with the role an admin gives each of them.
/// An admin can delete the other accounts.
class UsersSection extends ConsumerWidget {
  const UsersSection({super.key});

  // DropdownMenu entries need a non-null value, so "no access" is
  // represented by a sentinel instead of null.
  static const _noRole = 'none';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.users;
    final me = ref.watch(currentUserProvider).value;

    return AsyncListView<AppUser>(
      value: ref.watch(usersProvider),
      onRetry: () => ref.refresh(usersProvider.future),
      emptyText: t.empty,
      itemBuilder: (context, user) {
        final isMe = user.authUserId == me?.authUserId;
        final email = user.email ?? t.unknownEmail;

        return YaruListTile(
          leading: const Icon(YaruIcons.user),
          titleText: isMe ? '$email (${t.you})' : email,
          // Admins cannot change their own role or delete themselves, so
          // one always remains.
          trailing: isMe
              ? Text(user.role.label(context))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownMenu<String>(
                      key: ValueKey((user.authUserId, user.role)),
                      initialSelection: user.role?.name ?? _noRole,
                      requestFocusOnTap: false,
                      onSelected: (value) => _setRole(
                        context,
                        ref,
                        user,
                        value == null || value == _noRole
                            ? null
                            : UserRole.values.byName(value),
                      ),
                      dropdownMenuEntries: [
                        for (final UserRole? role in [
                          null,
                          ...UserRole.values,
                        ])
                          DropdownMenuEntry(
                            value: role?.name ?? _noRole,
                            label: role.label(context),
                          ),
                      ],
                    ),
                    IconButton(
                      tooltip: context.t.common.delete,
                      icon: const Icon(YaruIcons.trash),
                      onPressed: () async {
                        final deleted = await confirmAndDelete(
                          context,
                          name: email,
                          hint: t.deleteHint,
                          delete: () => ref
                              .read(serverpodClientProvider)
                              .user
                              .delete(user.authUserId),
                        );
                        if (deleted) ref.invalidate(usersProvider);
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _setRole(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
    UserRole? role,
  ) async {
    try {
      await ref
          .read(serverpodClientProvider)
          .user
          .setRole(user.authUserId, role);
      ref.read(statusProvider.notifier).saved();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              validationMessage(context, error) ??
                  context.t.common.saveFailed(error: error),
            ),
          ),
        );
      }
    }
    ref.invalidate(usersProvider);
  }
}
