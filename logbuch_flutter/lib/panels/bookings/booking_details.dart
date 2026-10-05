import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// Read-only view of the booking of [tab], with a button to edit it.
class BookingDetails extends ConsumerWidget {
  const BookingDetails({super.key, required this.tab});

  final BookingTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final booking = tab.booking!;
    final lead = booking.lead;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(kYaruPagePadding),
      child: Center(
        child: SizedBox(
          width: 480,
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
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    icon: const Icon(YaruIcons.pen),
                    label: Text(t.edit),
                    onPressed: () => ref
                        .read(tabsProvider.notifier)
                        .update(tab.copyWith(editing: true)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _StatusProgress(status: booking.status),
              const SizedBox(height: 24),
              YaruSection(
                child: Column(
                  children: [
                    YaruListTile(
                      leading: const Icon(YaruIcons.calendar),
                      title: Text(t.dates),
                      subtitle: Text(
                        booking.dateRangeLabel(context) ?? t.noDates,
                      ),
                    ),
                    YaruListTile(
                      leading: const Icon(YaruIcons.user),
                      title: Text(t.leadField),
                      subtitle: Text(booking.leadName),
                    ),
                    if (lead.mail case final mail? when mail.isNotEmpty)
                      YaruListTile(
                        leading: const Icon(YaruIcons.mail),
                        title: Text(t.email),
                        subtitle: SelectableText(mail),
                      ),
                    if (lead.phone case final phone? when phone.isNotEmpty)
                      YaruListTile(
                        leading: const Icon(YaruIcons.call_incoming),
                        title: Text(t.phone),
                        subtitle: SelectableText(phone),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The steps of [BookingStatus] as a segmented bar, filled up to and
/// including the current [status].
class _StatusProgress extends StatelessWidget {
  const _StatusProgress({required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      label: '${context.t.bookings.status}: ${status.label(context)}',
      child: Row(
        children: [
          for (final step in BookingStatus.values) ...[
            if (step != BookingStatus.values.first) const SizedBox(width: 4),
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
