import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'available_rooms_provider.g.dart';

/// The rooms that are free for the nights from [arrival] to [departure],
/// including those that the booking [exceptBookingId] holds itself.
@riverpod
Future<List<Room>> availableRooms(
  Ref ref, {
  required DateTime arrival,
  required DateTime departure,
  int? exceptBookingId,
}) {
  return ref
      .watch(serverpodClientProvider)
      .booking
      .availableRooms(arrival, departure, exceptBookingId: exceptBookingId);
}
