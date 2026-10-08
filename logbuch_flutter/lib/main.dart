import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:logbuch_flutter/screens/main_screen.dart';
import 'package:logbuch_flutter/screens/role_gate.dart';
import 'package:logbuch_flutter/screens/sign_in_screen.dart';
import 'package:logbuch_flutter/theme/dimmed_accent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();

  final container = ProviderContainer(
    observers: [StatusObserver()],
    overrides: [
      sharedPreferencesProvider.overrideWithValue(
        await SharedPreferences.getInstance(),
      ),
    ],
  );
  // Load the settings before the first frame so the stored locale is applied.
  container.read(settingsProvider);

  runApp(
    TranslationProvider(
      child: UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));

    return MaterialApp(
      title: "Log|Buch",
      debugShowCheckedModeBanner: false,
      theme: createYaruLightTheme(primaryColor: accentColor),
      darkTheme: createYaruDarkTheme(primaryColor: accentColor),
      themeMode: themeMode,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const SignInScreen(child: RoleGate(child: MainScreen())),
    );
  }
}
