import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seasons_provider.g.dart';

@riverpod
Future<List<Season>> seasons(Ref ref) {
  return ref.watch(serverpodClientProvider).season.getAll();
}
