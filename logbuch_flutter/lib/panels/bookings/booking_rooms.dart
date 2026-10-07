import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/providers/available_rooms_provider.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// What is said about a room next to its number.
String _roomDetails(BuildContext context, Room room) {
  final t = context.t;
  return [
    t.rooms.beds(n: room.bedAmount),
    ?room.priceCategory?.name,
    if (room.cribPossible) t.admin.rooms.crib,
    if (!room.active) t.admin.rooms.inactive,
  ].join(' · ');
}

/// The rooms the booking of [tab] holds.
class BookingRoomsCard extends ConsumerWidget {
  const BookingRoomsCard({super.key, required this.tab});

  final BookingTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final booking = tab.booking!;
    final hasDates = booking.arrival != null && booking.departure != null;
    final rooms = [
      for (final hold in booking.rooms ?? <BookingRoom>[]) ?hold.room,
    ]..sort((a, b) => a.roomNumber.compareTo(b.roomNumber));
    final beds = rooms.fold(0, (beds, room) => beds + room.bedAmount);

    return BookingCard(
      title: t.bookings.rooms,
      // Rooms are free or taken for certain nights, so without dates there
      // are none to choose from.
      onEdit: hasDates && ref.watch(canEditProvider)
          ? () => showBookingOverlay(
              context,
              ref,
              bookingId: booking.id!,
              overlay: BookingRoomsEditor(tab: tab),
            )
          : null,
      child: !hasDates
          ? CardNote(t.bookings.roomsNeedDates)
          : rooms.isEmpty
          ? CardNote(t.bookings.noRoomsHeld)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardNote(
                  [
                    t.bookings.bedsInRooms(
                      beds: t.rooms.beds(n: beds),
                      rooms: t.dashboard.roomCount(n: rooms.length),
                    ),
                    if (booking.expectedGuestCount case final guests?)
                      t.bookings.guestsExpected(n: guests),
                  ].join(' · '),
                ),
                const SizedBox(height: 8),
                for (final room in rooms)
                  CardRow(
                    label: t.rooms.room(number: room.roomNumber),
                    detail: _roomDetails(context, room),
                  ),
              ],
            ),
    );
  }
}

/// The overlay in which the booking of [tab] takes its rooms: those that
/// are free during its nights, with a checkbox each. The booking must have
/// dates.
class BookingRoomsEditor extends ConsumerStatefulWidget {
  const BookingRoomsEditor({super.key, required this.tab});

  final BookingTab tab;

  @override
  ConsumerState<BookingRoomsEditor> createState() => _BookingRoomsEditorState();
}

class _BookingRoomsEditorState extends ConsumerState<BookingRoomsEditor> {
  Booking get _booking => widget.tab.booking!;

  List<BookingRoom> get _held => _booking.rooms ?? [];

  /// The ids of the checked rooms; differs from [_held] until saved.
  late Set<int> _selected = {for (final hold in _held) hold.roomId};
  bool _saving = false;
  Object? _error;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final available = ref.watch(
      availableRoomsProvider(
        arrival: _booking.arrival!,
        departure: _booking.departure!,
        exceptBookingId: _booking.id,
      ),
    );
    final dirty = !setEquals(_selected, {
      for (final hold in _held) hold.roomId,
    });

    return BookingOverlay(
      title: t.bookings.rooms,
      width: 520,
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: Text(t.common.cancel),
        ),
        ElevatedButton(
          onPressed: dirty && !_saving ? _save : null,
          child: Text(t.common.save),
        ),
      ],
      child: switch (available) {
        AsyncError(:final error) => Center(
          child: Text(t.common.loadFailed(error: error)),
        ),
        AsyncValue(value: final available?) => _buildRooms(
          context,
          _withHeld(available),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  /// The free rooms together with the rooms the booking holds, as those
  /// stay listed when they were set inactive meanwhile.
  List<Room> _withHeld(List<Room> available) {
    final rooms = {
      for (final room in _held.map((hold) => hold.room).nonNulls)
        room.id!: room,
      for (final room in available) room.id!: room,
    };
    return rooms.values.toList()
      ..sort((a, b) => a.roomNumber.compareTo(b.roomNumber));
  }

  Widget _buildRooms(BuildContext context, List<Room> rooms) {
    final t = context.t;
    final theme = Theme.of(context);
    final beds = rooms
        .where((room) => _selected.contains(room.id))
        .fold(0, (beds, room) => beds + room.bedAmount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: rooms.isEmpty
              ? Center(child: Text(t.bookings.noFreeRooms))
              : ListView(
                  children: [
                    for (final room in rooms)
                      YaruCheckboxListTile(
                        value: _selected.contains(room.id),
                        onChanged: _saving
                            ? null
                            : (checked) => _select(room, checked ?? false),
                        title: Text(t.rooms.room(number: room.roomNumber)),
                        subtitle: Text(_roomDetails(context, room)),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 8),
        if (_error case final error?)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              validationMessage(context, error) ??
                  t.common.saveFailed(error: error),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        Text(
          [
            t.bookings.selectedBeds(n: beds),
            if (_booking.expectedGuestCount case final guests?)
              t.bookings.guestsExpected(n: guests),
          ].join(' · '),
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  void _select(Room room, bool selected) {
    setState(() {
      _selected = {
        for (final id in _selected)
          if (id != room.id) id,
        if (selected) room.id!,
      };
    });
  }

  /// Lets the booking hold the checked rooms and closes the overlay.
  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final saved = await ref
          .read(serverpodClientProvider)
          .booking
          .setRooms(_booking.id!, _selected.toList());
      ref.invalidate(bookingsProvider);
      ref.read(statusProvider.notifier).saved();
      ref
          .read(tabsProvider.notifier)
          .update(widget.tab.copyWith(booking: saved));
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = error;
      });
      // Another booking may have taken a room meanwhile.
      ref.invalidate(availableRoomsProvider);
    }
  }
}
