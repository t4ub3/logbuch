import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/menu_component.dart';
import 'package:logbuch_flutter/components/status_bar_component.dart';
import 'package:yaru/yaru.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MenuItem _selected = MenuItem.bookings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: YaruPanedView(
              pane: MenuComponent(
                selected: _selected,
                onSelected: (item) => setState(() => _selected = item),
              ),
              page: _selected.panel,
              layoutDelegate: const YaruResizablePaneDelegate(
                initialPaneSize: 200,
                minPaneSize: 25,
                minPageSize: 50,
                paneSide: YaruPaneSide.start,
              ),
            ),
          ),
          StatusBarComponent(),
        ],
      ),
    );
  }
}
