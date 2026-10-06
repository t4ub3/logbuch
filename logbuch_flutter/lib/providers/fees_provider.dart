import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fees_provider.g.dart';

@riverpod
Future<List<Fee>> fees(Ref ref) {
  return ref.watch(serverpodClientProvider).fee.getAll();
}
