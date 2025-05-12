import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
              const SizedBox(height: 5),
              Text(
                'Glade',
                style: AppTextStyle.titleStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Track. Progress. Achieve.',
                style: AppTextStyle.subtitleStyle,
              ),
              const SizedBox(height: 40),
              GetStartedButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
