import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_agenda_view.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_month_view.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_year_view.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';

class BookingsPanel extends ConsumerWidget {
  const BookingsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(selectedBookingsViewProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SegmentedButton<BookingsView>(
              segments: const [
                ButtonSegment(
                  value: BookingsView.agenda,
                  label: Text('Agenda'),
                  icon: Icon(Icons.view_agenda),
                ),
                ButtonSegment(
                  value: BookingsView.month,
                  label: Text('Month'),
                  icon: Icon(Icons.calendar_view_month),
                ),
                ButtonSegment(
                  value: BookingsView.year,
                  label: Text('Year'),
                  icon: Icon(Icons.calendar_today),
                ),
              ],
              selected: {view},
              showSelectedIcon: false,
              onSelectionChanged: (selection) => ref
                  .read(selectedBookingsViewProvider.notifier)
                  .select(selection.single),
            ),
          ),
        ),
        Expanded(
          child: switch (view) {
            BookingsView.agenda => const BookingsAgendaView(),
            BookingsView.month => const BookingsMonthView(),
            BookingsView.year => const BookingsYearView(),
          },
        ),
      ],
    );
  }
}
