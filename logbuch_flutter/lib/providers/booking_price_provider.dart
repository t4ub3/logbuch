import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_price_provider.g.dart';

/// What a booking costs by the current rates, calculated by the server.
@riverpod
Future<BookingPrice> bookingPrice(Ref ref, int bookingId) {
  return ref.watch(serverpodClientProvider).pricing.calculate(bookingId);
}
