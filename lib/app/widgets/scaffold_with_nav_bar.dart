import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/utils/constants.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar(
      {super.key,
      required this.child,
      required this.onTap,
      required this.currentIndex});

  final Widget child;
  final Function(int index) onTap;
  final int currentIndex;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  final tabs = Resources.tabs;

  late List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  void initState() {
    bottomNavigationBarItems = []; // Initialize the list here
    tabs.forEach((element) {
      var currentNavBarItem = BottomNavigationBarItem(
        icon: element.icon,
        activeIcon: element.activeIcon,
        label: element.name,
      );

      bottomNavigationBarItems.add(currentNavBarItem);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 14,
        unselectedItemColor: const Color(0xFF838383),
        type: BottomNavigationBarType.fixed,
        onTap: widget.onTap,
        currentIndex: widget.currentIndex,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
