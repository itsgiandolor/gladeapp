import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginInputField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const LoginInputField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppTheme.primaryPurple,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryPurple,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class RegisterInputField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType; // Add keyboardType parameter

  const RegisterInputField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text, // Default to text input
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType, // Use the keyboardType parameter
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppTheme.primaryPurple,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryPurple,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryPurple,
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.black,
      ),
    );
  }
}

class ChangePasswordInputField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller; // Add this line

  const ChangePasswordInputField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.controller, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Set controller here
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppTheme.primaryPurple,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryPurple,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class ManageEmailInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ManageEmailInputField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppTheme.primaryPurple,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryPurple,
            width: 1,
          ),
        ),
      ),
    );
  }
}
