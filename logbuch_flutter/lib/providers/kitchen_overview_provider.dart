import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kitchen_overview_provider.g.dart';

/// The guests of a booking summed up for the kitchen, by the server.
@riverpod
Future<KitchenOverview> kitchenOverview(Ref ref, int bookingId) {
  return ref.watch(serverpodClientProvider).guest.kitchenOverview(bookingId);
}
