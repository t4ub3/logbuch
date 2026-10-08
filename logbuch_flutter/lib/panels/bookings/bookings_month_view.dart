import 'package:flutter/material.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';

/// Monthly calendar grid with each booking drawn as a colored bar on the days
/// it covers.
class BookingsMonthView extends ConsumerWidget {
  const BookingsMonthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(displayedMonthProvider);
    final bookings = ref.watch(bookingsProvider);
    final startOfWeek = ref.watch(
      settingsProvider.select((s) => s.startOfWeek),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MonthHeader(month: month),
        Expanded(
          child: switch (bookings) {
            AsyncData(:final value) => Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: _MonthGrid(
                month: month,
                firstWeekday: startOfWeek.firstDayOfWeekIndex,
                bookings: [...value]..sort(compareByStart),
              ),
            ),
            AsyncError(:final error) => Center(
              child: Text(context.t.common.loadFailed(error: error)),
            ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }
}

/// The displayed month with buttons to move through the months.
class MonthHeader extends ConsumerWidget {
  const MonthHeader({super.key, required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(displayedMonthProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            tooltip: context.t.bookings.previousMonth,
            icon: const Icon(Icons.chevron_left),
            onPressed: notifier.previous,
          ),
          IconButton(
            tooltip: context.t.bookings.nextMonth,
            icon: const Icon(Icons.chevron_right),
            onPressed: notifier.next,
          ),
          const SizedBox(width: 8),
          Text(
            MaterialLocalizations.of(context).formatMonthYear(month),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: notifier.today,
            child: Text(context.t.bookings.today),
          ),
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.firstWeekday,
    required this.bookings,
  });

  final DateTime month;

  /// 0 = Sunday, 1 = Monday. DateTime.weekday % 7 uses the same numbering.
  final int firstWeekday;
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    final l10n = MaterialLocalizations.of(context);
    final leadingDays = (month.weekday % 7 - firstWeekday) % 7;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final weeks = ((leadingDays + daysInMonth) / 7).ceil();

    DateTime dayAt(int week, int weekday) => DateTime(
      month.year,
      month.month,
      1 - leadingDays + week * 7 + weekday,
    );

    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    l10n.narrowWeekdays[(firstWeekday + i) % 7],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
          ],
        ),
        for (var w = 0; w < weeks; w++)
          Expanded(
            child: _buildWeek(dayAt, w),
          ),
      ],
    );
  }

  Widget _buildWeek(DateTime Function(int, int) dayAt, int week) {
    // Each booking keeps its lane for the whole week, so its bar stays on
    // one line even when bookings above it end.
    final lanes = assignLanes(bookings, dayAt(week, 0), dayAt(week, 6));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var d = 0; d < 7; d++)
          Expanded(
            child: _DayCell(
              day: dayAt(week, d),
              inMonth: dayAt(week, d).month == month.month,
              isRowStart: d == 0,
              lanes: lanes,
            ),
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.inMonth,
    required this.isRowStart,
    required this.lanes,
  });

  /// Rarely are more bookings in the house at once, so the bars are made
  /// as high as four of them fit below the day number.
  static const _lanesToFit = 4;
  static const _minBarHeight = 18.0;
  static const _maxBarHeight = 30.0;

  /// Room for the line that tells how many bookings are not shown.
  static const _moreHeight = 16.0;

  final DateTime day;
  final bool inMonth;
  final bool isRowStart;

  /// The lanes of this week, see [assignLanes].
  final List<List<Booking>> lanes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isToday = DateUtils.isSameDay(day, DateTime.now());
    final dayBookings = [
      for (final lane in lanes) lane.where((b) => b.coversDay(day)).firstOrNull,
    ];

    return Container(
      decoration: BoxDecoration(
        color: inMonth
            ? null
            : theme.colorScheme.onSurface.withValues(alpha: 0.03),
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: _DayNumber(day: day, isToday: isToday, inMonth: inMonth),
            ),
          ),
          Expanded(
            // Every day of a week has the same height and the same lanes,
            // so its bars come out alike and line up across the week.
            child: LayoutBuilder(
              builder: (context, constraints) {
                final room = constraints.maxHeight;
                final barHeight = (room / _lanesToFit).clamp(
                  _minBarHeight,
                  _maxBarHeight,
                );
                var shown = (room / barHeight).floor();
                if (shown < lanes.length) {
                  shown = ((room - _moreHeight) / barHeight).floor();
                }
                final hidden = dayBookings.skip(shown).nonNulls.length;

                return ClipRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Empty lanes keep their space so bars line up across
                      // the week.
                      for (final booking in dayBookings.take(shown))
                        booking == null
                            ? SizedBox(height: barHeight)
                            : _BookingBar(
                                booking: booking,
                                day: day,
                                isRowStart: isRowStart,
                                height: barHeight,
                              ),
                      if (hidden > 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            context.t.bookings.more(n: hidden),
                            maxLines: 1,
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DayNumber extends StatelessWidget {
  const _DayNumber({
    required this.day,
    required this.isToday,
    required this.inMonth,
  });

  final DateTime day;
  final bool isToday;
  final bool inMonth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isToday
        ? theme.colorScheme.onPrimary
        : inMonth
        ? null
        : theme.disabledColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: isToday
          ? BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Text(
        '${day.day}',
        style: theme.textTheme.labelMedium?.copyWith(color: color),
      ),
    );
  }
}

class _BookingBar extends StatelessWidget {
  const _BookingBar({
    required this.booking,
    required this.day,
    required this.isRowStart,
    required this.height,
  });

  final Booking booking;
  final DateTime day;
  final bool isRowStart;

  /// Height including the gap above the bar.
  final double height;

  @override
  Widget build(BuildContext context) {
    final isStart = booking.startDay == day;
    final isEnd = booking.endDay == day;
    const radius = Radius.circular(4);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => openBookingTab(context, booking),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: [
            booking.title,
            booking.dateRangeLabel(context),
            booking.leadLabel(context),
          ].nonNulls.join('\n'),
          child: Container(
            // The top margin is part of [height].
            height: height - 2,
            alignment: Alignment.centerLeft,
            // Bars run edge to edge between days so multi-day bookings read as
            // one continuous bar; they are only rounded and inset at their ends.
            margin: EdgeInsets.only(
              top: 2,
              left: isStart ? 4 : 0,
              right: isEnd ? 4 : 0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: booking.color,
              borderRadius: BorderRadius.horizontal(
                left: isStart ? radius : Radius.zero,
                right: isEnd ? radius : Radius.zero,
              ),
            ),
            child: Text(
              // Label only where the bar starts and at the start of each week.
              isStart || isRowStart ? booking.title : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  (height < 24 ? textTheme.labelSmall : textTheme.labelMedium)
                      ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
