import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/age_groups_section.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/providers/kitchen_overview_provider.dart';
import 'package:yaru/yaru.dart';

/// What the kitchen needs to know about a booking: how many guests there
/// are in every age group, its meal plan, and the dietary needs of the
/// guests. All of it follows from the guests, so there is nothing to edit.
class BookingKitchenCard extends ConsumerWidget {
  const BookingKitchenCard({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BookingCard(
      title: context.t.bookings.kitchen,
      child: switch (ref.watch(kitchenOverviewProvider(booking.id!))) {
        AsyncError(:final error) => CardNote(
          context.t.common.loadFailed(error: error),
        ),
        AsyncValue(value: final overview?) => _Overview(
          overview: overview,
          mealPlan: booking.mealPlan?.name,
        ),
        _ => const CardLoading(),
      },
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.overview, required this.mealPlan});

  final KitchenOverview overview;

  /// The name of the meal plan of the booking, if it has one.
  final String? mealPlan;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.guestsByAge, style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        for (final entry in overview.ageGroups)
          _CountRow(
            label: entry.ageGroup.name,
            detail: entry.ageGroup.rangeLabel(context),
            count: entry.count,
          ),
        // Without an age a guest fits no portion size, so this stands out
        // until it is settled.
        if (overview.unknownAge > 0)
          _CountRow(
            label: t.ageUnknown,
            count: overview.unknownAge,
            style: TextStyle(color: theme.colorScheme.error),
          ),
        const Divider(),
        _CountRow(
          label: t.guestsInTotal,
          count: overview.guestCount,
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        CardRow(label: t.mealPlan, detail: mealPlan ?? t.noMealPlan),
        const SizedBox(height: 12),
        Text(t.dietaryNotes, style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        if (overview.dietaryNeeds.isEmpty)
          CardNote(t.noDietaryNeeds)
        else
          // The need comes first, as that is what gets cooked for.
          for (final need in overview.dietaryNeeds)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(YaruIcons.warning, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(need.notes),
                        Text(
                          [
                            need.guestName,
                            need.groupName,
                            ?need.ageGroupName,
                          ].join(' · '),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

/// A label with a number of guests at the end of the row.
class _CountRow extends StatelessWidget {
  const _CountRow({
    required this.label,
    required this.count,
    this.detail,
    this.style,
  });

  final String label;

  /// Shown small behind the label, such as the ages of an age group.
  final String? detail;
  final int count;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: style),
          if (detail case final detail?) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                detail,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            const Spacer(),
          const SizedBox(width: 12),
          Text('$count', style: style),
        ],
      ),
    );
  }
}
