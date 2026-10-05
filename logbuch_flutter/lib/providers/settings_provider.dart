import 'package:flutter/material.dart' show ThemeMode;
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaru/yaru.dart';

part 'settings_provider.g.dart';

enum StartOfWeek {
  monday,
  sunday;

  /// Index as used by `MaterialLocalizations.firstDayOfWeekIndex`
  /// (0 = Sunday).
  int get firstDayOfWeekIndex => switch (this) {
    monday => 1,
    sunday => 0,
  };
}

class AppSettings {
  const AppSettings({
    required this.locale,
    required this.startOfWeek,
    required this.themeMode,
    required this.variant,
  });

  /// The app language, or null to follow the device.
  final AppLocale? locale;
  final StartOfWeek startOfWeek;
  final ThemeMode themeMode;
  final YaruVariant variant;

  AppSettings copyWith({
    AppLocale? Function()? locale,
    StartOfWeek? startOfWeek,
    ThemeMode? themeMode,
    YaruVariant? variant,
  }) {
    return AppSettings(
      locale: locale != null ? locale() : this.locale,
      startOfWeek: startOfWeek ?? this.startOfWeek,
      themeMode: themeMode ?? this.themeMode,
      variant: variant ?? this.variant,
    );
  }
}

/// Must be overridden with an initialized instance at startup.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError();

/// User settings, persisted in [SharedPreferences].
@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  static const _localeKey = 'settings.locale';
  static const _startOfWeekKey = 'settings.startOfWeek';
  static const _themeModeKey = 'settings.themeMode';
  static const _variantKey = 'settings.variant';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettings build() {
    final settings = AppSettings(
      locale: _byName(AppLocale.values, _prefs.getString(_localeKey)),
      startOfWeek:
          _byName(StartOfWeek.values, _prefs.getString(_startOfWeekKey)) ??
          StartOfWeek.monday,
      themeMode:
          _byName(ThemeMode.values, _prefs.getString(_themeModeKey)) ??
          ThemeMode.system,
      variant:
          _byName(YaruVariant.values, _prefs.getString(_variantKey)) ??
          YaruVariant.orange,
    );
    _applyLocale(settings.locale);
    return settings;
  }

  Future<void> setLocale(AppLocale? locale) async {
    state = state.copyWith(locale: () => locale);
    _applyLocale(locale);
    if (locale == null) {
      await _prefs.remove(_localeKey);
    } else {
      await _prefs.setString(_localeKey, locale.name);
    }
  }

  Future<void> setStartOfWeek(StartOfWeek startOfWeek) async {
    state = state.copyWith(startOfWeek: startOfWeek);
    await _prefs.setString(_startOfWeekKey, startOfWeek.name);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _prefs.setString(_themeModeKey, themeMode.name);
  }

  Future<void> setVariant(YaruVariant variant) async {
    state = state.copyWith(variant: variant);
    await _prefs.setString(_variantKey, variant.name);
  }

  void _applyLocale(AppLocale? locale) {
    if (locale == null) {
      LocaleSettings.useDeviceLocaleSync();
    } else {
      LocaleSettings.setLocaleSync(locale);
    }
  }

  static T? _byName<T extends Enum>(List<T> values, String? name) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
