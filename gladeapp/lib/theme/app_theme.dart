import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF512DA8);
  static const Color secondaryPurple = Color(0xFF673AB7);
  static const Color backgroundColor = Color(0xFFEDE7F6);

  static TextStyle get titleStyle => const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: primaryPurple,
  );

  static TextStyle get subtitleStyle => titleStyle.copyWith(fontSize: 18);

  static TextStyle get buttonTextStyle => const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 991) {
      return baseSize;
    } else if (screenWidth > 640) {
      return baseSize * 0.833; // Approximately 40/48 for medium screens
    } else {
      return baseSize * 0.667; // Approximately 32/48 for small screens
    }
  }
}
