import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_rates_provider.g.dart';

/// The meal rates of one season.
@riverpod
Future<List<MealRate>> mealRates(Ref ref, int seasonId) {
  return ref.watch(serverpodClientProvider).mealRate.getBySeason(seasonId);
}
