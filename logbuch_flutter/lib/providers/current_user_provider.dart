import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_provider.g.dart';

/// The signed-in user with their role.
@riverpod
Future<AppUser> currentUser(Ref ref) {
  return ref.watch(serverpodClientProvider).user.me();
}

/// Whether the signed-in user may change data. Viewers can only read, so
/// everything that adds, edits or deletes is hidden from them.
@riverpod
bool canEdit(Ref ref) {
  return ref.watch(currentUserProvider).value?.role == UserRole.admin;
}
