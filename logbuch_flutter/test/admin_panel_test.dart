import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin_panel.dart';

import 'fake_client.dart';

Future<void> _pumpAdmin(
  WidgetTester tester,
  FakeClient client, {
  Size size = const Size(1200, 800),
  AppLocale locale = AppLocale.en,
}) => pumpApp(tester, const AdminPanel(), client, size: size, locale: locale);

ElevatedButton _saveButton(WidgetTester tester) =>
    tester.widget(find.widgetWithText(ElevatedButton, 'Save'));

void main() {
  const sections = [
    'Rooms',
    'Price categories',
    'Age groups',
    'Seasons',
    'Meal plans',
    'Prices',
    'Fees',
    'Operator',
    'Users',
  ];

  testWidgets('every section shows its records', (tester) async {
    await _pumpAdmin(tester, filledClient());

    expect(find.text('Room 101'), findsOneWidget);
    expect(find.text('4 beds · Standard · Crib possible'), findsOneWidget);
    expect(find.text('Inactive · 1 bed · Comfort · Annex'), findsOneWidget);

    await open(tester, 'Price categories');
    expect(find.text('Comfort'), findsOneWidget);

    await open(tester, 'Age groups');
    expect(find.text('0 to 17 years'), findsOneWidget);
    expect(find.text('18 years and older'), findsOneWidget);

    await open(tester, 'Seasons');
    expect(find.text('Mar 1, 2027 – May 31, 2027'), findsOneWidget);

    await open(tester, 'Meal plans');
    expect(find.text('Full board'), findsOneWidget);

    await open(tester, 'Fees');
    expect(
      find.text(
        '€2.00 per person and night · Adult · 7 % tax · every booking',
      ),
      findsOneWidget,
    );
  });

  testWidgets('every section fits a narrow window, with and without records', (
    tester,
  ) async {
    for (final client in [filledClient(), FakeClient()]) {
      await _pumpAdmin(tester, client, size: const Size(420, 600));
      for (final section in sections) {
        await open(tester, section);
        expect(tester.takeException(), isNull, reason: section);
      }
      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('seasons warn about the days no season covers', (tester) async {
    await _pumpAdmin(tester, filledClient());
    await open(tester, 'Seasons');

    expect(
      find.textContaining('No season covers Jun 1, 2027 – Aug 31, 2027.'),
      findsOneWidget,
    );
  });

  testWidgets('a new room is only saved once the form is complete', (
    tester,
  ) async {
    final client = filledClient();
    await _pumpAdmin(tester, client);

    await tester.tap(find.text('New room'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Required'), findsNWidgets(3));
    expect(client.room.rooms, hasLength(2));

    await tester.enterText(field('Room number'), ' 103 ');
    await tester.enterText(field('Beds'), '3');
    await tester.tap(find.text('Price category'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Comfort').last);
    await tester.pumpAndSettle();
    await tester.enterText(field('Floor'), '1');
    await tester.tap(find.text('A crib can be set up'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final room = client.room.rooms.last;
    expect(room.roomNumber, '103');
    expect(room.bedAmount, 3);
    expect(room.priceCategoryId, 2);
    expect(room.floor, '1');
    expect(room.building, isNull);
    expect(room.cribPossible, isTrue);
    expect(room.active, isTrue);
    // The dialog closed and the list shows the new room.
    expect(find.text('New room'), findsOneWidget);
    expect(find.text('Room 103'), findsOneWidget);
  });

  testWidgets('a rejected record keeps its dialog open with the reason', (
    tester,
  ) async {
    await _pumpAdmin(tester, filledClient());
    await open(tester, 'Age groups');

    await tester.tap(find.text('New age group'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Name'), 'Teen');
    await tester.enterText(field('From age'), '12');
    await tester.enterText(field('To age'), '17');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(
      find.text('The ages overlap with the age group “Child”.'),
      findsOneWidget,
    );
    expect(field('Name'), findsOneWidget);
  });

  testWidgets('a record that is in use stays and says why', (tester) async {
    await _pumpAdmin(tester, filledClient());
    await open(tester, 'Price categories');

    await tester.tap(find.byTooltip('Delete').first);
    await tester.pumpAndSettle();
    expect(find.text('Delete “Standard”?'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(
      find.text('This entry is still in use and cannot be deleted.'),
      findsOneWidget,
    );
    expect(find.text('Standard'), findsOneWidget);
  });

  testWidgets('every form opens empty and can be cancelled', (tester) async {
    await _pumpAdmin(tester, filledClient());

    const forms = {
      'Rooms': 'New room',
      'Price categories': 'New price category',
      'Age groups': 'New age group',
      'Seasons': 'New season',
      'Meal plans': 'New meal plan',
      'Fees': 'New fee',
    };
    for (final MapEntry(key: section, value: form) in forms.entries) {
      await open(tester, section);
      await tester.tap(find.text(form));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget, reason: form);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing, reason: form);
    }
  });

  testWidgets('a season needs a name and a period', (tester) async {
    await _pumpAdmin(tester, filledClient());
    await open(tester, 'Seasons');

    await tester.tap(find.text('New season'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsNWidgets(2));
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // An existing season opens with its period.
    await tester.tap(find.text('Spring'));
    await tester.pumpAndSettle();
    expect(find.text('Mar 1, 2027 – May 31, 2027'), findsNWidgets(2));
  });

  testWidgets('a fee is saved in cents and basis points', (tester) async {
    final client = filledClient();
    await _pumpAdmin(tester, client);
    await open(tester, 'Fees');

    // The existing fee opens with its amount and tax rate.
    await tester.tap(find.text('Tourist tax'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, '2.00'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '7'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New fee'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Name'), 'Bed linen');
    await tester.enterText(field('Amount'), '8,5');
    await tester.enterText(field('Tax rate'), '19');
    await tester.tap(find.text('per person and night'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('per person').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final fee = client.fee.fees.last;
    expect(fee.name, 'Bed linen');
    expect(fee.amount, 850);
    expect(fee.taxRate, 1900);
    expect(fee.unit, FeeUnit.perPerson);
    expect(fee.ageGroupId, isNull);
    expect(fee.autoApply, isFalse);
    expect(find.text('€8.50 per person · 19 % tax'), findsOneWidget);
  });

  testWidgets('amounts and dates follow the German language', (tester) async {
    await _pumpAdmin(tester, filledClient(), locale: AppLocale.de);
    addTearDown(() => LocaleSettings.setLocaleSync(AppLocale.en));

    await open(tester, 'Gebühren');
    expect(
      find.textContaining('2,00 € pro Person und Nacht · Adult · 7 % Steuer'),
      findsOneWidget,
    );

    await open(tester, 'Saisons');
    expect(find.text('1. März 2027 – 31. Mai 2027'), findsOneWidget);

    await open(tester, 'Preise');
    final adultStandard = tester.widget<TextField>(
      find.byType(TextField).at(1),
    );
    expect(adultStandard.controller!.text, '25,00');
  });

  group('prices', () {
    // The fields of the matrix, row by row: Standard and Comfort, each for
    // children and adults.
    Finder cell(int index) => find.byType(TextField).at(index);

    testWidgets('show the stored prices of the selected season', (
      tester,
    ) async {
      await _pumpAdmin(tester, filledClient());
      await open(tester, 'Prices');

      expect(find.byType(TextField), findsNWidgets(4));
      expect(tester.widget<TextField>(cell(0)).controller!.text, '');
      expect(tester.widget<TextField>(cell(1)).controller!.text, '25.00');
      expect(_saveButton(tester).onPressed, isNull);

      await tester.tap(find.text('Autumn'));
      await tester.pumpAndSettle();

      expect(tester.widget<TextField>(cell(1)).controller!.text, '');
    });

    testWidgets('are saved as cents, leaving out the empty fields', (
      tester,
    ) async {
      final client = filledClient();
      await _pumpAdmin(tester, client);
      await open(tester, 'Prices');

      await tester.enterText(cell(0), '12,5');
      await tester.enterText(cell(1), '');
      await tester.enterText(cell(3), '31');
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      final saved = {
        for (final rate in client.roomRate.bySeason[1]!)
          (rate.priceCategoryId, rate.ageGroupId): rate.pricePerNight,
      };
      expect(saved, {(1, 1): 1250, (2, 2): 3100});
      expect(find.text('Prices saved'), findsOneWidget);
      // The matrix was loaded again and has nothing left to save.
      expect(tester.widget<TextField>(cell(0)).controller!.text, '12.50');
      expect(_saveButton(tester).onPressed, isNull);
    });

    testWidgets('cannot be saved while a field is not an amount', (
      tester,
    ) async {
      await _pumpAdmin(tester, filledClient());
      await open(tester, 'Prices');

      await tester.enterText(cell(0), '12 euros');
      await tester.pump();

      expect(find.text('Enter amounts such as 12.50.'), findsOneWidget);
      expect(_saveButton(tester).onPressed, isNull);
    });

    testWidgets('keep their season until changes are saved or discarded', (
      tester,
    ) async {
      await _pumpAdmin(tester, filledClient());
      await open(tester, 'Prices');

      ChoiceChip autumn() =>
          tester.widget(find.widgetWithText(ChoiceChip, 'Autumn'));

      await tester.enterText(cell(1), '26');
      await tester.pump();
      expect(autumn().onSelected, isNull);

      await tester.tap(find.text('Discard'));
      await tester.pump();

      expect(tester.widget<TextField>(cell(1)).controller!.text, '25.00');
      expect(autumn().onSelected, isNotNull);
    });

    testWidgets('need seasons, age groups and price categories first', (
      tester,
    ) async {
      await _pumpAdmin(tester, FakeClient());
      await open(tester, 'Prices');

      expect(
        find.text(
          'Prices need at least one season, one age group and one price '
          'category.',
        ),
        findsOneWidget,
      );
    });
  });
}
