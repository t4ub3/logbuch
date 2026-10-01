import 'package:flutter/material.dart';

class StatusBarComponent extends StatelessWidget {
  const StatusBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // A subtle tint of the accent color, kept opaque.
      color: Color.alphaBlend(
        colorScheme.primary.withValues(alpha: 0.4),
        colorScheme.surface,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "status bar",
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
