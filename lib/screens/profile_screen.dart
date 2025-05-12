import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import '../theme/app_theme.dart';
import '../widgets/top_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavbar(title: 'User Profile'),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileSection(),
              const SizedBox(height: 16),
              _buildBottomNavigation(),
              const SizedBox(height: 16),
              _buildEditProfileButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 138,
            height: 138,
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 16),
          // Name and Username
          const Column(
            children: [
              Text(
                'Gian Dolor',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '@giandolor',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF585252),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // College and Year Level
          const Text(
            'Computer Science',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Year Level: 2nd Year',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF585252),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle edit profile button action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryPurple,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.emoji_events, 'Rank'),
          _buildBottomNavItem(Icons.military_tech, 'Award'),
          _buildBottomNavItem(Icons.star, 'Streak'),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryPurple,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.primaryPurple,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
