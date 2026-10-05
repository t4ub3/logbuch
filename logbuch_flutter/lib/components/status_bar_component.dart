import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:logbuch_flutter/theme/dimmed_accent.dart';
import 'package:yaru/yaru.dart';

/// Shows the open tabs of the main screen.
class StatusBarComponent extends ConsumerStatefulWidget {
  const StatusBarComponent({super.key});

  @override
  ConsumerState<StatusBarComponent> createState() => _StatusBarComponentState();
}

class _StatusBarComponentState extends ConsumerState<StatusBarComponent>
    with TickerProviderStateMixin {
  static const _maxTabWidth = 220.0;

  late TabController _controller = _createController(ref.read(tabsProvider));

  TabController _createController(OpenTabs open) => TabController(
    length: open.tabs.length,
    initialIndex: open.selected,
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final open = ref.watch(tabsProvider);
    _syncController(open);

    return Container(
      color: colorScheme.dimmedPrimary,
      child: LayoutBuilder(
        // Tabs share the available width, but don't grow wider than
        // [_maxTabWidth] each.
        builder: (context, constraints) => Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: min(
              constraints.maxWidth,
              open.tabs.length * _maxTabWidth,
            ),
            child: YaruTabBar(
              tabController: _controller,
              onTap: ref.read(tabsProvider.notifier).select,
              tabs: [for (final tab in open.tabs) _TabLabel(tab: tab)],
            ),
          ),
        ),
      ),
    );
  }

  /// A [TabController] has a fixed length, so it is replaced whenever tabs
  /// are opened or closed.
  void _syncController(OpenTabs open) {
    if (_controller.length != open.tabs.length) {
      final old = _controller;
      _controller = _createController(open);
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    } else if (_controller.index != open.selected) {
      _controller.animateTo(open.selected);
    }
  }
}

class _TabLabel extends ConsumerWidget {
  const _TabLabel({required this.tab});

  final AppTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final (icon, label) = switch (tab) {
      HomeTab() => (YaruIcons.home, t.tabs.home),
      BookingTab(:final booking) => (
        YaruIcons.calendar,
        booking?.title ?? t.bookings.newBooking,
      ),
    };

    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
          if (tab is! HomeTab) ...[
            const SizedBox(width: 4),
            IconButton(
              tooltip: t.tabs.close,
              icon: const Icon(YaruIcons.window_close, size: 16),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 24, height: 24),
              onPressed: () => ref.read(tabsProvider.notifier).close(tab),
            ),
          ],
        ],
      ),
    );
  }
}
