import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../widgets/top_navbar.dart';
import 'settings_screens/change_password.dart';
import 'settings_screens/manage_email.dart';
import 'settings_screens/change_theme.dart';
import 'settings_screens/enable_notifications.dart';
import 'settings_screens/task_reminders.dart';
import 'settings_screens/about_glade.dart';
import 'settings_screens/feedback.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsTopNavbar(title: 'Settings'),
      body: Container(
        color: AppTheme.backgroundColor,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Account and Security',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSettingItem(
                  'Change password',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                    );
                  },
                ),
                _buildSettingItem(
                  'Manage email',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageEmailScreen()),
                    );
                  },
                ),
                _buildDivider(),
                const Padding(
                  padding: EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Appearance',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSettingItem(
                  'Theme',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChangeThemeScreen()),
                    );
                  },
                ),
                _buildDivider(),
                const Padding(
                  padding: EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSettingItem(
                  'Enable notifications',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EnableNotificationsScreen()),
                    );
                  },
                ),
                _buildSettingItem(
                  'Task reminders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TaskReminderScreen()),
                    );
                  },
                ),
                _buildDivider(),
                const Padding(
                  padding: EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'App Info',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSettingItem(
                  'About Glade',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutGladeScreen()),
                    );
                  },
                ),
                _buildSettingItem(
                  'Feedback / Contact Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                    );
                  },
                ),
                _buildDivider(),

                // ✅ Logout with confirmation
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showLogoutConfirmationDialog(context);
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          color: AppTheme.primaryPurple,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 389),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: const Text(
              'Log out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppTheme.white,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(  // Added Expanded to allow the text to take available space
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.black,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const Icon(  // Replace Image.network with Icon for the arrow
              Icons.arrow_forward_ios,  // Arrow icon
              size: 20,  // Adjust size if needed
              color: AppTheme.primaryPurple,  // Set color to match your theme
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDivider() {
    return Container(
      height: 6,
      color: AppTheme.primaryPurple.withOpacity(0.2),
    );
  }
}
