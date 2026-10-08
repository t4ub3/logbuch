import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';
import 'package:logbuch_flutter/theme/dimmed_accent.dart';

/// Linear year calendar: one row per month, with the days shifted so that
/// equal weekdays line up in the same column across all months.
class BookingsYearView extends ConsumerWidget {
  const BookingsYearView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(displayedYearProvider);
    final bookings = ref.watch(bookingsProvider);
    final startOfWeek = ref.watch(
      settingsProvider.select((s) => s.startOfWeek),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _YearHeader(year: year),
        Expanded(
          child: switch (bookings) {
            AsyncData(:final value) => _YearGrid(
              year: year,
              firstWeekday: startOfWeek.firstDayOfWeekIndex,
              bookings: [...value]..sort(compareByStart),
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

class _YearHeader extends ConsumerWidget {
  const _YearHeader({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(displayedYearProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            tooltip: context.t.bookings.previousYear,
            icon: const Icon(Icons.chevron_left),
            onPressed: notifier.previous,
          ),
          IconButton(
            tooltip: context.t.bookings.nextYear,
            icon: const Icon(Icons.chevron_right),
            onPressed: notifier.next,
          ),
          const SizedBox(width: 8),
          Text('$year', style: Theme.of(context).textTheme.titleLarge),
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

class _YearGrid extends StatelessWidget {
  const _YearGrid({
    required this.year,
    required this.firstWeekday,
    required this.bookings,
  });

  /// A month starting on the last weekday spans 6 + 31 columns.
  static const _columns = 37;
  static const _labelWidth = 56.0;
  static const _minCellWidth = 24.0;

  /// The space above the bars, for the number of the day.
  static const _numberHeight = 18.0;

  /// Bars get no thinner than their title needs, and no thicker than looks
  /// right for a single booking in a month.
  static const _minLaneHeight = 16.0;
  static const _maxLaneHeight = 22.0;

  final int year;

  /// 0 = Sunday, 1 = Monday. DateTime.weekday % 7 uses the same numbering.
  final int firstWeekday;
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    const minWidth = _labelWidth + _columns * _minCellWidth;
    final lanes = [
      for (var m = 1; m <= 12; m++)
        assignLanes(
          bookings,
          DateTime(year, m),
          DateTime(year, m, DateUtils.getDaysInMonth(year, m)),
        ),
    ];
    // All months have room for as many lanes as the busiest one, so the
    // bars are equally high throughout the year.
    final laneCount = max(1, lanes.map((l) => l.length).fold(0, max));

    return LayoutBuilder(
      builder: (context, constraints) {
        final grid = Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            children: [
              _buildWeekdayHeader(context),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) =>
                      _buildMonths(constraints.maxHeight, lanes, laneCount),
                ),
              ),
            ],
          ),
        );
        if (constraints.maxWidth >= minWidth) return grid;

        // Too narrow to fit all columns: scroll horizontally instead of
        // squeezing the days.
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(width: minWidth + 16, child: grid),
        );
      },
    );
  }

  /// The months share the [height] there is. Where that leaves too little
  /// room for the bars to show their titles, the months scroll instead.
  Widget _buildMonths(
    double height,
    List<List<List<Booking>>> lanes,
    int laneCount,
  ) {
    const minRowHeight = _numberHeight + 2;
    final fitted = height / 12;
    final needed = minRowHeight + laneCount * _minLaneHeight;
    final rowHeight = max(fitted, needed);
    final laneHeight = min(
      (rowHeight - minRowHeight) / laneCount,
      _maxLaneHeight,
    );

    Widget month(int m) => _MonthRow(
      month: DateTime(year, m),
      firstWeekday: firstWeekday,
      lanes: lanes[m - 1],
      laneHeight: laneHeight,
    );

    if (fitted >= needed) {
      return Column(
        children: [
          for (var m = 1; m <= 12; m++) Expanded(child: month(m)),
        ],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var m = 1; m <= 12; m++)
            SizedBox(height: rowHeight, child: month(m)),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    final l10n = MaterialLocalizations.of(context);
    final style = Theme.of(context).textTheme.labelSmall;

    return Row(
      children: [
        const SizedBox(width: _labelWidth),
        for (var i = 0; i < _columns; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                l10n.narrowWeekdays[(firstWeekday + i) % 7],
                textAlign: TextAlign.center,
                style: style,
              ),
            ),
          ),
      ],
    );
  }
}

class _MonthRow extends ConsumerWidget {
  const _MonthRow({
    required this.month,
    required this.firstWeekday,
    required this.lanes,
    required this.laneHeight,
  });

  final DateTime month;
  final int firstWeekday;

  /// The lanes of this month, see [assignLanes].
  final List<List<Booking>> lanes;
  final double laneHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final leadingDays = (month.weekday % 7 - firstWeekday) % 7;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final first = month;
    final last = DateTime(month.year, month.month, daysInMonth);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: _YearGrid._labelWidth,
          child: InkWell(
            // Jumps to the month view of this month.
            onTap: () {
              ref.read(displayedMonthProvider.notifier).show(month);
              ref
                  .read(selectedBookingsViewProvider.notifier)
                  .select(BookingsView.month);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat.MMM(locale).format(month),
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cellWidth = constraints.maxWidth / _YearGrid._columns;
              double columnOf(DateTime day) =>
                  (leadingDays + day.day - 1) * cellWidth;

              return Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < _YearGrid._columns; i++)
                        Expanded(
                          child:
                              i < leadingDays || i >= leadingDays + daysInMonth
                              ? const _EmptyCell()
                              : _DayCell(
                                  day: DateTime(
                                    month.year,
                                    month.month,
                                    i - leadingDays + 1,
                                  ),
                                ),
                        ),
                    ],
                  ),
                  // Each booking is one bar across its days in this month,
                  // long enough to show its title.
                  for (final (index, lane) in lanes.indexed)
                    for (final booking in lane)
                      if (!booking.startDay!.isAfter(last) &&
                          !booking.endDay!.isBefore(first))
                        _positionedBar(
                          booking: booking,
                          top: _YearGrid._numberHeight + index * laneHeight,
                          left: columnOf(
                            booking.startDay!.isBefore(first)
                                ? first
                                : booking.startDay!,
                          ),
                          right:
                              columnOf(
                                booking.endDay!.isAfter(last)
                                    ? last
                                    : booking.endDay!,
                              ) +
                              cellWidth,
                          isStart: !booking.startDay!.isBefore(first),
                          isEnd: !booking.endDay!.isAfter(last),
                        ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// A bar from [left] to [right], inset where the booking begins or ends.
  Widget _positionedBar({
    required Booking booking,
    required double top,
    required double left,
    required double right,
    required bool isStart,
    required bool isEnd,
  }) {
    final start = left + (isStart ? 2 : 0);
    final end = right - (isEnd ? 2 : 0);

    return Positioned(
      top: top,
      left: start,
      width: end - start,
      height: laneHeight,
      child: _BookingBar(booking: booking, isStart: isStart, isEnd: isEnd),
    );
  }
}

class _EmptyCell extends StatelessWidget {
  const _EmptyCell();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeekend =
        day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

    return Container(
      decoration: BoxDecoration(
        color: isWeekend
            ? theme.colorScheme.onSurface.withValues(alpha: 0.03)
            : null,
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
      padding: const EdgeInsets.only(top: 2, right: 2),
      alignment: Alignment.topRight,
      child: _DayNumber(day: day),
    );
  }
}

class _DayNumber extends StatelessWidget {
  const _DayNumber({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isToday = DateUtils.isSameDay(day, DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: isToday
          ? BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Text(
        '${day.day}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: isToday ? theme.colorScheme.onPrimary : null,
        ),
      ),
    );
  }
}

class _BookingBar extends StatelessWidget {
  const _BookingBar({
    required this.booking,
    required this.isStart,
    required this.isEnd,
  });

  final Booking booking;

  /// Whether the booking begins or ends in this month. Bars that go on in
  /// the month before or after are square at that end.
  final bool isStart;
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(3);
    final colorScheme = Theme.of(context).colorScheme;

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
            margin: const EdgeInsets.only(top: 1),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: colorScheme.dimmed(booking.color),
              borderRadius: BorderRadius.horizontal(
                left: isStart ? radius : Radius.zero,
                right: isEnd ? radius : Radius.zero,
              ),
            ),
            child: Text(
              booking.title,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurface,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
