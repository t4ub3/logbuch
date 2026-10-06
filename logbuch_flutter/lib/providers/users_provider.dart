import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_provider.g.dart';

@riverpod
Future<List<AppUser>> users(Ref ref) {
  return ref.watch(serverpodClientProvider).user.getAll();
}
