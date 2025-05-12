import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GetStartedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GetStartedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive dimensions
    double buttonWidth = screenWidth > 991
        ? 173
        : screenWidth > 640
            ? 150
            : 130;

    double buttonHeight = screenWidth > 991
        ? 42
        : screenWidth > 640
            ? 38
            : 34;

    double fontSize = screenWidth > 991
        ? 18
        : screenWidth > 640
            ? 16
            : 14;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30), // Ripple effect radius
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: AppTheme.secondaryPurple,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.buttonTextStyle.copyWith(
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  final String text;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSuccess;

  const CreateAccountButton({
    super.key,
    required this.text,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (passwordController.text != confirmPasswordController.text) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Passwords do not match.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          onSuccess(); // If passwords match, call the success function
        }
      },
      child: Container(
        width: 250,
        height: 29,
        decoration: BoxDecoration(
          color: AppTheme.secondaryPurple,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: AppTheme.white,
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class SubSettingsActionButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const SubSettingsActionButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryPurple,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
