import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/menu_component.dart';
import 'package:logbuch_flutter/components/status_bar_component.dart';
import 'package:yaru/yaru.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pane = Container(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.025),
      child: const Center(child: Text('pane')),
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuComponent(),
                Expanded(
                  child: YaruPanedView(
                    pane: pane,
                    page: const Center(child: Text('YaruPanedView Inception')),
                    layoutDelegate: const YaruResizablePaneDelegate(
                      initialPaneSize: 200,
                      minPaneSize: 25,
                      minPageSize: 25,
                      paneSide: YaruPaneSide.right,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StatusBarComponent(),
        ],
      ),
    );
  }
}
