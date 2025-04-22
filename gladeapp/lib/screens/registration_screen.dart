import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import '../widgets/custom_dropdown.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Glade!',
                    style: TextStyle(
                      color: AppTheme.primaryPurple,
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 56),
                  const RegisterInputField(placeholder: 'Username'),
                  const SizedBox(height: 20),
                  const RegisterInputField(placeholder: 'Email'),
                  const SizedBox(height: 20),
                  const RegisterInputField(placeholder: 'Password'),
                  const SizedBox(height: 20),
                  YearLevelDropdown(
                    onChanged: (selectedYear) {
                      // You can store this in a state variable later if needed
                      print('Selected Year: $selectedYear');
                    },
                  ),
                  const SizedBox(height: 20),
                  DepartmentDropdown(
                    onChanged: (selectedDepartment) {
                      print('Selected Department: $selectedDepartment');
                    },
                  ),
                  const SizedBox(height: 20),
                  CreateAccountButton(
                    text: 'Create account',
                    onPressed: () {
                      // Handle create account action
                    },
                  ),
                  const SizedBox(height: 52),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: AppTheme.primaryPurple,
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: AppTheme.primaryPurple,
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
