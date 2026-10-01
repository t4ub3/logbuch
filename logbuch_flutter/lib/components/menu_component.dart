import 'package:flutter/material.dart';
import 'package:logbuch_flutter/panels/bookings_panel.dart';
import 'package:logbuch_flutter/panels/contacts_panel.dart';
import 'package:logbuch_flutter/panels/rooms_panel.dart';
import 'package:yaru/yaru.dart';

enum MenuItem {
  bookings('Bookings', BookingsPanel()),
  contacts('Contacts', ContactsPanel()),
  rooms('Rooms', RoomsPanel());

  const MenuItem(this.title, this.panel);

  final String title;
  final Widget panel;
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
    return Column(
      children: [
        Placeholder(
          fallbackHeight: 150,
        ),
        Expanded(
          child: ListView(
            children: [
              for (final item in MenuItem.values)
                YaruMasterTile(
                  title: Text(item.title),
                  selected: item == selected,
                  onTap: () => onSelected(item),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
