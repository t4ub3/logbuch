import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/components/menu_component.dart';
import 'package:logbuch_flutter/components/status_bar_component.dart';
import 'package:logbuch_flutter/panels/bookings/booking_details.dart';
import 'package:logbuch_flutter/panels/bookings/booking_form.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  MenuItem _selected = MenuItem.dashboard;

  @override
  Widget build(BuildContext context) {
    final open = ref.watch(tabsProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: YaruPanedView(
              pane: MenuComponent(
                selected: _selected,
                onSelected: (item) {
                  setState(() => _selected = item);
                  // Menu items lead back to the home tab.
                  ref.read(tabsProvider.notifier).select(0);
                },
              ),
              // Keeps all tabs alive so their state (e.g. a half filled form)
              // survives switching tabs.
              page: IndexedStack(
                index: open.selected,
                children: [
                  for (final tab in open.tabs)
                    KeyedSubtree(
                      key: tab.key,
                      child: switch (tab) {
                        HomeTab() => _selected.panel,
                        BookingTab(booking: null) => NewBookingForm(tab: tab),
                        BookingTab() => BookingDetails(tab: tab),
                      },
                    ),
                ],
              ),
              layoutDelegate: const YaruResizablePaneDelegate(
                initialPaneSize: 200,
                minPaneSize: 25,
                minPageSize: 50,
                paneSide: YaruPaneSide.start,
              ),
            ),
          ),
          const StatusBarComponent(),
        ],
      ),
    );
  }
}
