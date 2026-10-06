import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/bookings/amount_row.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/dashboard_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// The start screen: who arrives and departs in the days ahead, how full
/// the house is tonight, what needs attention, and who is to be catered
/// for today and tomorrow.
class DashboardPanel extends ConsumerWidget {
  const DashboardPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return switch (ref.watch(dashboardProvider)) {
      AsyncError(:final error) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(t.common.loadFailed(error: error)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => ref.invalidate(dashboardProvider),
              child: Text(t.common.retry),
            ),
          ],
        ),
      ),
      AsyncValue(value: final dashboard?) => RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardProvider.future),
        child: _Dashboard(dashboard: dashboard),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.dashboard});

  final Dashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final t = context.t.dashboard;
    final stays = [
      _Stays(
        title: t.arrivals,
        emptyText: t.noArrivals,
        stays: dashboard.arrivals,
      ),
      _Stays(
        title: t.departures,
        emptyText: t.noDepartures,
        stays: dashboard.departures,
      ),
    ];
    final attention = [
      _Tonight(dashboard: dashboard),
      _Options(options: dashboard.expiringOptions, today: dashboard.today),
      _Balances(balances: dashboard.openBalances),
    ];

    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        padding: const EdgeInsets.all(kYaruPagePadding),
        children: [
          // Two columns where there is room for them.
          if (constraints.maxWidth >= 900)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _Spaced(children: stays)),
                const SizedBox(width: 16),
                Expanded(child: _Spaced(children: attention)),
              ],
            )
          else
            _Spaced(children: [...stays, ...attention]),
          const SizedBox(height: 16),
          _Catering(days: dashboard.meals),
        ],
      ),
    );
  }
}

/// Sections below each other with a gap in between.
class _Spaced extends StatelessWidget {
  const _Spaced({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, child) in children.indexed) ...[
          if (index > 0) const SizedBox(height: 16),
          child,
        ],
      ],
    );
  }
}

/// A date that was stored as midnight UTC, with its weekday.
String _day(BuildContext context, DateTime date) =>
    MaterialLocalizations.of(context).formatMediumDate(toLocalDate(date));

/// Opens the booking in a tab. The dashboard only knows bookings by their
/// id, so the booking is fetched first.
Future<void> _openBooking(
  BuildContext context,
  WidgetRef ref,
  int bookingId,
) async {
  final booking = await ref
      .read(serverpodClientProvider)
      .booking
      .getById(bookingId);
  if (booking != null && context.mounted) openBookingTab(context, booking);
}

/// The bookings that arrive or depart in the days ahead.
class _Stays extends ConsumerWidget {
  const _Stays({
    required this.title,
    required this.emptyText,
    required this.stays,
  });

  final String title;
  final String emptyText;
  final List<DashboardStay> stays;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return YaruSection(
      headline: Text(title),
      child: stays.isEmpty
          ? _Empty(emptyText)
          : Column(
              children: [
                for (final stay in stays)
                  YaruListTile(
                    leading: const Icon(Icons.event),
                    titleText: stay.title,
                    subtitleText: [
                      _day(context, stay.date),
                      if (stay.leadName.isNotEmpty) stay.leadName,
                      if (stay.guestCount case final guests?)
                        t.bookings.guestCount(n: guests),
                      if (stay.roomCount > 0)
                        t.dashboard.roomCount(n: stay.roomCount),
                      stay.status.label(context),
                    ].join(' · '),
                    onTap: () => _openBooking(context, ref, stay.bookingId),
                  ),
              ],
            ),
    );
  }
}

/// How full the house is tonight.
class _Tonight extends StatelessWidget {
  const _Tonight({required this.dashboard});

  final Dashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final t = context.t.dashboard;
    final occupied = dashboard.roomsOccupied;
    final total = dashboard.roomsTotal;

    return YaruSection(
      headline: Text(t.tonight),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.roomsOccupied(occupied: occupied, total: total)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: total == 0 ? 0 : (occupied / total).clamp(0, 1),
            ),
            const SizedBox(height: 8),
            Text(t.guestsTonight(n: dashboard.guestsTonight)),
          ],
        ),
      ),
    );
  }
}

/// Options that expire soon. Those that have expired stand out.
class _Options extends ConsumerWidget {
  const _Options({required this.options, required this.today});

  final List<ExpiringOption> options;
  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.dashboard;
    final theme = Theme.of(context);

    return YaruSection(
      headline: Text(t.options),
      child: options.isEmpty
          ? _Empty(t.noOptions)
          : Column(
              children: [
                for (final option in options)
                  YaruListTile(
                    leading: const Icon(YaruIcons.clock),
                    titleText: option.title,
                    subtitle: option.expiresAt.isBefore(today)
                        ? Text(
                            t.expired(date: _day(context, option.expiresAt)),
                            style: TextStyle(color: theme.colorScheme.error),
                          )
                        : Text(
                            t.expires(date: _day(context, option.expiresAt)),
                          ),
                    onTap: () => _openBooking(context, ref, option.bookingId),
                  ),
              ],
            ),
    );
  }
}

/// Invoices that are not paid in full, with what is still owed.
class _Balances extends ConsumerWidget {
  const _Balances({required this.balances});

  final List<OpenBalance> balances;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.dashboard;

    return YaruSection(
      headline: Text(t.balances),
      child: balances.isEmpty
          ? _Empty(t.noBalances)
          : Column(
              children: [
                for (final balance in balances)
                  InkWell(
                    onTap: () => _openBooking(context, ref, balance.bookingId),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: AmountRow(
                        label: [
                          balance.invoiceNumber,
                          balance.payerName,
                          balance.bookingTitle,
                        ].join(' · '),
                        amount: balance.owed,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

/// Who is in the house today and tomorrow, by age group, with the meal
/// plan of every booking.
class _Catering extends ConsumerWidget {
  const _Catering({required this.days});

  final List<MealDay> days;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final theme = Theme.of(context);

    return YaruSection(
      headline: Text(t.dashboard.catering),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, day) in days.indexed) ...[
            if (index > 0) const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Text(
                '${index == 0 ? t.dashboard.today : t.dashboard.tomorrow} · '
                '${_day(context, day.date)}',
                style: theme.textTheme.titleSmall,
              ),
            ),
            if (day.bookings.isEmpty)
              _Empty(t.dashboard.noGuests)
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  [
                    t.bookings.guestCount(n: day.guestCount),
                    ..._ages(context, day.ageGroups, day.unknownAge),
                  ].join(' · '),
                ),
              ),
              for (final booking in day.bookings)
                YaruListTile(
                  leading: const Icon(Icons.restaurant),
                  titleText: booking.title,
                  subtitleText: [
                    booking.mealPlan ?? t.bookings.noMealPlan,
                    t.bookings.guestCount(n: booking.guestCount),
                    ..._ages(context, booking.ageGroups, booking.unknownAge),
                  ].join(' · '),
                  onTap: () => _openBooking(context, ref, booking.bookingId),
                ),
            ],
          ],
        ],
      ),
    );
  }

  /// The age groups that have guests, like "3 Child", and those of unknown
  /// age at the end.
  List<String> _ages(
    BuildContext context,
    List<AgeGroupCount> ageGroups,
    int unknownAge,
  ) => [
    for (final entry in ageGroups)
      if (entry.count > 0) '${entry.count} ${entry.ageGroup.name}',
    if (unknownAge > 0) '$unknownAge ${context.t.bookings.ageUnknown}',
  ];
}

class _Empty extends StatelessWidget {
  const _Empty(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
