import 'package:flutter/material.dart';

import '../../data/menu_data.dart';
import '../../models/menu_item.dart';

class HomeMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem<MenuItem>(
          value: MenuData.itemSettings,
          child: Row(
            children: [
              Icon(MenuData.itemSettings.icon),
              SizedBox(width: 8),
              Text(MenuData.itemSettings.menuName),
            ],
          ),
        ),
        PopupMenuItem<MenuItem>(
          value: MenuData.itemShare,
          child: Row(
            children: [
              Icon(MenuData.itemShare.icon),
              SizedBox(width: 8),
              Text(MenuData.itemShare.menuName),
            ],
          ),
        ),
      ],
    );
  }
}
