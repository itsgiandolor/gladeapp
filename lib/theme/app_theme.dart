import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF512DA8);
  static const Color secondaryPurple = Color(0xFF673AB7);
  static const Color backgroundColor = Color(0xFFEDE7F6);
  static const Color inputBackground = Color(0xFFD9D9D9);
  static const Color togglePurple = Color(0xFF5856D6);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF828282);
}

class AppTextStyle {
  static TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: AppTheme.primaryPurple,
      );

  static TextStyle get subtitleStyle => const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: AppTheme.primaryPurple,
      );

  static TextStyle get buttonTextStyle => const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static const TextStyle welcomeText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppTheme.primaryPurple,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: AppTheme.primaryPurple,
  );

  static const TextStyle streakNumber = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 45,
    fontWeight: FontWeight.w700,
    color: AppTheme.white,
  );

  static const TextStyle streakDescription = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 13,
    color: AppTheme.primaryPurple,
  );

  static const TextStyle actionCardTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppTheme.black,
  );

  static const TextStyle actionCardSubtitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 13,
    color: AppTheme.grey,
  );
  static const TextStyle title = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const TextStyle card = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle label = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle timeText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppTheme.grey,
  );
}

class AppDimensions {
  static const double cardWidth = 352;
  static const double actionCardHeight = 82;
  static const double streakCardHeight = 299;
  static const double appBarHeight = 56;
  static const double horizontalPadding = 20;
}
