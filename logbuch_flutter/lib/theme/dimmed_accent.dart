import 'package:flutter/material.dart';

/// The accent color of the app, which the theme is built around.
const accentColor = Color(0xFF5A6790);

/// The subdued version of [accentColor].
const dimmedAccentColor = Color(0xFFACB2C3);

extension DimmedAccent on ColorScheme {
  /// An opaque, subdued version of [primary] for large highlighted areas
  /// such as the status bar or the selected menu item.
  ///
  /// In light mode this is [dimmedAccentColor]. Light text could not be
  /// read on that, so in dark mode the saturation and lightness of the
  /// accent are lowered instead.
  Color get dimmedPrimary {
    if (brightness == Brightness.light) return dimmedAccentColor;
    final hsl = HSLColor.fromColor(primary);
    return hsl
        .withSaturation(hsl.saturation * 0.45)
        .withLightness(0.27)
        .toColor();
  }

  /// A subdued version of any [color], for areas that carry a color of
  /// their own, such as the bars of bookings in the calendars. It is as
  /// much paler than [color] as [dimmedPrimary] is than [primary], and
  /// text in [onSurface] can be read on it.
  Color dimmed(Color color) {
    final hsl = HSLColor.fromColor(color);
    final dimmed = brightness == Brightness.light
        ? hsl.withSaturation(hsl.saturation * 0.7).withLightness(0.72)
        : hsl.withSaturation(hsl.saturation * 0.45).withLightness(0.27);
    return dimmed.toColor();
  }
}
