import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logbuch_flutter/components/app_logo.dart';
import 'package:logbuch_flutter/screens/sign_in_screen.dart';
import 'package:yaru/yaru.dart';

Future<void> _pump(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      theme: yaruLight,
      home: const SignInLayout(
        form: SizedBox(key: Key('form'), width: 300, height: 400),
      ),
    ),
  );
}

void main() {
  testWidgets('puts the logo on the accent color next to the form', (
    tester,
  ) async {
    await _pump(tester, const Size(1200, 800));

    final logo = tester.getRect(find.byType(AppLogo));
    final form = tester.getRect(find.byKey(const Key('form')));
    expect(logo.center.dx, 300);
    expect(form.center.dx, 900);
    expect(form.center.dy, 400);
    final side = tester.widget<Container>(
      find.ancestor(of: find.byType(AppLogo), matching: find.byType(Container)),
    );
    expect(side.color, yaruLight.colorScheme.primary);
  });

  testWidgets('puts the logo above the form in a narrow window', (
    tester,
  ) async {
    await _pump(tester, const Size(500, 800));

    final logo = tester.getRect(find.byType(AppLogo));
    final form = tester.getRect(find.byKey(const Key('form')));
    expect(logo.center.dx, 250);
    expect(logo.bottom, lessThan(form.top));
    expect(tester.takeException(), isNull);
  });
}
