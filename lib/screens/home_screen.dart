import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/top_navbar.dart';
import '../widgets/nonreusable_widgets.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'User'; // Default until fetched

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists && doc.data()!.containsKey('username')) {
          setState(() {
            username = doc['username'];
          });
        }
      }
    } catch (e) {
      print('Failed to fetch username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const TopNavbar(title: 'Glade'),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Welcome back, $username!',
                        style: AppTextStyle.welcomeText,
                      ),
                      const SizedBox(height: 20),
                      const Center(child: DailyStreakCard()),
                      const SizedBox(height: 20),
                      ActionCard(
                        title: 'Tasks',
                        subtitle: 'You have 3 pending tasks!',
                        icon: buildIcon(Icons.assignment),
                      ),
                      ActionCard(
                        title: 'Leaderboard',
                        subtitle: 'You ranked #5 last week!',
                        icon: buildIcon(Icons.leaderboard),
                      ),
                      ActionCard(
                        title: 'Achievements',
                        subtitle: 'You earned 3 new badges!',
                        icon: buildIcon(Icons.emoji_events),
                      ),
                      const SizedBox(height: 40), // Give breathing room at the bottom
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),


      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }

  Widget buildIcon(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.primaryPurple.withOpacity(0.5),
      ),
      child: Icon(
        iconData,
        color: AppTheme.primaryPurple,
        size: 24,
      ),
    );
  }
}
