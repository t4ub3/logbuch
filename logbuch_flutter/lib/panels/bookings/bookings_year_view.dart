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

  final int year;

  /// 0 = Sunday, 1 = Monday. DateTime.weekday % 7 uses the same numbering.
  final int firstWeekday;
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    const minWidth = _labelWidth + _columns * _minCellWidth;

    return LayoutBuilder(
      builder: (context, constraints) {
        final grid = Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            children: [
              _buildWeekdayHeader(context),
              for (var m = 1; m <= 12; m++)
                Expanded(
                  child: _MonthRow(
                    month: DateTime(year, m),
                    firstWeekday: firstWeekday,
                    bookings: bookings,
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
    required this.bookings,
  });

  final DateTime month;
  final int firstWeekday;
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final leadingDays = (month.weekday % 7 - firstWeekday) % 7;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final lanes = assignLanes(
      bookings,
      month,
      DateTime(month.year, month.month, daysInMonth),
    );

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
        for (var i = 0; i < _YearGrid._columns; i++)
          Expanded(
            child: i < leadingDays || i >= leadingDays + daysInMonth
                ? const _EmptyCell()
                : _DayCell(
                    day: DateTime(
                      month.year,
                      month.month,
                      i - leadingDays + 1,
                    ),
                    lanes: lanes,
                  ),
          ),
      ],
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
  const _DayCell({required this.day, required this.lanes});

  final DateTime day;
  final List<List<Booking>> lanes;

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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: _DayNumber(day: day),
            ),
          ),
          // Lanes share the remaining height and get thinner when a month
          // has many overlapping bookings.
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final lane in lanes)
                  Flexible(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 7),
                      child: _laneBar(lane),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _laneBar(List<Booking> lane) {
    for (final booking in lane) {
      if (booking.coversDay(day)) {
        return _BookingBar(booking: booking, day: day);
      }
    }
    return const SizedBox.expand();
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
  const _BookingBar({required this.booking, required this.day});

  final Booking booking;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final isStart = booking.startDay == day;
    final isEnd = booking.endDay == day;
    const radius = Radius.circular(3);

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
            // Bars run edge to edge between days so multi-day bookings read as
            // one continuous bar; they are only rounded and inset at their ends.
            margin: EdgeInsets.only(
              top: 1,
              left: isStart ? 2 : 0,
              right: isEnd ? 2 : 0,
            ),
            decoration: BoxDecoration(
              color: booking.color,
              borderRadius: BorderRadius.horizontal(
                left: isStart ? radius : Radius.zero,
                right: isEnd ? radius : Radius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
