import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/settings_provider.dart';
import 'package:yaru/yaru.dart';

class SettingsPanel extends ConsumerWidget {
  const SettingsPanel({super.key});

  /// Language names are shown in their own language.
  static const _localeNames = {
    AppLocale.en: 'English',
    AppLocale.de: 'Deutsch',
  };

  static const _systemLocale = 'system';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.settings;
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    // Keys the menus by language so their translated labels refresh when the
    // language changes.
    final currentLocale = TranslationProvider.of(context).locale;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(kYaruPagePadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: YaruSection(
            headline: Text(t.title),
            child: Column(
              children: [
                YaruListTile(
                  hasFocusBorder: false,
                  title: Text(t.language),
                  // DropdownMenu entries need a non-null value, so "system
                  // default" is represented by a sentinel instead of null.
                  trailing: DropdownMenu<String>(
                    key: ValueKey(('language', currentLocale)),
                    initialSelection: settings.locale?.name ?? _systemLocale,
                    requestFocusOnTap: false,
                    onSelected: (value) => notifier.setLocale(
                      value == null || value == _systemLocale
                          ? null
                          : AppLocale.values.byName(value),
                    ),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: _systemLocale,
                        label: t.systemLanguage,
                      ),
                      for (final locale in AppLocale.values)
                        DropdownMenuEntry(
                          value: locale.name,
                          label: _localeNames[locale] ?? locale.name,
                        ),
                    ],
                  ),
                ),
                YaruListTile(
                  hasFocusBorder: false,
                  title: Text(t.startOfWeek),
                  trailing: DropdownMenu<StartOfWeek>(
                    key: ValueKey(('startOfWeek', currentLocale)),
                    initialSelection: settings.startOfWeek,
                    requestFocusOnTap: false,
                    onSelected: (value) {
                      if (value != null) notifier.setStartOfWeek(value);
                    },
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: StartOfWeek.monday,
                        label: t.monday,
                      ),
                      DropdownMenuEntry(
                        value: StartOfWeek.sunday,
                        label: t.sunday,
                      ),
                    ],
                  ),
                ),
                YaruListTile(
                  hasFocusBorder: false,
                  title: Text(t.theme),
                  trailing: DropdownMenu<ThemeMode>(
                    key: ValueKey(('theme', currentLocale)),
                    initialSelection: settings.themeMode,
                    requestFocusOnTap: false,
                    onSelected: (value) {
                      if (value != null) notifier.setThemeMode(value);
                    },
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: ThemeMode.system,
                        label: t.systemTheme,
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.light,
                        label: t.light,
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.dark,
                        label: t.dark,
                      ),
                    ],
                  ),
                ),
                YaruListTile(
                  hasFocusBorder: false,
                  title: Text(t.accentColor),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      children: [
                        for (final variant in YaruVariant.accents)
                          YaruColorDisk(
                            onPressed: () => notifier.setVariant(variant),
                            color: variant.color,
                            selected: settings.variant == variant,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
