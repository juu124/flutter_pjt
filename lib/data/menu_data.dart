import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuData {
  static final List<MenuItem> menuItems = [
    itemSettings, itemShare
  ];

  static final itemSettings = MenuItem(
      menuName: 'Settings',
      icon: Icons.settings,
  );
  static final itemShare = MenuItem(
    menuName: 'Share',
    icon: Icons.share,
  );
}