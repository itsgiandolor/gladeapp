import 'package:flutter/material.dart';

// Import your screens
import '../screens/home_screen.dart';
import '../screens/task_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex; // Pass the selected index

  const BottomNavigation({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void _onItemTapped(int index) {
    // Use Navigator.pushReplacement to navigate to the corresponding screen
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskScreen()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    final containerHeight = isSmallScreen ? 48.0 : 56.0;

    final items = [
      Icons.home_outlined,
      Icons.note_outlined,
      Icons.emoji_events_outlined,
      Icons.bar_chart_outlined,
      Icons.person_outline,
    ];

    return Container(
      width: double.infinity,
      height: containerHeight,
      decoration: const BoxDecoration(
        color: Color(0xFF512DA8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          return _buildIcon(index, items[index], iconSize);
        }),
      ),
    );
  }

  Widget _buildIcon(int index, IconData icon, double size) {
    final isSelected = widget.currentIndex == index; // Use the passed index

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Icon(
        icon,
        size: size,
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
      ),
    );
  }
}
