import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'outdated_shares_provider.g.dart';

/// The invoices, of a booking and of those it shares a room with, that
/// charge that room for another split than the bookings share it now.
@riverpod
Future<List<OutdatedShare>> outdatedShares(Ref ref, int bookingId) {
  return ref.watch(serverpodClientProvider).billing.outdatedShares(bookingId);
}
