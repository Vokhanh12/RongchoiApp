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
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;
    if (index == 3) {
      router.push(location);
    }

    setState(() {
      _currentIndex = index;
      router.go(location);
    });
  }
}
