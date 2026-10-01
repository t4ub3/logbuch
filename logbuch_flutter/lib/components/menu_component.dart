import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class MenuComponent extends StatelessWidget {
  const MenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: ListView(
        children: [
          YaruListTile(titleText: 'YaruListTile', onTap: () {}),
          YaruListTile(titleText: 'YaruListTile', onTap: () {}),
          YaruListTile(titleText: 'YaruListTile', onTap: () {}),
        ],
      ),
    );
  }
}
