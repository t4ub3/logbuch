import 'package:flutter/material.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/async_list_view.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:yaru/yaru.dart';

/// Lists bookings that have not ended yet, soonest first.
class BookingsAgendaView extends ConsumerWidget {
  const BookingsAgendaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateUtils.dateOnly(DateTime.now());

    return AsyncListView<Booking>(
      value: ref
          .watch(bookingsProvider)
          .whenData((bookings) => _upcoming(bookings, today)),
      onRetry: () => ref.refresh(bookingsProvider.future),
      emptyText: context.t.bookings.noUpcoming,
      itemBuilder: (context, booking) => YaruListTile(
        leading: Icon(Icons.event, color: booking.color),
        titleText: booking.title,
        subtitleText: [
          booking.dateRangeLabel(context),
          booking.leadLabel(context),
        ].nonNulls.join(' · '),
        onTap: () => openBookingTab(context, booking),
      ),
    );
  }

  /// Undated bookings are kept and listed last.
  List<Booking> _upcoming(List<Booking> bookings, DateTime today) {
    return bookings.where((b) {
      final end = b.endDay;
      return end == null || !end.isBefore(today);
    }).toList()..sort(compareByStart);
  }
}
