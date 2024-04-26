import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/utils/constants.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar(
      {super.key, required this.child, required this.onTap});

  final Widget child;
  final Function(int index) onTap;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  final tabs = Resources.tabs;

  late List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  void initState() {
    bottomNavigationBarItems = []; // Initialize the list here
    tabs.forEach((element) {
      var currentNavBarItem = BottomNavigationBarItem(
        icon: Icon(Icons.home),
        activeIcon: Icon(Icons.home),
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
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: widget.onTap,
        currentIndex: _currentIndex,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
