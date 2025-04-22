import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for formatting the date
import '../theme/app_theme.dart';
import '../screens/settings_screen.dart';

class HomeScreenTopNavbar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeScreenTopNavbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryPurple,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            'https://cdn.builder.io/api/v1/image/assets/TEMP/168fa193664f1ad06fa3f98a92da45621909efe6?placeholderIfAbsent=true',
            width: 48,
            height: 45,
          ),
          Text(
            'Glade',
            style: AppTextStyle.appBarTitle,
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SettingsScreen()), // Clears everything before HomeScreen
              );
            },
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }
}

class SettingsTopNavbar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsTopNavbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryPurple,
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(
          color: AppTheme.white), // Optional: shows back button
      title: const Text(
        'Settings',
        style: TextStyle(
          fontSize: 20,
          color: AppTheme.white,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}

class TasksTopNavbar extends StatelessWidget implements PreferredSizeWidget {
  const TasksTopNavbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('EEEE, MMMM d, y').format(DateTime.now());

    return AppBar(
      backgroundColor: AppTheme.primaryPurple,
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: AppTheme.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Tasks',
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
          Text(
            formattedDate,
            style: const TextStyle(
              color: AppTheme.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
