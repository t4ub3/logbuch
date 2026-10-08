import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/booking_price_provider.dart';
import 'package:logbuch_flutter/providers/crowded_rooms_provider.dart';
import 'package:logbuch_flutter/providers/folios_provider.dart';
import 'package:logbuch_flutter/providers/guest_groups_provider.dart';
import 'package:logbuch_flutter/providers/kitchen_overview_provider.dart';
import 'package:yaru/yaru.dart';

/// A part of a booking on its page, such as its rooms: a section with a [title]
/// that shows the part without letting it be changed. [onEdit] adds the
/// button that opens the overlay to change it.
class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.title,
    required this.child,
    this.onEdit,
    this.actions = const [],
  });

  final String title;
  final Widget child;

  /// Null if there is nothing to change, or the user may not change data.
  final VoidCallback? onEdit;

  /// Shown in front of the edit button, such as a button for a document.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final onEdit = this.onEdit;

    return YaruSection(
      // As high as a button, so that the titles of cards with and without
      // one line up.
      headline: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: kYaruButtonHeight),
        child: Row(
          children: [
            Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
            for (final action in actions) ...[
              const SizedBox(width: 8),
              // The headline is larger than the text of a button.
              DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.labelLarge,
                child: action,
              ),
            ],
            if (onEdit != null) ...[
              const SizedBox(width: 8),
              Tooltip(
                message: context.t.common.edit,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.square(kYaruButtonHeight),
                    maximumSize: const Size.square(kYaruButtonHeight),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: onEdit,
                  child: const Icon(YaruIcons.pen, size: 18),
                ),
              ),
            ],
          ],
        ),
      ),
      // In line with the headline, and as wide as the card.
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: child,
      ),
    );
  }
}

/// A line of a card that says that there is nothing to show, or why.
class CardNote extends StatelessWidget {
  const CardNote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}

/// Stands in for what a card shows while that is loaded.
class CardLoading extends StatelessWidget {
  const CardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

/// A line of a card with a [label] and, at its end, a [detail] about it.
class CardRow extends StatelessWidget {
  const CardRow({
    super.key,
    required this.label,
    this.detail,
    this.warn = false,
  });

  final String label;
  final String? detail;

  /// Makes the detail stand out as something that needs to be settled.
  final bool warn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            // The label takes what it needs, but leaves room for the
            // detail, which gets the rest and wraps if it has to.
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6),
              child: Text(label),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                detail ?? '',
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: warn ? theme.colorScheme.error : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// An overlay on the page of a booking in which a part of it is changed.
/// Without [actions] it only has a button to close it, which suits content
/// that saves every change at once.
class BookingOverlay extends StatelessWidget {
  const BookingOverlay({
    super.key,
    required this.title,
    required this.child,
    this.width = 640,
    this.height = 680,
    this.actions,
  });

  final String title;
  final Widget child;

  /// How large the overlay is where the window has room for it.
  final double width;
  final double height;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width, maxHeight: height),
        // A scaffold of its own, in which [showBookingOverlay] shows the
        // messages about what went wrong.
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style:
                      DialogTheme.of(context).titleTextStyle ??
                      theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Expanded(child: child),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children:
                      actions ??
                      [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(context.t.common.close),
                        ),
                      ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows [overlay], in which a part of the booking with the id [bookingId]
/// is changed. Once it closes, what the cards of the booking show is loaded
/// again, as a change to one part reaches others: a guest who moves to
/// another room changes the price, and with it what is billed.
Future<void> showBookingOverlay(
  BuildContext context,
  WidgetRef ref, {
  required int bookingId,
  required Widget overlay,
}) async {
  await showDialog<void>(
    context: context,
    // Snack bars of the overlay go to its own scaffold. Those of the page
    // would show dimmed behind the overlay.
    builder: (context) => ScaffoldMessenger(child: overlay),
  );
  if (!context.mounted) return;
  ref.invalidate(guestGroupsProvider(bookingId));
  ref.invalidate(kitchenOverviewProvider(bookingId));
  ref.invalidate(bookingPriceProvider(bookingId));
  ref.invalidate(crowdedRoomsProvider(bookingId));
  ref.invalidate(foliosProvider(bookingId));
}
