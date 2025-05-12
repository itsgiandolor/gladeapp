import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/settings_screen.dart';

class TopNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Add a title parameter to the class

  // Constructor now takes a 'title' argument
  const TopNavbar({super.key, required this.title});

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
          // Use Image.asset to load the image from assets
          Image.asset(
            'assets/glade_logo.png', // Ensure this path is correct
            width: 48,
            height: 45,
            fit: BoxFit.contain,
          ),
          Text(
            title, // Use the dynamic title here
            style: const TextStyle(
              color: AppTheme.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
  final String title;

  const SettingsTopNavbar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryPurple,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: AppTheme.white),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.white,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
      elevation: 0,
    );
  }
}
