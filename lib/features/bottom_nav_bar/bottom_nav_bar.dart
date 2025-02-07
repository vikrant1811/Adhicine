import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.grey.shade300,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      items: List.generate(2, (index) {
        return BottomNavigationBarItem(
          icon: Icon(
            _getIconForIndex(index),
            size: 30,
            color: currentIndex == index ? Colors.blueAccent : Colors.grey,
          ),
          label: _getLabelForIndex(index),
        );
      }),
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  // Function to get the correct icon for each index
  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.assessment;
      default:
        return Icons.home_rounded;
    }
  }

  // Function to get labels for each index
  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Report';
      default:
        return 'Home';
    }
  }
}
