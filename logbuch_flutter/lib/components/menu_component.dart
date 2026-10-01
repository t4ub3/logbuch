import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/bookings_panel.dart';
import 'package:logbuch_flutter/panels/contacts_panel.dart';
import 'package:logbuch_flutter/panels/rooms_panel.dart';
import 'package:logbuch_flutter/panels/settings_panel.dart';
import 'package:yaru/yaru.dart';

enum MenuItem {
  bookings(BookingsPanel()),
  contacts(ContactsPanel()),
  rooms(RoomsPanel()),
  settings(SettingsPanel());

  const MenuItem(this.panel);

  final Widget panel;

  String title(Translations t) => switch (this) {
    bookings => t.menu.bookings,
    contacts => t.menu.contacts,
    rooms => t.menu.rooms,
    settings => t.menu.settings,
  };

  IconData icon({required bool selected}) => switch (this) {
    bookings => selected ? YaruIcons.calendar_filled : YaruIcons.calendar,
    contacts =>
      selected ? YaruIcons.address_book_filled : YaruIcons.address_book,
    rooms => selected ? YaruIcons.key_filled : YaruIcons.key,
    settings => selected ? YaruIcons.gear_filled : YaruIcons.gear,
  };
}

class MenuComponent extends StatelessWidget {
  const MenuComponent({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final MenuItem selected;
  final ValueChanged<MenuItem> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // YaruMasterTile takes its selected colors from the ListTileTheme.
    return ListTileTheme.merge(
      selectedTileColor: colorScheme.primary.withValues(alpha: 0.4),
      selectedColor: colorScheme.onSurface,
      child: _buildMenu(context),
    );
  }

  Widget _buildMenu(BuildContext context) {
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
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const InsetDivider(),
        Expanded(
          child: ListView(
            children: [
              for (final item in MenuItem.values)
                if (item != MenuItem.settings) _tile(context, item),
            ],
          ),
        ),
        const InsetDivider(),
        _tile(context, MenuItem.settings),
      ],
    );
  }

  Widget _tile(BuildContext context, MenuItem item) {
    final isSelected = item == selected;

    return YaruMasterTile(
      padding: const EdgeInsets.all(8),
      leading: Icon(item.icon(selected: isSelected)),
      title: Text(item.title(context.t)),
      selected: isSelected,
      onTap: () => onSelected(item),
    );
  }
}
