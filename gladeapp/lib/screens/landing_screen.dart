import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/f0b54afcf688c3e1fbe6256a37a5d988c73e29bf?placeholderIfAbsent=true',
                width: 124,
                height: 118,
              ),
              const SizedBox(height: 30),
              Text(
                'Glade',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: AppTheme.getResponsiveFontSize(context, 48),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Track. Progress. Achieve.',
                style: AppTheme.subtitleStyle.copyWith(
                  fontSize: AppTheme.getResponsiveFontSize(context, 18),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  // Handle button press
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
