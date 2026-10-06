import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_categories_provider.g.dart';

@riverpod
Future<List<PriceCategory>> priceCategories(Ref ref) {
  return ref.watch(serverpodClientProvider).priceCategory.getAll();
}
