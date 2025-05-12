import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/task_screen.dart';
import '../screens/leaderboard_screen.dart';
import '../screens/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex; // Pass the selected index

  const BottomNavigation({super.key, required this.currentIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void _onItemTapped(int index) {
    // Use Navigator.pushReplacement to navigate to the corresponding screen
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
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
