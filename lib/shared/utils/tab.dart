import 'package:flutter/material.dart';

class Tab {
  final Widget icon;
  final Widget? activeIcon;
  final String name;
  final String initialLocation;

  const Tab(
      {required this.icon,
      required this.activeIcon,
      required this.name,
      required this.initialLocation});
}
