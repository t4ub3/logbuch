import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_flutter/components/status_bar_component.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/contacts_panel.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:yaru/yaru.dart' show YaruInfoType;

import 'fake_client.dart';

/// What the test lets the app load, when it wants to.
var _answer = Completer<String>();
final _data = FutureProvider.autoDispose<String>((ref) => _answer.future);

/// The status bar below something that loads [_data].
class _Screen extends ConsumerWidget {
  const _Screen({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child:
              child ??
              Column(
                children: [
                  Text(ref.watch(_data).value ?? ''),
                  TextButton(
                    onPressed: () {
                      _answer = Completer();
                      ref.invalidate(_data);
                    },
                    child: const Text('Reload'),
                  ),
                  TextButton(
                    onPressed: () => ref.read(statusProvider.notifier).saved(),
                    child: const Text('Save'),
                  ),
                ],
              ),
        ),
        const StatusBarComponent(),
      ],
    );
  }
}

/// Shows the status bar while [_data] is loaded. The answer has to be made
/// inside the test, which has a clock of its own.
Future<void> _pump(WidgetTester tester, FakeClient client) {
  _answer = Completer();
  return pumpApp(tester, const _Screen(), client, settle: false);
}

/// The color of the part of the status bar that says [text].
Color? _barColor(WidgetTester tester, String text) {
  final bar = tester.widget<AnimatedContainer>(
    find.ancestor(
      of: find.text(text),
      matching: find.byType(AnimatedContainer),
    ),
  );
  return (bar.decoration as BoxDecoration?)?.color;
}

/// What a [YaruInfoBox] of [type] is filled with.
Color _fill(BuildContext context, YaruInfoType type) => Color.alphaBlend(
  type.getColor(context).withValues(alpha: 0.1),
  Theme.of(context).colorScheme.surface,
);

void main() {
  testWidgets('loading shows an animation and then that the data is there', (
    tester,
  ) async {
    await _pump(tester, FakeClient());
    final context = tester.element(find.byType(StatusBarComponent));

    expect(find.text('Loading…'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // In the middle of its part, which ends where the account starts.
    expect(
      tester.getCenter(find.text('Loading…')).dx,
      closeTo(tester.getRect(find.byType(VerticalDivider)).left / 2, 20),
    );
    expect(
      _barColor(tester, 'Loading…'),
      _fill(context, YaruInfoType.information),
    );

    _answer.complete('Rooms');
    await tester.pumpAndSettle();

    expect(find.text('Rooms'), findsOneWidget);
    expect(find.text('Loading…'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Data loaded'), findsOneWidget);
    expect(
      _barColor(tester, 'Data loaded'),
      _fill(context, YaruInfoType.success),
    );

    // It is no news for long.
    await tester.pump(Status.loadedDuration);
    await tester.pumpAndSettle();
    expect(find.text('Data loaded'), findsNothing);
  });

  testWidgets('loading shows for a moment even if the data is there at once', (
    tester,
  ) async {
    await _pump(tester, FakeClient());
    _answer.complete('Rooms');
    await tester.pump(Status.loadedDuration);
    await tester.pumpAndSettle();
    expect(find.text('Data loaded'), findsNothing);

    await tester.tap(find.text('Reload'));
    _answer.complete('Rooms again');
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Rooms again'), findsOneWidget);
    expect(find.text('Loading…'), findsOneWidget);
    expect(find.text('Data loaded'), findsNothing);

    await tester.pump(Status.minLoadingDuration);
    await tester.pumpAndSettle();
    expect(find.text('Loading…'), findsNothing);
    expect(find.text('Data loaded'), findsOneWidget);
  });

  testWidgets('a failure to load stays until data is loaded again', (
    tester,
  ) async {
    await _pump(tester, FakeClient());
    final context = tester.element(find.byType(StatusBarComponent));

    // An error of this kind is not tried again.
    _answer.completeError(StateError('no connection'));
    await tester.pumpAndSettle();

    final message = 'Failed to load: Bad state: no connection';
    expect(find.text(message), findsOneWidget);
    expect(_barColor(tester, message), _fill(context, YaruInfoType.danger));
    await tester.pump(const Duration(minutes: 1));
    expect(find.text(message), findsOneWidget);

    await tester.tap(find.text('Reload'));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text(message), findsNothing);
    expect(find.text('Loading…'), findsOneWidget);

    _answer.complete('Rooms');
    await tester.pumpAndSettle();
    expect(find.text('Data loaded'), findsOneWidget);
  });

  testWidgets('a failure that is tried again shows while loading goes on', (
    tester,
  ) async {
    await _pump(tester, FakeClient());

    _answer.completeError(Exception('timeout'));
    _answer = Completer();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(find.text('Failed to load: Exception: timeout'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // The first new attempt comes after a moment and works.
    _answer.complete('Rooms');
    await tester.pumpAndSettle();

    expect(find.text('Rooms'), findsOneWidget);
    expect(find.text('Data loaded'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('what was saved is not replaced by the data loaded after it', (
    tester,
  ) async {
    await _pump(tester, FakeClient());
    _answer.complete('Rooms');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.tap(find.text('Reload'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    // Saved, and loading again next to it.
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Loading…'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    _answer.complete('Rooms again');
    await tester.pumpAndSettle();
    expect(find.text('Rooms again'), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Data loaded'), findsNothing);

    await tester.pump(Status.doneDuration);
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);
  });

  testWidgets('saving a record is said in the status bar', (tester) async {
    final client = filledClient();
    await pumpApp(
      tester,
      const _Screen(child: ContactsPanel()),
      client,
      locale: AppLocale.de,
    );
    expect(find.text('Daten geladen'), findsOneWidget);

    await tester.tap(find.text('Marie Weber'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Bearbeiten'));
    await tester.pumpAndSettle();
    await tester.enterText(field('Telefon'), '+49 151 1234567');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Speichern'));
    await tester.pumpAndSettle();

    expect(
      client.contact.contacts.firstWhere((c) => c.id == 1).phone,
      '+49 151 1234567',
    );
    expect(find.text('Gespeichert'), findsOneWidget);
  });

  testWidgets('the account is on the right and its menu signs out', (
    tester,
  ) async {
    final client = FakeClient();
    await _pump(tester, client);
    _answer.complete('Rooms');
    await tester.pumpAndSettle();

    final account = find.text('me@example.com');
    expect(tester.getRect(account).right, greaterThan(1100));
    expect(find.text('Sign out'), findsNothing);

    await tester.tap(account);
    await tester.pumpAndSettle();

    // The bar is at the bottom, so the menu opens above it.
    expect(
      tester.getRect(find.text('Sign out')).bottom,
      lessThanOrEqualTo(tester.getRect(find.byType(StatusBarComponent)).top),
    );

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(client.authKeyProvider.signOuts, 1);
    expect(find.text('Sign out'), findsNothing);
  });
}
