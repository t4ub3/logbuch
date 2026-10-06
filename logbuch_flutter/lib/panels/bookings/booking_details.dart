import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/open_file.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/bookings/booking_assignment.dart';
import 'package:logbuch_flutter/panels/bookings/booking_billing.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/panels/bookings/booking_form.dart';
import 'package:logbuch_flutter/panels/bookings/booking_guests.dart';
import 'package:logbuch_flutter/panels/bookings/booking_kitchen.dart';
import 'package:logbuch_flutter/panels/bookings/booking_price.dart';
import 'package:logbuch_flutter/panels/bookings/booking_rooms.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// The page of the booking of [tab]: its overview across the top and, below
/// it, a card each for the rooms it holds, its guests and their rooms, what
/// the kitchen needs to know, what it costs and how it is billed. The cards
/// only show the booking; those with something to change open an overlay
/// for it.
class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key, required this.tab});

  final BookingTab tab;

  /// The cards are next to each other in two columns from this width of
  /// the page on.
  static const _twoColumnsWidth = 900.0;

  static const _gap = 16.0;

  @override
  Widget build(BuildContext context) {
    final booking = tab.booking!;
    final cards = <Widget>[
      BookingRoomsCard(tab: tab),
      BookingGuestsCard(bookingId: booking.id!),
      BookingAssignmentCard(booking: booking),
      BookingKitchenCard(booking: booking),
      BookingPriceCard(bookingId: booking.id!),
      BookingBillingCard(bookingId: booking.id!),
    ];

    Widget column(Iterable<Widget> cards) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: _gap,
      children: [...cards],
    );

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: _gap,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 16, color: booking.color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        booking.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
                _OverviewCard(tab: tab),
                // Each column is as high as its cards, so that a long card
                // leaves no gap next to it. Read row by row, the cards are
                // in the same order as in a single column.
                if (constraints.maxWidth >= _twoColumnsWidth)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: _gap,
                    children: [
                      Expanded(
                        child: column([
                          for (final (index, card) in cards.indexed)
                            if (index.isEven) card,
                        ]),
                      ),
                      Expanded(
                        child: column([
                          for (final (index, card) in cards.indexed)
                            if (index.isOdd) card,
                        ]),
                      ),
                    ],
                  )
                else
                  column(cards),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens the confirmation of [booking] as a PDF. The server makes it anew
/// each time, from the booking as it is now.
Future<void> _openConfirmation(
  BuildContext context,
  WidgetRef ref,
  Booking booking,
) async {
  try {
    final pdf = await ref
        .read(serverpodClientProvider)
        .booking
        .getConfirmationPdf(booking.id!);
    await ref.read(fileOpenerProvider)(
      'Buchungsbestaetigung-${booking.id}.pdf',
      // The bytes may be a part of a larger buffer.
      pdf.buffer.asUint8List(pdf.offsetInBytes, pdf.lengthInBytes),
    );
  } catch (error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          validationMessage(context, error) ??
              context.t.bookings.openConfirmationFailed(error: error),
        ),
      ),
    );
  }
}

/// How far the booking of [tab] has come and what was agreed on: its dates,
/// its lead and so on.
class _OverviewCard extends ConsumerWidget {
  const _OverviewCard({required this.tab});

  final BookingTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final booking = tab.booking!;
    final lead = booking.lead;

    return BookingCard(
      title: t.overview,
      actions: [
        if (booking.canBeConfirmed)
          TextButton.icon(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: Text(t.confirmation),
            onPressed: () => _openConfirmation(context, ref, booking),
          ),
      ],
      onEdit: ref.watch(canEditProvider)
          ? () => showBookingOverlay(
              context,
              ref,
              bookingId: booking.id!,
              overlay: BookingOverviewEditor(tab: tab),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StatusProgress(status: booking.status),
          const SizedBox(height: 20),
          _Facts(
            facts: [
              _Fact(
                icon: YaruIcons.calendar,
                label: t.dates,
                text: booking.dateRangeLabel(context) ?? t.noDates,
              ),
              _Fact(
                icon: YaruIcons.user,
                label: t.leadField,
                text: booking.leadName,
              ),
              if (lead?.mail case final mail? when mail.isNotEmpty)
                _Fact(icon: YaruIcons.mail, label: t.email, text: mail),
              if (lead?.phone case final phone? when phone.isNotEmpty)
                _Fact(
                  icon: YaruIcons.call_incoming,
                  label: t.phone,
                  text: phone,
                ),
              if (booking.organization case final organization?)
                _Fact(
                  icon: Icons.apartment,
                  label: t.organization,
                  text: organization.name,
                ),
              if (booking.optionExpiresAt case final expiry?)
                _Fact(
                  icon: YaruIcons.clock,
                  label: t.optionExpiresAt,
                  text: formatDate(context, expiry),
                ),
              if (booking.mealPlan case final mealPlan?)
                _Fact(
                  icon: Icons.restaurant,
                  label: t.mealPlan,
                  text: mealPlan.name,
                ),
              _Fact(
                icon: Icons.receipt_long,
                label: t.billingMode,
                text: booking.billingMode.label(context),
              ),
              if (booking.expectedGuestCount case final guests?)
                _Fact(
                  icon: YaruIcons.users,
                  label: t.expectedGuests,
                  text: '$guests',
                ),
            ],
          ),
          // Notes can be long, so they get the whole width.
          if (booking.notes case final notes?) ...[
            const SizedBox(height: 16),
            _Fact(icon: YaruIcons.document, label: t.notes, text: notes),
          ],
        ],
      ),
    );
  }
}

/// Lays [facts] out in as many columns of the same width as fit.
class _Facts extends StatelessWidget {
  const _Facts({required this.facts});

  final List<_Fact> facts;

  /// A column is at least this wide.
  static const _minWidth = 240.0;

  static const _gap = 24.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = ((constraints.maxWidth + _gap) ~/ (_minWidth + _gap))
            .clamp(1, facts.length);
        // Rounded down, so that the last column does not wrap over a
        // fraction of a pixel.
        final width = ((constraints.maxWidth - (columns - 1) * _gap) / columns)
            .floorToDouble();

        return Wrap(
          spacing: _gap,
          runSpacing: 16,
          children: [
            for (final fact in facts) SizedBox(width: width, child: fact),
          ],
        );
      },
    );
  }
}

/// Something that is known about the booking, with what it is called above
/// it. The [text] can be selected to copy it.
class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.label, required this.text});

  final IconData icon;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 20, color: theme.hintColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall),
              SelectableText(text),
            ],
          ),
        ),
      ],
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
