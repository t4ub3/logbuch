import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_rates_provider.g.dart';

/// The room rates of one season.
@riverpod
Future<List<RoomRate>> roomRates(Ref ref, int seasonId) {
  return ref.watch(serverpodClientProvider).roomRate.getBySeason(seasonId);
}
