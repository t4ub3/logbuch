import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/bookings/booking_guests.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/guest_groups_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:yaru/yaru.dart';

/// How well the guests of a room fit into it.
enum RoomFit {
  /// Every bed is taken.
  full,

  /// There are beds left.
  freeBeds,

  /// There are more guests than beds.
  overfull,

  /// A crib is needed where none can be set up, or more than one.
  noCrib;

  bool get isValid => this == full || this == freeBeds;
}

/// Guests in a crib need no bed, but a room that takes a crib, and only one
/// of them fits into a room.
RoomFit roomFit(Room room, Iterable<Guest> guests) {
  final cribs = guests.where((guest) => guest.needsCrib).length;
  final inBeds = guests.length - cribs;
  if (inBeds > room.bedAmount) return RoomFit.overfull;
  if (cribs > 1 || (cribs == 1 && !room.cribPossible)) return RoomFit.noCrib;
  return inBeds == room.bedAmount ? RoomFit.full : RoomFit.freeBeds;
}

/// The rooms [booking] holds, by their number.
List<BookingRoom> _holds(Booking booking) => [...?booking.rooms]
  ..sort(
    (a, b) => (a.room?.roomNumber ?? '').compareTo(b.room?.roomNumber ?? ''),
  );

/// Which guests of a booking sleep in which of its rooms, and who has no
/// room yet.
class BookingAssignmentCard extends ConsumerWidget {
  const BookingAssignmentCard({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final holds = _holds(booking);

    Widget chip(Guest guest) =>
        _GuestChip(guest: guest, holds: holds, onMove: null);

    return BookingCard(
      title: t.assignment,
      // Without rooms there is nothing to put the guests into.
      onEdit: holds.isNotEmpty && ref.watch(canEditProvider)
          ? () => showBookingOverlay(
              context,
              ref,
              bookingId: booking.id!,
              overlay: BookingAssignmentEditor(booking: booking),
            )
          : null,
      child: holds.isEmpty
          ? CardNote(t.noRoomsHeld)
          : switch (ref.watch(guestGroupsProvider(booking.id!))) {
              AsyncError(:final error) => CardNote(
                context.t.common.loadFailed(error: error),
              ),
              AsyncValue(value: final groups?) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  _Unassigned(groups: groups, canEdit: false, chip: chip),
                  for (final hold in holds)
                    _RoomCard(
                      room: hold.room!,
                      guests: _guestsIn(hold, groups),
                      chip: chip,
                    ),
                ],
              ),
              _ => const CardLoading(),
            },
    );
  }
}

/// The guests of [groups] who sleep in the room of [hold].
List<Guest> _guestsIn(BookingRoom hold, List<GuestGroup> groups) => [
  for (final group in groups)
    for (final guest in group.guests ?? <Guest>[])
      if (guest.bookingRoomId == hold.id) guest,
];

/// The overlay that puts the guests of a booking into the rooms it holds.
/// Guests are dragged onto a room one by one or as a whole group, or moved
/// with the menu that opens when one of them is tapped. Every move is saved
/// at once.
class BookingAssignmentEditor extends ConsumerWidget {
  const BookingAssignmentEditor({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BookingOverlay(
      title: context.t.bookings.assignment,
      width: 960,
      height: 720,
      child: switch (ref.watch(guestGroupsProvider(booking.id!))) {
        AsyncError(:final error) => Center(
          child: Text(context.t.common.loadFailed(error: error)),
        ),
        AsyncValue(value: final groups?) => _Board(
          holds: _holds(booking),
          groups: groups,
          onMove: (guestIds, hold) => _move(context, ref, guestIds, hold),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Future<void> _move(
    BuildContext context,
    WidgetRef ref,
    List<int> guestIds,
    BookingRoom? hold,
  ) async {
    try {
      await ref.read(serverpodClientProvider).guest.assign(guestIds, hold?.id);
      ref.read(statusProvider.notifier).saved();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              validationMessage(context, error) ??
                  context.t.common.saveFailed(error: error),
            ),
          ),
        );
      }
    }
    ref.invalidate(guestGroupsProvider(booking.id!));
  }
}

/// Moves guests into the room of a hold, or out of their rooms with null.
typedef _Move = void Function(List<int> guestIds, BookingRoom? hold);

class _Board extends StatelessWidget {
  const _Board({
    required this.holds,
    required this.groups,
    required this.onMove,
  });

  final List<BookingRoom> holds;
  final List<GuestGroup> groups;
  final _Move onMove;

  @override
  Widget build(BuildContext context) {
    Widget chip(Guest guest) =>
        _GuestChip(guest: guest, holds: holds, onMove: onMove);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 250,
          child: _DropZone(
            onDrop: (guestIds) => onMove(guestIds, null),
            child: SingleChildScrollView(
              child: _Unassigned(groups: groups, canEdit: true, chip: chip),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ListView(
            children: [
              for (final hold in holds)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _DropZone(
                    onDrop: (guestIds) => onMove(guestIds, hold),
                    child: _RoomCard(
                      room: hold.room!,
                      guests: _guestsIn(hold, groups),
                      chip: chip,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Takes the guests that are dropped on [child] and highlights it while
/// guests hover over it.
class _DropZone extends StatelessWidget {
  const _DropZone({required this.onDrop, required this.child});

  final ValueChanged<List<int>> onDrop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DragTarget<List<int>>(
      onAcceptWithDetails: (details) => onDrop(details.data),
      builder: (context, candidates, rejected) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kYaruContainerRadius),
          color: candidates.isEmpty
              ? null
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        ),
        child: child,
      ),
    );
  }
}

/// The guests without a room, by group. A group is dragged by its name
/// if the guests can be moved.
class _Unassigned extends StatelessWidget {
  const _Unassigned({
    required this.groups,
    required this.canEdit,
    required this.chip,
  });

  final List<GuestGroup> groups;
  final bool canEdit;
  final Widget Function(Guest guest) chip;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final waiting = {
      for (final group in groups)
        group: [
          for (final guest in group.guests ?? <Guest>[])
            if (guest.bookingRoomId == null) guest,
        ],
    }..removeWhere((group, guests) => guests.isEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(t.unassigned, style: theme.textTheme.titleSmall),
        ),
        if (waiting.isEmpty)
          Text(t.everybodyAssigned, style: theme.textTheme.bodySmall),
        for (final MapEntry(key: group, value: guests) in waiting.entries) ...[
          _Dragged(
            guestIds: canEdit ? [for (final guest in guests) guest.id!] : null,
            label: '${group.name} (${guests.length})',
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Row(
                children: [
                  if (canEdit) const Icon(YaruIcons.drag_handle, size: 16),
                  if (canEdit) const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${group.name} (${guests.length})',
                      style: theme.textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Wrap(spacing: 6, runSpacing: 6, children: guests.map(chip).toList()),
        ],
      ],
    );
  }
}

/// A room with the guests assigned to it. Its border and its label show
/// whether they fit.
class _RoomCard extends StatelessWidget {
  const _RoomCard({
    required this.room,
    required this.guests,
    required this.chip,
  });

  final Room room;
  final List<Guest> guests;
  final Widget Function(Guest guest) chip;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context);
    final fit = roomFit(room, guests);
    final inBeds = guests.where((guest) => !guest.needsCrib).length;
    final color = switch (fit) {
      RoomFit.full => YaruColors.of(context).success,
      RoomFit.freeBeds => theme.dividerColor,
      RoomFit.overfull || RoomFit.noCrib => theme.colorScheme.error,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: fit.isValid ? 1 : 2),
        borderRadius: BorderRadius.circular(kYaruContainerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.rooms.room(number: room.roomNumber),
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Text(
                switch (fit) {
                  RoomFit.full => t.bookings.roomFull,
                  RoomFit.freeBeds => t.bookings.freeBeds(
                    n: room.bedAmount - inBeds,
                  ),
                  RoomFit.overfull => t.bookings.roomOverfull,
                  RoomFit.noCrib => t.bookings.roomNoCrib,
                },
                style: theme.textTheme.labelMedium?.copyWith(
                  color: fit.isValid ? null : theme.colorScheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            [
              t.bookings.bedsUsed(used: inBeds, beds: room.bedAmount),
              if (room.cribPossible) t.admin.rooms.crib,
            ].join(' · '),
            style: theme.textTheme.bodySmall,
          ),
          if (guests.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: guests.map(chip).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

/// A guest. If guests can be moved, this one can be dragged to a room, and
/// tapping opens a menu with the same choices for those who cannot or do
/// not want to drag.
class _GuestChip extends StatelessWidget {
  const _GuestChip({
    required this.guest,
    required this.holds,
    required this.onMove,
  });

  /// Stands for "without a room" in the menu, whose entries need a value.
  static const _noRoom = -1;

  final Guest guest;
  final List<BookingRoom> holds;

  /// Null if the guests are only shown.
  final _Move? onMove;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final onMove = this.onMove;
    final chip = Chip(
      avatar: guest.needsCrib ? const Icon(Icons.crib, size: 16) : null,
      label: Text(guest.name),
      visualDensity: VisualDensity.compact,
    );
    if (onMove == null) return chip;

    return _Dragged(
      guestIds: [guest.id!],
      label: guest.name,
      child: PopupMenuButton<int>(
        tooltip: t.bookings.moveTo,
        onSelected: (holdId) => onMove(
          [guest.id!],
          holds.where((hold) => hold.id == holdId).firstOrNull,
        ),
        itemBuilder: (context) => [
          for (final hold in holds)
            if (hold.id != guest.bookingRoomId)
              PopupMenuItem(
                value: hold.id,
                child: Text(t.rooms.room(number: hold.room!.roomNumber)),
              ),
          if (guest.bookingRoomId != null)
            PopupMenuItem(value: _noRoom, child: Text(t.bookings.unassigned)),
        ],
        child: chip,
      ),
    );
  }
}

/// Makes [child] a handle to drag guests with; [label] follows the pointer.
class _Dragged extends StatelessWidget {
  const _Dragged({
    required this.guestIds,
    required this.label,
    required this.child,
  });

  /// Null if the guests are only shown.
  final List<int>? guestIds;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final guestIds = this.guestIds;
    if (guestIds == null) return child;

    return Draggable<List<int>>(
      data: guestIds,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(label),
        ),
      ),
      child: child,
    );
  }
}
