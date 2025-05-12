import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/top_navbar.dart';

class EnableNotificationsScreen extends StatefulWidget {
  const EnableNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<EnableNotificationsScreen> createState() =>
      _EnableNotificationsScreenState();
}

class _EnableNotificationsScreenState extends State<EnableNotificationsScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsTopNavbar(title: 'Enable notifications'),
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440), // Adjusted width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0, // Inner padding
              vertical: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.notifications,
                  size: 92.0,
                  color: AppTheme.primaryPurple,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Push Notifications',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  'Get important updates sent directly to your device.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Enable Notifications',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Switch(
                      value: _notificationsEnabled,
                      activeColor: AppTheme.primaryPurple,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
