import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buildings_provider.g.dart';

@riverpod
Future<List<Building>> buildings(Ref ref) {
  return ref.watch(serverpodClientProvider).building.getAll();
}
