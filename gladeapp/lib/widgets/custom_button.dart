import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GetStartedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GetStartedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

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
  final VoidCallback onPressed;

  const CreateAccountButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
