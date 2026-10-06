import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'households_provider.g.dart';

/// All households with their members.
@riverpod
Future<List<Household>> households(Ref ref) {
  return ref.watch(serverpodClientProvider).household.getAll();
}
