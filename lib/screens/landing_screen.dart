import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double logoWidth = MediaQuery.of(context).size.width * 0.4;  // Adjust width as needed
    double logoHeight = MediaQuery.of(context).size.height * 0.2;  // Adjust height as needed
    double verticalSpacing = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_nobg.png',
                width: logoWidth,
                height: logoHeight,
              ),
              SizedBox(height: verticalSpacing),
              Text(
                'Glade',
                style: AppTextStyle.titleStyle,
              ),
              SizedBox(height: verticalSpacing),
              Text(
                'Track. Progress. Achieve.',
                style: AppTextStyle.subtitleStyle,
              ),
              SizedBox(height: verticalSpacing * 2),
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
