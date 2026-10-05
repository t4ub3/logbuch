import 'package:flutter/material.dart';

extension DimmedAccent on ColorScheme {
  /// An opaque, subdued version of [primary] for large highlighted areas
  /// such as the status bar or the selected menu item.
  ///
  /// In light mode the accent is mixed with white, which washes it out. In
  /// dark mode mixing with the dark surface would keep it vibrant, so its
  /// saturation and lightness are lowered instead.
  Color get dimmedPrimary {
    if (brightness == Brightness.light) {
      return Color.lerp(Colors.white, primary, 0.4)!;
    }
    final hsl = HSLColor.fromColor(primary);
    return hsl
        .withSaturation(hsl.saturation * 0.45)
        .withLightness(0.27)
        .toColor();
  }
}
