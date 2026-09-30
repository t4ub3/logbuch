import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/yaru.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pane = Container(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.025),
      child: const Center(child: Text('pane')),
    );

    return YaruPanedView(
      pane: pane,
      page: YaruPanedView(
        pane: pane,
        page: YaruPanedView(
          pane: pane,
          page: YaruPanedView(
            pane: pane,
            page: const Center(child: Text('YaruPanedView Inception')),
            layoutDelegate: const YaruResizablePaneDelegate(
              initialPaneSize: 200,
              minPaneSize: 25,
              minPageSize: 25,
              paneSide: YaruPaneSide.bottom,
            ),
          ),
          layoutDelegate: const YaruResizablePaneDelegate(
            initialPaneSize: 200,
            minPaneSize: 25,
            minPageSize: 25,
            paneSide: YaruPaneSide.end,
          ),
        ),
        layoutDelegate: const YaruResizablePaneDelegate(
          initialPaneSize: 200,
          minPaneSize: 25,
          minPageSize: 50,
          paneSide: YaruPaneSide.top,
        ),
      ),
      layoutDelegate: const YaruResizablePaneDelegate(
        initialPaneSize: 200,
        minPaneSize: 25,
        minPageSize: 50,
        paneSide: YaruPaneSide.start,
      ),
    );
  }
}
