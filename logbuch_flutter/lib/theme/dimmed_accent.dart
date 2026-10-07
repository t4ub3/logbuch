import 'package:flutter/material.dart';

/// The accent color of the app, which the theme is built around.
const accentColor = Color(0xFF697391);

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
}
