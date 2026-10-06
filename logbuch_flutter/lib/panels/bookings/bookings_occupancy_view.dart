import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_month_view.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';

const _labelWidth = 120.0;
const _dayWidth = 36.0;
const _rowHeight = 36.0;
const _headerHeight = 32.0;

/// The part of a month during which a booking holds a room, in days from
/// the first of the month. Guests arrive and depart around the middle of a
/// day, so that a room can change hands on one day.
typedef _Stay = ({Booking booking, double start, double end});

/// The rooms as rows and the days of a month as columns, with a bar for
/// every booking that holds a room. Cancelled bookings hold nothing.
class BookingsOccupancyView extends ConsumerWidget {
  const BookingsOccupancyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(displayedMonthProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MonthHeader(month: month),
        Expanded(
          child: switch ((
            ref.watch(roomsProvider),
            ref.watch(bookingsProvider),
          )) {
            (AsyncData(value: final rooms), AsyncData(value: final bookings)) =>
              _OccupancyGrid(month: month, rooms: rooms, bookings: bookings),
            (AsyncError(:final error), _) || (_, AsyncError(:final error)) =>
              Center(child: Text(context.t.common.loadFailed(error: error))),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }
}

class _OccupancyGrid extends StatelessWidget {
  const _OccupancyGrid({
    required this.month,
    required this.rooms,
    required this.bookings,
  });

  /// The first day of the displayed month.
  final DateTime month;
  final List<Room> rooms;
  final List<Booking> bookings;

  /// The stays of the displayed month by the id of their room.
  Map<int, List<_Stay>> _stays(int days) {
    // Stored dates are midnight UTC, so the days are counted in UTC too.
    final first = DateTime.utc(month.year, month.month);
    final stays = <int, List<_Stay>>{};
    for (final booking in bookings) {
      final arrival = booking.arrival;
      final departure = booking.departure;
      if (arrival == null || departure == null) continue;
      if (booking.status == BookingStatus.cancelled) continue;

      var start = arrival.difference(first).inDays + 0.5;
      var end = departure.difference(first).inDays + 0.5;
      // A stay without a night still gets a visible bar.
      if (end - start < 0.5) {
        start -= 0.25;
        end += 0.25;
      }
      if (end <= 0 || start >= days) continue;
      for (final hold in booking.rooms ?? <BookingRoom>[]) {
        stays.putIfAbsent(hold.roomId, () => []).add((
          booking: booking,
          start: start.clamp(0, days).toDouble(),
          end: end.clamp(0, days).toDouble(),
        ));
      }
    }
    return stays;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = DateUtils.getDaysInMonth(month.year, month.month);
    final stays = _stays(days);
    // Rooms that were set inactive stay visible while they are held.
    final shown = [
      for (final room in rooms)
        if (room.active || stays.containsKey(room.id)) room,
    ];
    if (shown.isEmpty) return Center(child: Text(context.t.rooms.empty));

    final today = DateUtils.dateOnly(DateTime.now());
    final divider = theme.dividerColor;

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _labelWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: _headerHeight),
                for (final room in shown)
                  Container(
                    height: _rowHeight,
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: divider)),
                    ),
                    child: Text(
                      context.t.rooms.room(number: room.roomNumber),
                      overflow: TextOverflow.ellipsis,
                      style: room.active
                          ? null
                          : TextStyle(color: theme.disabledColor),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: days * _dayWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: _headerHeight,
                      child: Row(
                        children: [
                          for (var day = 1; day <= days; day++)
                            _DayLabel(
                              date: DateTime(month.year, month.month, day),
                              isToday:
                                  DateTime(month.year, month.month, day) ==
                                  today,
                            ),
                        ],
                      ),
                    ),
                    for (final room in shown)
                      SizedBox(
                        height: _rowHeight,
                        child: CustomPaint(
                          painter: _RowPainter(
                            month: month,
                            days: days,
                            line: divider,
                            weekend: theme.colorScheme.onSurface.withValues(
                              alpha: 0.04,
                            ),
                          ),
                          child: Stack(
                            children: [
                              for (final stay in stays[room.id] ?? <_Stay>[])
                                Positioned(
                                  left: stay.start * _dayWidth,
                                  width: (stay.end - stay.start) * _dayWidth,
                                  top: 5,
                                  bottom: 4,
                                  child: _StayBar(booking: stay.booking),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel({required this.date, required this.isToday});

  final DateTime date;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeekend = date.weekday >= DateTime.saturday;

    return SizedBox(
      width: _dayWidth,
      child: Center(
        child: Text(
          '${date.day}',
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: isToday ? FontWeight.bold : null,
            color: isToday
                ? theme.colorScheme.primary
                : isWeekend
                ? theme.disabledColor
                : null,
          ),
        ),
      ),
    );
  }
}

/// A booking in the row of one of its rooms. Tapping it opens the booking.
class _StayBar extends StatelessWidget {
  const _StayBar({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final label = [
      booking.title,
      ?booking.dateRangeLabel(context),
      booking.status.label(context),
    ].join('\n');

    return Tooltip(
      message: label,
      child: Material(
        color: booking.color,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openBookingTab(context, booking),
          child: CustomPaint(
            painter: booking.status.isTentative ? const _HatchPainter() : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  booking.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Light diagonal stripes over the bar of a booking that is not agreed on.
class _HatchPainter extends CustomPainter {
  const _HatchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 3;
    for (var x = -size.height; x < size.width; x += 9) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_HatchPainter oldDelegate) => false;
}

/// The lines between the days of a row, with weekends shaded.
class _RowPainter extends CustomPainter {
  const _RowPainter({
    required this.month,
    required this.days,
    required this.line,
    required this.weekend,
  });

  final DateTime month;
  final int days;
  final Color line;
  final Color weekend;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = line;
    final weekendPaint = Paint()..color = weekend;
    for (var day = 0; day < days; day++) {
      final left = day * _dayWidth;
      final weekday = DateTime(month.year, month.month, day + 1).weekday;
      if (weekday >= DateTime.saturday) {
        canvas.drawRect(
          Rect.fromLTWH(left, 0, _dayWidth, size.height),
          weekendPaint,
        );
      }
      canvas.drawLine(Offset(left, 0), Offset(left, size.height), linePaint);
    }
    canvas.drawLine(Offset.zero, Offset(size.width, 0), linePaint);
  }

  @override
  bool shouldRepaint(_RowPainter oldDelegate) =>
      month != oldDelegate.month ||
      line != oldDelegate.line ||
      weekend != oldDelegate.weekend;
}
