import 'package:logbuch_server/src/billing/outdated_shares.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

DateTime _october(int day) => DateTime.utc(2026, 10, day);

/// What an invoice charges for the nights of room [hold] from [from] to
/// [to], split between [sharers] bookings.
Charge _charge(int? hold, int from, int to, {int? sharers, int price = 5000}) =>
    Charge(
      folioId: 1,
      bookingRoomId: hold,
      sharers: sharers,
      type: ChargeType.lodging,
      description: 'Hall',
      quantity: to - from,
      unitPrice: price,
      total: price * (to - from),
      taxRate: 700,
      periodFrom: _october(from),
      periodTo: _october(to),
    );

/// The same as a line of what the booking costs now.
ChargeLine _line(int hold, int from, int to, {int? sharers, int? guest}) =>
    ChargeLine(
      guestId: guest,
      bookingRoomId: hold,
      sharers: sharers,
      type: ChargeType.lodging,
      description: 'Hall',
      quantity: to - from,
      unitPrice: 5000,
      total: 5000 * (to - from),
      taxRate: 700,
      periodFrom: _october(from),
      periodTo: _october(to),
    );

void main() {
  group('Given an invoice for a room that bookings share', () {
    test('when the room is shared as it was then nothing is outdated', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 14), _charge(1, 14, 16, sharers: 2)],
          current: [_line(1, 12, 14), _line(1, 14, 16, sharers: 2)],
        ),
        isEmpty,
      );
    });

    test('when another booking joined since then the room is outdated', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 16)],
          current: [_line(1, 12, 14), _line(1, 14, 16, sharers: 2)],
        ),
        {1},
      );
    });

    test('when the other booking left since then the room is outdated', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 16, sharers: 2)],
          current: [_line(1, 12, 16)],
        ),
        {1},
      );
    });

    test('when a third booking joined then the room is outdated', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 16, sharers: 2)],
          current: [_line(1, 12, 16, sharers: 3)],
        ),
        {1},
      );
    });

    test('when only the price changed then nothing is outdated', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 16, sharers: 2, price: 2000)],
          current: [_line(1, 12, 16, sharers: 2)],
        ),
        isEmpty,
      );
    });

    test('when the charge was split between payers '
        'then its parts count as one', () {
      expect(
        outdatedHolds(
          invoiced: [
            _charge(1, 12, 16, sharers: 2, price: 1200),
            _charge(1, 12, 16, sharers: 2, price: 800),
          ],
          current: [_line(1, 12, 16, sharers: 2)],
        ),
        isEmpty,
      );
    });
  });

  group('Given an invoice for rooms that are not shared', () {
    test('when the nights changed then nothing is outdated', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 16)],
          current: [_line(1, 12, 18)],
        ),
        isEmpty,
      );
    });

    test('when a room was taken or given up since '
        'then nothing is outdated', () {
      expect(
        outdatedHolds(
          // The second room was given up, the third was invoiced before
          // charges knew their room.
          invoiced: [
            _charge(1, 12, 16),
            _charge(2, 12, 16, sharers: 2),
            _charge(null, 12, 16),
          ],
          current: [_line(1, 12, 16), _line(4, 12, 16, sharers: 2)],
        ),
        isEmpty,
      );
    });

    test('when guests pay for the room then they are left out', () {
      expect(
        outdatedHolds(
          invoiced: [_charge(1, 12, 16)],
          current: [
            _line(1, 12, 16),
            _line(1, 12, 14, guest: 7, sharers: 2),
          ],
        ),
        isEmpty,
      );
    });
  });
}
