import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Booking endpoint', (sessionBuilder, endpoints) {
    final lead = Contact(firstName: 'Ada', lastName: 'Lovelace');

    test('when adding a booking then it can be fetched by id', () async {
      final added = await endpoints.booking.add(
        sessionBuilder,
        Booking(
          title: 'Summer camp',
          from: DateTime.utc(2026, 7, 1),
          to: DateTime.utc(2026, 7, 5),
          lead: lead,
        ),
      );

      final fetched = await endpoints.booking.getById(
        sessionBuilder,
        added.id!,
      );
      expect(fetched?.title, 'Summer camp');
      expect(fetched?.lead.lastName, 'Lovelace');
    });

    test('when adding a booking then its status is requested', () async {
      final added = await endpoints.booking.add(
        sessionBuilder,
        Booking(title: 'New', lead: lead),
      );

      final fetched = await endpoints.booking.getById(
        sessionBuilder,
        added.id!,
      );
      expect(fetched?.status, BookingStatus.requested);
    });

    test('when updating a booking then the changes are stored', () async {
      final added = await endpoints.booking.add(
        sessionBuilder,
        Booking(title: 'Draft', from: DateTime.utc(2026, 7, 1), lead: lead),
      );

      await endpoints.booking.update(
        sessionBuilder,
        added.copyWith(
          title: 'Final',
          from: null,
          lead: Contact(firstName: 'Alan', lastName: 'Turing'),
        ),
      );

      final fetched = await endpoints.booking.getById(
        sessionBuilder,
        added.id!,
      );
      expect(fetched?.title, 'Final');
      expect(fetched?.from, isNull);
      expect(fetched?.lead.lastName, 'Turing');
    });
  });
}
