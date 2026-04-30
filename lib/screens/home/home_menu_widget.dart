import 'package:flutter/material.dart';

import '../../data/menu_data.dart';
import '../../models/menu_item.dart';
import '../../routes/app_routes.dart';

class HomeMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem<MenuItem>(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.settings);
          },
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
          onTap: () {
            // 앱 공유 다이얼로그 표시
            // 카카오톡, 메세지로 text 전달 하는 기능
          },
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
