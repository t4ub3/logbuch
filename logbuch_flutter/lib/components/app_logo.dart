import 'package:flutter/material.dart';

/// The name of the app as its logo: "Log|Buch" in the Libron font, with the
/// bar in the accent color.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.style, this.barColor});

  /// The text style the logo is drawn in, headlineMedium if not given.
  final TextStyle? style;

  /// The color of the bar, the accent color if not given.
  final Color? barColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Log'),
          TextSpan(
            text: '|',
            style: TextStyle(color: barColor ?? theme.colorScheme.primary),
          ),
          const TextSpan(text: 'Buch'),
        ],
      ),
      style: (style ?? theme.textTheme.headlineMedium)?.copyWith(
        fontFamily: 'Libron',
      ),
    );
  }
}
