import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'operator_provider.g.dart';

/// The details of the organisation that runs the house, or null if none
/// were entered yet.
@riverpod
Future<Operator?> operator(Ref ref) {
  return ref.watch(serverpodClientProvider).operator.load();
}
