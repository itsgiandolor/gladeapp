import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginInputField extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  const LoginInputField({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 48, // Consistent height with dropdowns
      decoration: BoxDecoration(
        color: AppTheme.inputBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 13,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w200,
          ),
        ),
        style: const TextStyle(
          color: AppTheme.black,
          fontSize: 13,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}

class RegisterInputField extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  const RegisterInputField({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 48, // Consistent height with dropdowns
      decoration: BoxDecoration(
        color: AppTheme.inputBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 13,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w200,
          ),
        ),
        style: const TextStyle(
          color: AppTheme.black,
          fontSize: 13,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}
