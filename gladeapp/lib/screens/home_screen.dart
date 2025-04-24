import 'package:flutter/material.dart';
import '../widgets/top_navbar.dart';
import '../widgets/nonreusable_widgets.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const HomeScreenTopNavbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Welcome back, User!',
                style: AppTextStyle.welcomeText,
              ),
              const SizedBox(height: 20),
              const Center(child: DailyStreakCard()),
              const SizedBox(height: 20),
              ActionCard(
                title: 'Tasks',
                subtitle: 'You have 3 pending tasks!',
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryPurple.withOpacity(0.5),
                  ),
                  child: const Icon(
                    Icons.assignment,
                    color: AppTheme.primaryPurple,
                    size: 24,
                  ),
                ),
              ),
              ActionCard(
                title: 'Leaderboard',
                subtitle: 'You ranked #5 last week!',
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryPurple.withOpacity(0.5),
                  ),
                  child: const Icon(
                    Icons.leaderboard,
                    color: AppTheme.primaryPurple,
                    size: 24,
                  ),
                ),
              ),
              ActionCard(
                title: 'Achievements',
                subtitle: 'You earned 3 new badges!',
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryPurple.withOpacity(0.5),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: AppTheme.primaryPurple,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
          currentIndex: 0), // Pass index 0 for HomeScreen
    );
  }
}
