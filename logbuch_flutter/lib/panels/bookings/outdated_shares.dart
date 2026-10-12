import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/outdated_shares_provider.dart';
import 'package:yaru/yaru.dart';

/// Warns about the invoices that charge a room which the booking shares
/// for another split than the current one: its own, and those of the
/// bookings it shares the room with. An invoice stays as it was written, so
/// what to do about it is up to the user. Shows nothing if there are none.
class OutdatedSharesWarning extends ConsumerWidget {
  const OutdatedSharesWarning({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final shares = ref.watch(outdatedSharesProvider(bookingId)).value ?? [];
    if (shares.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: YaruInfoBox(
        yaruInfoType: YaruInfoType.warning,
        subtitle: Text(
          [
            for (final share in shares)
              share.booking.id == bookingId
                  ? t.bookings.outdatedOwnShare(
                      number: share.invoiceNumber,
                      room: t.rooms.room(number: share.room.roomNumber),
                    )
                  : t.bookings.outdatedOtherShare(
                      booking: share.booking.title,
                      number: share.invoiceNumber,
                      room: t.rooms.room(number: share.room.roomNumber),
                    ),
          ].join('\n'),
        ),
      ),
    );
  }
}
