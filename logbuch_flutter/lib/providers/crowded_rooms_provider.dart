import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crowded_rooms_provider.g.dart';

/// The shared rooms of a booking that more than two bookings hold during
/// one of its nights.
@riverpod
Future<List<Room>> crowdedRooms(Ref ref, int bookingId) {
  return ref.watch(serverpodClientProvider).booking.crowdedRooms(bookingId);
}
