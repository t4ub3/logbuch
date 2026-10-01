import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_agenda_view.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_month_view.dart';
import 'package:logbuch_flutter/panels/bookings/bookings_year_view.dart';
import 'package:logbuch_flutter/providers/bookings_view_provider.dart';
import 'package:yaru/yaru.dart';

class BookingsPanel extends ConsumerWidget {
  const BookingsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(selectedBookingsViewProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: SegmentedButton<BookingsView>(
                  segments: [
                    ButtonSegment(
                      value: BookingsView.agenda,
                      label: Text(context.t.bookings.agenda),
                      icon: const Icon(Icons.view_agenda),
                    ),
                    ButtonSegment(
                      value: BookingsView.month,
                      label: Text(context.t.bookings.month),
                      icon: const Icon(Icons.calendar_view_month),
                    ),
                    ButtonSegment(
                      value: BookingsView.year,
                      label: Text(context.t.bookings.year),
                      icon: const Icon(Icons.calendar_today),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: Icon(YaruIcons.plus),
                onPressed: () {},
                label: Text(context.t.bookings.newBooking),
              ),
            ),
          ],
        ),
        const InsetDivider(),
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
