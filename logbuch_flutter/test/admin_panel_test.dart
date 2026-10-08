import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin_panel.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:yaru/yaru.dart';

import 'fake_client.dart';

Future<void> _pumpAdmin(
  WidgetTester tester,
  FakeClient client, {
  Size size = const Size(1200, 800),
  AppLocale locale = AppLocale.en,
}) => pumpApp(tester, const AdminPanel(), client, size: size, locale: locale);

ElevatedButton _saveButton(WidgetTester tester) =>
    tester.widget(find.widgetWithText(ElevatedButton, 'Save'));

/// Opens a group of the admin panel and, if given, one of its sections.
Future<void> _goTo(WidgetTester tester, String group, [String? section]) async {
  await open(tester, group);
  if (section != null) await open(tester, section);
}

void main() {
  // The groups with their sections. A group opens with its first section,
  // and one with a single section does not name it.
  const groups = {
    'House': ['Buildings', 'Rooms'],
    'Prices': [
      'Unit types',
      'Age groups',
      'Meal plans',
      'Surcharges and fees',
      'Price lists',
    ],
    'Bookings': <String>[],
    'Organisation': ['Operator', 'Users'],
  };

  testWidgets('every section shows its records', (tester) async {
    await _pumpAdmin(tester, filledClient());

    // The panel opens with the rooms.
    expect(find.text('Room 101'), findsOneWidget);
    expect(find.text('4 beds · Standard · Crib possible'), findsOneWidget);
    expect(find.text('Inactive · 1 bed · Comfort · Annex'), findsOneWidget);

    await open(tester, 'Buildings');
    expect(find.text('Annex'), findsOneWidget);
    expect(find.text('1 room'), findsOneWidget);

    await _goTo(tester, 'Prices');
    expect(find.text('Comfort'), findsOneWidget);
    expect(find.text('7 % tax'), findsNWidgets(2));

    await open(tester, 'Age groups');
    expect(find.text('0 to 17 years'), findsOneWidget);
    expect(find.text('18 years and older'), findsOneWidget);

    await open(tester, 'Meal plans');
    expect(find.text('Full board'), findsOneWidget);

    await open(tester, 'Surcharges and fees');
    expect(
      find.text('per person and night · Adult · 7 % tax · every booking'),
      findsOneWidget,
    );

    await open(tester, 'Price lists');
    expect(find.widgetWithText(ChoiceChip, 'Prices 2127'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Prices 2128'), findsOneWidget);
    expect(find.text('from Jan 1, 2127'), findsOneWidget);

    await _goTo(tester, 'Bookings');
    expect(find.text('School'), findsOneWidget);
  });

  testWidgets('a group opens with its first section', (tester) async {
    await _pumpAdmin(tester, filledClient());

    await _goTo(tester, 'Prices');
    expect(find.text('New unit type'), findsOneWidget);

    await _goTo(tester, 'House');
    expect(find.text('New building'), findsOneWidget);

    // A group with one section has nothing to choose from.
    await _goTo(tester, 'Bookings');
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.text('New booking category'), findsOneWidget);
  });

  testWidgets('every section fits a narrow window, with and without records', (
    tester,
  ) async {
    for (final client in [filledClient(), FakeClient()]) {
      await _pumpAdmin(tester, client, size: const Size(420, 600));
      for (final MapEntry(key: group, value: sections) in groups.entries) {
        await _goTo(tester, group);
        expect(tester.takeException(), isNull, reason: group);
        for (final section in sections) {
          await open(tester, section);
          expect(tester.takeException(), isNull, reason: section);
        }
      }
      await tester.pumpWidget(const SizedBox());
    }
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
    await tester.tap(find.text('Unit type'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Comfort').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('No building'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annex').last);
    await tester.pumpAndSettle();
    await tester.enterText(field('Floor'), '1');
    await tester.tap(find.text('A crib can be set up'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final room = client.room.rooms.last;
    expect(room.roomNumber, '103');
    expect(room.bedAmount, 3);
    expect(room.unitTypeId, 2);
    expect(room.buildingId, 1);
    expect(room.floor, '1');
    expect(room.cribPossible, isTrue);
    expect(room.active, isTrue);
    expect(client.room.addedFeeIds, isEmpty);
    // The dialog closed and the list shows the new room.
    expect(find.text('New room'), findsOneWidget);
    expect(find.text('Room 103'), findsOneWidget);
  });

  testWidgets('a room takes the surcharges that are chosen for it', (
    tester,
  ) async {
    final client = filledClient();
    client.fee.fees = [
      ...client.fee.fees,
      Fee(id: 2, name: 'Bathroom', unit: FeeUnit.perPersonNight, rooms: []),
      // Charged per booking, so it cannot be the surcharge of a room.
      Fee(id: 3, name: 'Cleaning', unit: FeeUnit.perBooking, rooms: []),
    ];
    await _pumpAdmin(tester, client);

    await tester.tap(find.text('New room'));
    await tester.pumpAndSettle();
    // Neither the fee of every booking nor the one per booking is offered.
    expect(find.byType(FilterChip), findsOneWidget);

    await tester.enterText(field('Room number'), '103');
    await tester.enterText(field('Beds'), '2');
    await tester.tap(find.text('Unit type'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Standard').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, 'Bathroom'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(client.room.addedFeeIds, [2]);
  });

  testWidgets('a rejected record keeps its dialog open with the reason', (
    tester,
  ) async {
    await _pumpAdmin(tester, filledClient());
    await _goTo(tester, 'Prices', 'Age groups');

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
    await _goTo(tester, 'Prices', 'Unit types');

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

    const forms = [
      ('House', 'Buildings', 'New building'),
      ('House', 'Rooms', 'New room'),
      ('Prices', 'Unit types', 'New unit type'),
      ('Prices', 'Age groups', 'New age group'),
      ('Prices', 'Meal plans', 'New meal plan'),
      ('Prices', 'Surcharges and fees', 'New fee'),
      ('Prices', 'Price lists', 'New price list'),
    ];
    for (final (group, section, form) in forms) {
      await _goTo(tester, group, section);
      await tester.tap(find.text(form));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget, reason: form);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing, reason: form);
    }
  });

  testWidgets('a unit type is saved with its tax rate and whether bookings '
      'share it', (tester) async {
    final client = filledClient();
    await _pumpAdmin(tester, client);
    await _goTo(tester, 'Prices', 'Unit types');

    await tester.tap(find.text('New unit type'));
    await tester.pumpAndSettle();
    // Lodging is taxed at 7 % unless something else is entered.
    expect(find.widgetWithText(TextFormField, '7'), findsOneWidget);
    await tester.enterText(field('Name'), 'Hall');
    await tester.enterText(field('Tax rate'), '19');
    await tester.tap(find.text('Bookings can share it'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final type = client.unitType.types.last;
    expect(type.name, 'Hall');
    expect(type.taxRate, 1900);
    expect(type.shared, isTrue);
    // It goes to the end of the list.
    expect(type.sortOrder, 2);
    expect(find.text('19 % tax · shared'), findsOneWidget);
  });

  testWidgets('a fee is saved with its tax rate in basis points '
      'and the rooms it is a surcharge of', (tester) async {
    final client = filledClient();
    await _pumpAdmin(tester, client);
    await _goTo(tester, 'Prices', 'Surcharges and fees');

    // The existing fee opens with its tax rate. It is charged to every
    // booking, so there are no rooms to choose.
    await tester.tap(find.text('Tourist tax'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, '7'), findsOneWidget);
    expect(find.text('Surcharge of these rooms'), findsNothing);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New fee'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Name'), 'Bed linen');
    await tester.enterText(field('Tax rate'), '19');
    await tester.tap(find.text('per person and night'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('per person, once per stay').last);
    await tester.pumpAndSettle();
    // The rooms come building by building, those without one last.
    expect(find.text('Surcharge of these rooms'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilterChip, '101'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ActionChip, 'Annex'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final fee = client.fee.fees.last;
    expect(fee.name, 'Bed linen');
    expect(fee.taxRate, 1900);
    expect(fee.unit, FeeUnit.perPerson);
    expect(fee.ageGroupId, isNull);
    expect(fee.autoApply, isFalse);
    expect(client.fee.addedRoomIds, unorderedEquals([1, 2]));
    expect(
      find.textContaining('per person, once per stay · 19 % tax'),
      findsOneWidget,
    );
  });

  testWidgets('a fee of every booking is saved without rooms', (tester) async {
    final client = filledClient();
    await _pumpAdmin(tester, client);
    await _goTo(tester, 'Prices', 'Surcharges and fees');

    await tester.tap(find.text('New fee'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Name'), 'Heating');
    await tester.tap(find.widgetWithText(FilterChip, '101'));
    await tester.pump();
    await tester.ensureVisible(find.text('Add to every booking'));
    await tester.tap(find.text('Add to every booking'));
    await tester.pumpAndSettle();
    expect(find.text('Surcharge of these rooms'), findsNothing);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(client.fee.fees.last.autoApply, isTrue);
    expect(client.fee.addedRoomIds, isEmpty);
  });

  testWidgets('amounts follow the German language', (tester) async {
    await _pumpAdmin(tester, filledClient(), locale: AppLocale.de);
    addTearDown(() => LocaleSettings.setLocaleSync(AppLocale.en));

    await _goTo(tester, 'Preise', 'Zuschläge und Gebühren');
    expect(
      find.textContaining('pro Person und Nacht · Adult · 7 % Steuer'),
      findsOneWidget,
    );

    await open(tester, 'Preislisten');
    final adultStandard = tester.widget<TextField>(
      find.byType(TextField).at(1),
    );
    expect(adultStandard.controller!.text, '25,00');
  });

  group('price lists', () {
    // The fields of the selected list, row by row. Lodging: Standard and
    // Comfort, each for children, for adults, as a whole and for day use.
    // Meals: full board for children and for adults. Fees: the tourist tax.
    Finder cell(int index) => find.byType(TextField).at(index);
    const fullBoardAdult = 9;
    const touristTax = 10;

    String text(WidgetTester tester, int index) =>
        tester.widget<TextField>(cell(index)).controller!.text;

    Future<void> openLists(WidgetTester tester, FakeClient client) async {
      await _pumpAdmin(tester, client);
      await _goTo(tester, 'Prices', 'Price lists');
    }

    testWidgets('show the stored prices of the selected list', (tester) async {
      await openLists(tester, filledClient());

      expect(find.byType(TextField), findsNWidgets(11));
      expect(text(tester, 0), '');
      expect(text(tester, 1), '25.00');
      expect(text(tester, touristTax), '2.00');
      // The fee says how it is charged.
      expect(find.text('per person and night'), findsOneWidget);
      expect(_saveButton(tester).onPressed, isNull);

      await tester.tap(find.text('Prices 2128'));
      await tester.pumpAndSettle();

      expect(text(tester, 1), '');
      expect(find.text('from Jan 1, 2128'), findsOneWidget);
    });

    testWidgets('are saved as cents, leaving out the empty fields', (
      tester,
    ) async {
      final client = filledClient();
      await openLists(tester, client);

      await tester.enterText(cell(0), '12,5');
      await tester.enterText(cell(1), '');
      // Standard as a whole per night, Comfort for day use.
      await tester.enterText(cell(2), '90');
      await tester.enterText(cell(7), '120');
      await tester.enterText(cell(fullBoardAdult), '18');
      await tester.enterText(cell(touristTax), '');
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      final saved = client.priceList.prices[1]!;
      expect(
        {
          for (final rate in saved.roomRates)
            (rate.unitTypeId, rate.ageGroupId): rate.pricePerNight,
        },
        {(1, 1): 1250},
      );
      expect(
        {
          for (final price in saved.unitPrices)
            price.unitTypeId: (price.pricePerNight, price.dayUsePrice),
        },
        {1: (9000, null), 2: (null, 12000)},
      );
      expect(
        {
          for (final rate in saved.mealRates)
            (rate.mealPlanId, rate.ageGroupId): rate.pricePerNight,
        },
        {(1, 2): 1800},
      );
      expect(saved.feePrices, isEmpty);
      expect(
        statusMessage(tester),
        isA<Done>().having((done) => done.text, 'text', 'Prices saved'),
      );
      // The prices were loaded again and there is nothing left to save.
      expect(text(tester, 0), '12.50');
      expect(_saveButton(tester).onPressed, isNull);
    });

    testWidgets('cannot be saved while a field is not an amount', (
      tester,
    ) async {
      await openLists(tester, filledClient());

      await tester.enterText(cell(0), '12 euros');
      await tester.pump();

      expect(find.text('Enter amounts such as 12.50.'), findsOneWidget);
      expect(_saveButton(tester).onPressed, isNull);
    });

    testWidgets('keep their list until changes are saved or discarded', (
      tester,
    ) async {
      await openLists(tester, filledClient());

      ChoiceChip other() =>
          tester.widget(find.widgetWithText(ChoiceChip, 'Prices 2128'));
      ElevatedButton add() =>
          tester.widget(find.widgetWithText(ElevatedButton, 'New price list'));

      await tester.enterText(cell(1), '26');
      await tester.pump();
      expect(other().onSelected, isNull);
      expect(add().onPressed, isNull);

      await tester.tap(find.text('Discard'));
      await tester.pump();

      expect(text(tester, 1), '25.00');
      expect(other().onSelected, isNotNull);
      expect(add().onPressed, isNotNull);
    });

    testWidgets('need a name and a first day', (tester) async {
      final client = filledClient();
      await openLists(tester, client);
      // The prices below the dialog have a button to save them as well.
      final saveInDialog = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.widgetWithText(ElevatedButton, 'Save'),
      );

      await tester.tap(find.text('New price list'));
      await tester.pumpAndSettle();
      await tester.tap(saveInDialog);
      await tester.pumpAndSettle();
      expect(find.text('Required'), findsNWidgets(2));

      await tester.enterText(field('Name'), 'Prices 2129');
      await tester.tap(find.text('Valid from'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('15'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(saveInDialog);
      await tester.pumpAndSettle();

      final added = client.priceList.lists.firstWhere(
        (list) => list.name == 'Prices 2129',
      );
      // The day travels as a date without a time.
      expect(added.validFrom.isUtc, isTrue);
      expect(added.validFrom.day, 15);
      // The new list is the one that is shown.
      final chip = tester.widget<ChoiceChip>(
        find.widgetWithText(ChoiceChip, 'Prices 2129'),
      );
      expect(chip.selected, isTrue);
    });

    testWidgets('open with their name and first day', (tester) async {
      await openLists(tester, filledClient());

      await tester.tap(find.byTooltip('Edit'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextFormField, 'Prices 2127'), findsOneWidget);
      expect(find.text('Jan 1, 2127'), findsOneWidget);
    });

    testWidgets('say how to begin while there are none', (tester) async {
      await openLists(tester, FakeClient());

      expect(find.textContaining('No price lists yet.'), findsOneWidget);
      expect(find.text('New price list'), findsOneWidget);
    });

    testWidgets('need something to price', (tester) async {
      final client = FakeClient();
      client.priceList.lists = [
        PriceList(id: 1, name: 'Prices', validFrom: DateTime.utc(2026)),
      ];
      await openLists(tester, client);

      expect(
        find.textContaining('Create unit types, age groups, meal plans'),
        findsOneWidget,
      );
    });
  });

  testWidgets('a booking category is changed under Admin', (tester) async {
    final client = filledClient();
    await _pumpAdmin(tester, client);
    await _goTo(tester, 'Bookings');

    expect(find.text('School'), findsOneWidget);
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Name'), 'Schools');
    await tester.tap(find.byIcon(YaruIcons.book));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    final category = client.bookingCategory.categories.single;
    expect(category.name, 'Schools');
    expect(category.icon, BookingCategoryIcon.book);
    expect(category.color, BookingCategoryColor.blue);
    expect(find.text('Schools'), findsOneWidget);
  });
}
