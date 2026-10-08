import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/price_lists_section.dart';
import 'package:logbuch_flutter/panels/admin/rooms_section.dart';

void main() {
  group('parseHundredths', () {
    test('reads comma and dot as the decimal separator', () {
      expect(parseHundredths('12,50'), 1250);
      expect(parseHundredths('12.50'), 1250);
    });

    test('fills up missing decimals', () {
      expect(parseHundredths('12'), 1200);
      expect(parseHundredths('12,5'), 1250);
      expect(parseHundredths('0,05'), 5);
      expect(parseHundredths(' 7 '), 700);
    });

    test('rejects everything that is not a plain amount', () {
      expect(parseHundredths(''), isNull);
      expect(parseHundredths('abc'), isNull);
      expect(parseHundredths('-5'), isNull);
      expect(parseHundredths('12,345'), isNull);
      expect(parseHundredths('1.234,00'), isNull);
      expect(parseHundredths('12,'), isNull);
    });
  });

  group('currentPriceList', () {
    final lists = [
      PriceList(id: 1, name: '2026', validFrom: DateTime.utc(2026)),
      PriceList(id: 2, name: '2027', validFrom: DateTime.utc(2027)),
      PriceList(id: 3, name: '2028', validFrom: DateTime.utc(2028)),
    ];

    test('is the last list that has begun, from its first day on', () {
      expect(currentPriceList(lists, DateTime.utc(2026, 12, 31)).name, '2026');
      expect(currentPriceList(lists, DateTime.utc(2027)).name, '2027');
      expect(currentPriceList(lists, DateTime.utc(2031, 5, 1)).name, '2028');
    });

    test('is the first list while none has begun', () {
      expect(currentPriceList(lists, DateTime.utc(2025, 6, 1)).name, '2026');
    });
  });

  test('compareByBuilding orders rooms by building, then by number', () {
    final main = Building(id: 1, name: 'Main house', sortOrder: 0);
    final annex = Building(id: 2, name: 'Annex', sortOrder: 1);
    Room room(String number, [Building? building]) => Room(
      roomNumber: number,
      bedAmount: 2,
      unitTypeId: 1,
      buildingId: building?.id,
      building: building,
    );

    final rooms = [
      room('Shed'),
      room('A2', annex),
      room('102', main),
      room('A1', annex),
      room('101', main),
    ]..sort(compareByBuilding);

    expect(rooms.map((room) => room.roomNumber), [
      '101',
      '102',
      'A1',
      'A2',
      'Shed',
    ]);
  });
}
