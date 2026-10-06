import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'age_groups_provider.g.dart';

@riverpod
Future<List<AgeGroup>> ageGroups(Ref ref) {
  return ref.watch(serverpodClientProvider).ageGroup.getAll();
}
