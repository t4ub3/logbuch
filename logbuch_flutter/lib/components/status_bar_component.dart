import 'package:flutter/material.dart';
import 'package:logbuch_flutter/theme/dimmed_accent.dart';

class StatusBarComponent extends StatelessWidget {
  const StatusBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.dimmedPrimary,
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
