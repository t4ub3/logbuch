import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin_panel.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/panels/bookings_panel.dart';
import 'package:logbuch_flutter/panels/contacts_panel.dart';
import 'package:logbuch_flutter/panels/dashboard_panel.dart';
import 'package:logbuch_flutter/panels/donations_panel.dart';
import 'package:logbuch_flutter/panels/settings_panel.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:logbuch_flutter/theme/dimmed_accent.dart';
import 'package:yaru/yaru.dart';

enum MenuItem {
  dashboard(DashboardPanel()),
  calendar(BookingsPanel()),
  contacts(ContactsPanel()),
  donations(DonationsPanel()),
  admin(AdminPanel()),
  settings(SettingsPanel());

  const MenuItem(this.panel);

  final Widget panel;

  String title(Translations t) => switch (this) {
    dashboard => t.menu.dashboard,
    calendar => t.menu.calendar,
    contacts => t.menu.contacts,
    donations => t.menu.donations,
    admin => t.menu.admin,
    settings => t.menu.settings,
  };

  IconData icon({required bool selected}) => switch (this) {
    dashboard => selected ? YaruIcons.home_filled : YaruIcons.home,
    calendar => selected ? YaruIcons.calendar_filled : YaruIcons.calendar,
    contacts =>
      selected ? YaruIcons.address_book_filled : YaruIcons.address_book,
    donations => selected ? YaruIcons.star_filled : YaruIcons.star,
    admin => selected ? YaruIcons.wrench_filled : YaruIcons.wrench,
    settings => selected ? YaruIcons.gear_filled : YaruIcons.gear,
  };
}

/// The navigation pane: the menu items, then the open booking tabs, and
/// the settings at the bottom.
class MenuComponent extends ConsumerWidget {
  const MenuComponent({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final MenuItem selected;
  final ValueChanged<MenuItem> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final open = ref.watch(tabsProvider);

    // YaruMasterTile takes its selected colors from the ListTileTheme.
    return ListTileTheme.merge(
      selectedTileColor: colorScheme.dimmedPrimary,
      selectedColor: colorScheme.onSurface,
      child: _buildMenu(context, ref, open),
    );
  }

  Widget _buildMenu(BuildContext context, WidgetRef ref, OpenTabs open) {
    // Menu items are only highlighted while no booking tab is shown.
    final homeSelected = open.tabs[open.selected] is HomeTab;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Log'),
                TextSpan(
                  text: '|',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const TextSpan(text: 'Buch'),
              ],
            ),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontFamily: 'Libron'),
          ),
        ),
        const InsetDivider(),
        Expanded(
          child: ListView(
            children: [
              for (final item in MenuItem.values)
                if (item != MenuItem.settings)
                  _tile(context, item, homeSelected),
              if (open.tabs.length > 1) ...[
                const SizedBox(height: 8),
                const InsetDivider(),
                const SizedBox(height: 8),
              ],
              for (final (index, tab) in open.tabs.indexed)
                if (tab is BookingTab)
                  _BookingTabTile(tab: tab, selected: index == open.selected),
            ],
          ),
        ),
        const InsetDivider(),
        _tile(context, MenuItem.settings, homeSelected),
      ],
    );
  }

  Widget _tile(BuildContext context, MenuItem item, bool homeSelected) {
    final isSelected = homeSelected && item == selected;

    return YaruMasterTile(
      padding: const EdgeInsets.all(8),
      leading: Icon(item.icon(selected: isSelected)),
      title: Text(item.title(context.t)),
      selected: isSelected,
      onTap: () => onSelected(item),
    );
  }
}

/// Menu entry of an open booking, with a button to close it.
class _BookingTabTile extends ConsumerWidget {
  const _BookingTabTile({required this.tab, required this.selected});

  final BookingTab tab;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final booking = tab.booking;
    final tabs = ref.read(tabsProvider.notifier);

    return YaruMasterTile(
      padding: const EdgeInsets.all(8),
      leading: Icon(
        booking?.icon ?? YaruIcons.plus,
        color: booking?.color,
      ),
      title: Text(
        booking?.title ?? t.bookings.newBooking,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        tooltip: t.tabs.close,
        icon: const Icon(YaruIcons.window_close, size: 16),
        visualDensity: VisualDensity.compact,
        onPressed: () => tabs.close(tab),
      ),
      selected: selected,
      onTap: () => tabs.select(tabs.indexOf(tab)),
    );
  }
}
