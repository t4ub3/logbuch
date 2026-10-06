import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/seasons_section.dart';

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

  group('seasonGaps', () {
    Season season(DateTime from, DateTime to) =>
        Season(name: 'Season', validFrom: from, validTo: to);

    test('finds nothing between seasons that follow each other', () {
      final gaps = seasonGaps([
        season(DateTime.utc(2027, 11, 1), DateTime.utc(2027, 12, 31)),
        season(DateTime.utc(2028, 1, 1), DateTime.utc(2028, 2, 29)),
        season(DateTime.utc(2028, 3, 1), DateTime.utc(2028, 3, 31)),
      ]);

      expect(gaps, isEmpty);
    });

    test('returns the first and last day without a season', () {
      final gaps = seasonGaps([
        season(DateTime.utc(2027, 1, 1), DateTime.utc(2027, 3, 31)),
        season(DateTime.utc(2027, 4, 15), DateTime.utc(2027, 6, 30)),
        season(DateTime.utc(2027, 7, 2), DateTime.utc(2027, 8, 31)),
      ]);

      expect(gaps, [
        (DateTime.utc(2027, 4, 1), DateTime.utc(2027, 4, 14)),
        (DateTime.utc(2027, 7, 1), DateTime.utc(2027, 7, 1)),
      ]);
    });
  });
}
