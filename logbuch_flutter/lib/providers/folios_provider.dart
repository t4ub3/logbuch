import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'folios_provider.g.dart';

/// The folios of a booking with their charges, payments and donations. The
/// server brings the charges up to date whenever they are read.
@riverpod
Future<List<Folio>> folios(Ref ref, int bookingId) {
  return ref.watch(serverpodClientProvider).billing.getFolios(bookingId);
}
