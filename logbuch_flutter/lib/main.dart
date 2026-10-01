import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/client.dart';
import 'package:logbuch_flutter/screens/main_screen.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) => MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        home: const MainScreen(),
      ),
    );
  }
}
