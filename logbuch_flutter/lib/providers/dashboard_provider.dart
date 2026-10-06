import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

/// What the start screen shows about today and the days ahead. It is loaded
/// anew whenever the start screen is opened.
@riverpod
Future<Dashboard> dashboard(Ref ref) {
  return ref.watch(serverpodClientProvider).dashboard.load();
}
