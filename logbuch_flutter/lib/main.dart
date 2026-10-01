import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';
import 'package:logbuch_flutter/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();

  final container = ProviderContainer(
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
    final variant = ref.watch(settingsProvider.select((s) => s.variant));

    return YaruTheme(
      data: YaruThemeData(variant: variant),
      builder: (context, yaru, child) => MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: const MainScreen(),
      ),
    );
  }
}
