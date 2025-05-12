import 'package:flutter/material.dart';
import '../widgets/leaderboard_item.dart';
import '../widgets/top_navbar.dart';
import '../widgets/bottom_navbar.dart';
import '../theme/app_theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> players = [
      {
        'name': 'John Doe',
        'points': '850 pts',
        'rank': '4',
        'icon': Icons.emoji_events_outlined, // Trophy icon
      },
      {
        'name': 'Jane Smith',
        'points': '820 pts',
        'rank': '5',
        'icon': Icons.emoji_events_outlined,
      },
      {
        'name': 'Alice Johnson',
        'points': '800 pts',
        'rank': '6',
        'icon': Icons.emoji_events_outlined,
      },
      {
        'name': 'Michael Brown',
        'points': '770 pts',
        'rank': '7',
        'icon': Icons.emoji_events_outlined,
      },
    ];

    return Scaffold(
      appBar: const TopNavbar(title: 'Leaderboard'),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                // Top 3 Podium
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildTopAvatar('2nd', 50),
                      _buildTopAvatar('1st', 70),
                      _buildTopAvatar('3rd', 50),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Leaderboard List
                Column(
                  children: players
                      .map((player) => LeaderboardItem(
                            name: player['name']!,
                            points: player['points']!,
                            rank: player['rank'].toString(),
                            iconData: player['icon'],
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildTopAvatar(String label, double size) {
    return Column(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: AppTheme.primaryPurple.withOpacity(0.1),
          child: const Icon(
            Icons.person,
            size: 40,
            color: AppTheme.primaryPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryPurple,
          ),
        ),
      ],
    );
  }
}
