import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/providers/available_rooms_provider.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// The rooms that are free during the nights of the booking of [tab], with
/// a checkbox each to let the booking hold them.
class BookingRoomsTab extends ConsumerStatefulWidget {
  const BookingRoomsTab({super.key, required this.tab});

  final BookingTab tab;

  @override
  ConsumerState<BookingRoomsTab> createState() => _BookingRoomsTabState();
}

class _BookingRoomsTabState extends ConsumerState<BookingRoomsTab> {
  Booking get _booking => widget.tab.booking!;

  List<BookingRoom> get _held => _booking.rooms ?? [];

  /// The ids of the checked rooms; differs from [_held] until saved.
  late Set<int> _selected = {for (final hold in _held) hold.roomId};
  bool _saving = false;
  Object? _error;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final arrival = _booking.arrival;
    final departure = _booking.departure;
    if (arrival == null || departure == null) {
      return Center(child: Text(t.roomsNeedDates, textAlign: TextAlign.center));
    }

    final available = ref.watch(
      availableRoomsProvider(
        arrival: arrival,
        departure: departure,
        exceptBookingId: _booking.id,
      ),
    );
    return switch (available) {
      AsyncError(:final error) => Center(
        child: Text(context.t.common.loadFailed(error: error)),
      ),
      AsyncValue(value: final available?) => _buildRooms(
        context,
        theme,
        _withHeld(available),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
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

  Widget _buildRooms(BuildContext context, ThemeData theme, List<Room> rooms) {
    final t = context.t;
    final canEdit = ref.watch(canEditProvider);
    final heldIds = {for (final hold in _held) hold.roomId};
    final dirty = !setEquals(_selected, heldIds);
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
                        onChanged: canEdit && !_saving
                            ? (checked) => _select(room, checked ?? false)
                            : null,
                        title: Text(t.rooms.room(number: room.roomNumber)),
                        subtitle: Text(
                          [
                            t.rooms.beds(n: room.bedAmount),
                            ?room.priceCategory?.name,
                            if (room.cribPossible) t.admin.rooms.crib,
                            if (!room.active) t.admin.rooms.inactive,
                          ].join(' · '),
                        ),
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
        Row(
          children: [
            Expanded(
              child: Text(
                [
                  t.bookings.selectedBeds(n: beds),
                  if (_booking.expectedGuestCount case final guests?)
                    t.bookings.guestsExpected(n: guests),
                ].join(' · '),
                style: theme.textTheme.bodySmall,
              ),
            ),
            if (canEdit)
              FilledButton.icon(
                icon: const Icon(YaruIcons.save),
                label: Text(t.common.save),
                onPressed: dirty && !_saving ? _save : null,
              ),
          ],
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
      ref
          .read(tabsProvider.notifier)
          .update(widget.tab.copyWith(booking: saved));
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.bookings.roomsSaved)));
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
      // Another booking may have taken a room meanwhile.
      ref.invalidate(availableRoomsProvider);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
