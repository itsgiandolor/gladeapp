import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/top_navbar.dart';
import '../../widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleChangePassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword == confirmPassword && newPassword.isNotEmpty) {
      _showDialog(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: 'Password changed!',
        message: 'Your password was changed.',
      );
    } else {
      _showDialog(
        icon: Icons.error,
        iconColor: Colors.red,
        title: 'Passwords do not match!',
        message: 'Please re-enter.',
      );
    }
  }

  void _showDialog({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 48),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    // Auto-close the dialog after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: AppTheme.backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const SubSettingsTopNavbar(title: 'Change Password'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 360),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: AppTheme.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 7, 20, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChangePasswordInputField(
                                label: 'Current Password',
                                obscureText: true,
                                controller: _currentPasswordController,
                              ),
                              const SizedBox(height: 20),
                              ChangePasswordInputField(
                                label: 'New Password',
                                obscureText: true,
                                controller: _newPasswordController,
                              ),
                              const SizedBox(height: 20),
                              ChangePasswordInputField(
                                label: 'Confirm New Password',
                                obscureText: true,
                                controller: _confirmPasswordController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        SubSettingsActionButton(
                          buttonName: 'Confirm Change',
                          onPressed: _handleChangePassword,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
