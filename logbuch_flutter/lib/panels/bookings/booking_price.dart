import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/bookings/amount_row.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/bookings/booking_guests.dart';
import 'package:logbuch_flutter/providers/booking_price_provider.dart';
import 'package:logbuch_flutter/providers/guest_groups_provider.dart';
import 'package:yaru/yaru.dart';

extension ChargeTypeX on ChargeType {
  String label(BuildContext context) {
    final t = context.t.bookings.chargeTypes;
    return switch (this) {
      ChargeType.lodging => t.lodging,
      ChargeType.meal => t.meal,
      ChargeType.fee => t.fee,
      ChargeType.discount => t.discount,
      ChargeType.manual => t.manual,
    };
  }
}

/// What the booking costs by the current rates, guest by guest, and what
/// keeps parts of it from being priced. The price is worked out from the
/// booking, so there is nothing to edit.
class BookingPriceCard extends ConsumerWidget {
  const BookingPriceCard({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(guestGroupsProvider(bookingId)).value ?? [];
    final names = {
      for (final group in groups)
        for (final guest in group.guests ?? <Guest>[]) guest.id: guest.name,
    };

    return BookingCard(
      title: context.t.bookings.price,
      child: switch (ref.watch(bookingPriceProvider(bookingId))) {
        AsyncError(:final error) => CardNote(
          context.t.common.loadFailed(error: error),
        ),
        AsyncValue(value: final price?) => _Price(price: price, names: names),
        _ => const CardLoading(),
      },
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.price, required this.names});

  final BookingPrice price;

  /// The names of the guests by their id.
  final Map<int?, String> names;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    // The lines of each guest, in the order the guests first appear. Lines
    // without a guest belong to the booking and come last.
    final byGuest = <int?, List<ChargeLine>>{};
    for (final line in price.lines.where((line) => line.guestId != null)) {
      byGuest.putIfAbsent(line.guestId, () => []).add(line);
    }
    final ofBooking = [
      for (final line in price.lines)
        if (line.guestId == null) line,
    ];
    if (ofBooking.isNotEmpty) byGuest[null] = ofBooking;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (price.problems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: YaruInfoBox(
              yaruInfoType: YaruInfoType.warning,
              subtitle: Text(
                [
                  for (final problem in price.problems)
                    _problem(context, problem),
                ].join('\n'),
              ),
            ),
          ),
        if (price.lines.isEmpty) CardNote(t.nothingToPrice),
        for (final MapEntry(key: guestId, value: lines) in byGuest.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: [
                AmountRow(
                  label: guestId == null
                      ? t.wholeBooking
                      : names[guestId] ?? '',
                  amount: lines.fold(0, (sum, line) => sum + line.total),
                  style: theme.textTheme.titleSmall,
                ),
                for (final line in lines)
                  AmountRow(
                    label: '${line.type.label(context)} · ${line.description}',
                    detail:
                        '${line.quantity} × '
                        '${formatMoney(context, line.unitPrice)}',
                    amount: line.total,
                    style: theme.textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
        if (price.lines.isNotEmpty) ...[
          const Divider(),
          AmountRow(
            label: t.total,
            amount: price.total,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          CardNote(t.inclTax),
        ],
      ],
    );
  }

  String _problem(BuildContext context, PricingProblem problem) {
    final t = context.t.bookings.pricingProblems;
    final name = names[problem.guestId] ?? '';
    final detail = problem.detail ?? '';
    return switch (problem.reason) {
      PricingProblemReason.datesMissing => t.datesMissing,
      PricingProblemReason.ageUnknown => t.ageUnknown(name: name),
      PricingProblemReason.roomMissing => t.roomMissing(name: name),
      // The night comes as a date like 2027-09-01.
      PricingProblemReason.priceListMissing => t.priceListMissing(
        date: switch (DateTime.tryParse('${detail}T00:00:00Z')) {
          final night? => formatDate(context, night),
          null => detail,
        },
      ),
      PricingProblemReason.roomRateMissing => t.roomRateMissing(detail: detail),
      PricingProblemReason.mealRateMissing => t.mealRateMissing(detail: detail),
      PricingProblemReason.dayUsePriceMissing => t.dayUsePriceMissing(
        detail: detail,
      ),
    };
  }
}
