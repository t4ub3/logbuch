import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/bookings/booking_assignment_tab.dart';
import 'package:logbuch_flutter/panels/bookings/booking_billing_tab.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/panels/bookings/booking_guests_tab.dart';
import 'package:logbuch_flutter/panels/bookings/booking_price_tab.dart';
import 'package:logbuch_flutter/panels/bookings/booking_rooms_tab.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// The booking of [tab]: an overview that can be opened for editing, the
/// rooms it holds, its guests and their rooms, and what it costs.
class BookingDetails extends ConsumerWidget {
  const BookingDetails({super.key, required this.tab});

  final BookingTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final booking = tab.booking!;

    return DefaultTabController(
      length: 6,
      child: Center(
        child: SizedBox(
          width: 760,
          child: Padding(
            padding: const EdgeInsets.all(kYaruPagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 16, color: booking.color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        booking.title,
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                    if (ref.watch(canEditProvider)) ...[
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        icon: const Icon(YaruIcons.pen),
                        label: Text(t.edit),
                        onPressed: () => ref
                            .read(tabsProvider.notifier)
                            .update(tab.copyWith(editing: true)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                _StatusProgress(status: booking.status),
                const SizedBox(height: 16),
                // The tabs scroll if the window is too narrow for them.
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: t.overview),
                    Tab(text: t.rooms),
                    Tab(text: t.guests),
                    Tab(text: t.assignment),
                    Tab(text: t.price),
                    Tab(text: t.billing),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      _Overview(booking: booking),
                      BookingRoomsTab(tab: tab),
                      BookingGuestsTab(bookingId: booking.id!),
                      BookingAssignmentTab(booking: booking),
                      BookingPriceTab(bookingId: booking.id!),
                      BookingBillingTab(bookingId: booking.id!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final lead = booking.lead;

    Widget tile(IconData icon, String title, String text) => YaruListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: SelectableText(text),
    );

    return SingleChildScrollView(
      child: YaruSection(
        child: Column(
          children: [
            tile(
              YaruIcons.calendar,
              t.dates,
              booking.dateRangeLabel(context) ?? t.noDates,
            ),
            tile(YaruIcons.user, t.leadField, booking.leadName),
            if (lead?.mail case final mail? when mail.isNotEmpty)
              tile(YaruIcons.mail, t.email, mail),
            if (lead?.phone case final phone? when phone.isNotEmpty)
              tile(YaruIcons.call_incoming, t.phone, phone),
            if (booking.organization case final organization?)
              tile(Icons.apartment, t.organization, organization.name),
            if (booking.optionExpiresAt case final expiry?)
              tile(
                YaruIcons.clock,
                t.optionExpiresAt,
                formatDate(context, expiry),
              ),
            if (booking.mealPlan case final mealPlan?)
              tile(Icons.restaurant, t.mealPlan, mealPlan.name),
            tile(
              Icons.receipt_long,
              t.billingMode,
              booking.billingMode.label(context),
            ),
            if (booking.expectedGuestCount case final guests?)
              tile(YaruIcons.users, t.expectedGuests, '$guests'),
            if (booking.notes case final notes?)
              tile(YaruIcons.document, t.notes, notes),
          ],
        ),
      ),
    );
  }
}

/// The steps a booking goes through as a segmented bar, filled up to and
/// including the current [status]. A cancelled booking has left these steps
/// and only says so.
class _StatusProgress extends StatelessWidget {
  const _StatusProgress({required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (status == BookingStatus.cancelled) {
      return Text(
        status.label(context),
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.error),
      );
    }

    final steps = [
      for (final step in BookingStatus.values)
        if (step != BookingStatus.cancelled) step,
    ];
    return Semantics(
      label: '${context.t.bookings.status}: ${status.label(context)}',
      child: Row(
        children: [
          for (final step in steps) ...[
            if (step != steps.first) const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: step.index <= status.index
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.label(context),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: step == status ? FontWeight.bold : null,
                      color: step.index <= status.index
                          ? null
                          : theme.disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
