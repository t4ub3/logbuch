import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'guest_groups_provider.g.dart';

/// The guests of a booking in their groups.
@riverpod
Future<List<GuestGroup>> guestGroups(Ref ref, int bookingId) {
  return ref.watch(serverpodClientProvider).guest.getByBooking(bookingId);
}
