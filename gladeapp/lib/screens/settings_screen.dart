import 'package:flutter/material.dart';
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
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsTopNavbar(),
      body: Container(
        color: AppTheme.backgroundColor,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
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
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()),
                    );
                  },
                ),
                _buildSettingItem(
                  'Manage email',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageEmailScreen()),
                    );
                  },
                ),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
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
                      MaterialPageRoute(
                          builder: (context) => const ChangeThemeScreen()),
                    );
                  },
                ),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
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
                      MaterialPageRoute(
                          builder: (context) =>
                              const EnableNotificationsScreen()),
                    );
                  },
                ),
                _buildSettingItem(
                  'Task reminders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskReminderScreen()),
                    );
                  },
                ),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      const SizedBox(width: 3),
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
                      MaterialPageRoute(
                          builder: (context) => const AboutGladeScreen()),
                    );
                  },
                ),
                _buildSettingItem(
                  'Feedback / Contact Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackScreen()),
                    );
                  },
                ),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(
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
                const SizedBox(height: 389),
              ],
            ),
          ),
        ),
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
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.black,
                fontFamily: 'Roboto',
              ),
            ),
            Image.network(
              'https://cdn.builder.io/api/v1/image/assets/4be3b29efd7843b4b15f7d36716195c0/7659f0e5e29a7f9e0915e7cd711d165e7ad0e0f8?placeholderIfAbsent=true',
              width: 28,
              height: 28,
              fit: BoxFit.contain,
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
