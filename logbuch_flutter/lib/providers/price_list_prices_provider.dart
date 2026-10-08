import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_list_prices_provider.g.dart';

/// All prices of one price list.
@riverpod
Future<PriceListPrices> priceListPrices(Ref ref, int priceListId) {
  return ref.watch(serverpodClientProvider).priceList.getPrices(priceListId);
}
