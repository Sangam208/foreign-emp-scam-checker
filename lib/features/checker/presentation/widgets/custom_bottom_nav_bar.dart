import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green.shade500,
        unselectedItemColor: Colors.grey.shade700,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.green.shade500),
        unselectedLabelStyle: TextStyle(color: Colors.grey.shade700),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            label: 'Check',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.building),
            label: 'Agency',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userGear),
            label: 'Profile',
          ),
        ],
        onTap: widget.onTap,
      ),
    );
  }
}
