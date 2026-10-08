import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_lists_provider.g.dart';

/// The price lists by their first day.
@riverpod
Future<List<PriceList>> priceLists(Ref ref) {
  return ref.watch(serverpodClientProvider).priceList.getAll();
}
