import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import '../widgets/custom_dropdown.dart';
import '../database/database_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedYearLevel;
  String? selectedDepartment;
  bool isLoading = false;

  bool areFieldsFilled() {
    return usernameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        selectedYearLevel != null &&
        selectedDepartment != null;
  }

  bool doPasswordsMatch() {
    return passwordController.text == confirmPasswordController.text;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool areLengthsValid() {
    return emailController.text.length <= 100 &&
        passwordController.text.length <= 50;
  }

  Future<void> handleRegister() async {
    if (!areFieldsFilled()) {
      showError('All fields are required.');
      return;
    }

    if (!isValidEmail(emailController.text.trim())) {
      showError('Please enter a valid email address.');
      return;
    }

    if (!doPasswordsMatch()) {
      showError('Passwords do not match.');
      return;
    }

    if (!areLengthsValid()) {
      showError('Email or password is too long.');
      return;
    }

    setState(() => isLoading = true);

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Check if username or email exists (Optional, based on your database setup)
    bool usernameExists = await DatabaseService().isUsernameTaken(username);
    bool emailExists = await DatabaseService().isEmailTaken(email);

    if (usernameExists) {
      setState(() => isLoading = false);
      showError('Username is already taken.');
      return;
    }

    if (emailExists) {
      setState(() => isLoading = false);
      showError('Email is already registered.');
      return;
    }

    try {
      // Register the user with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Optional: Store additional user info in Firestore (username, year level, etc.)
      await DatabaseService().addUser(
        username: username,
        email: email,
        password: password, // Firebase Auth handles the password securely
        yearLevel: selectedYearLevel!,
        department: selectedDepartment!,
      );

      setState(() => isLoading = false);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account created successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      showError(e.message ?? 'An error occurred. Please try again.');
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

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
                  RegisterInputField(
                    label: 'Username',
                    controller: usernameController,
                  ),
                  const SizedBox(height: 20),
                  RegisterInputField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  RegisterInputField(
                    label: 'Password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  RegisterInputField(
                    label: 'Confirm Password',
                    obscureText: true,
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 20),
                  YearLevelDropdown(
                    onChanged: (year) {
                      setState(() {
                        selectedYearLevel = year;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DepartmentDropdown(
                    onChanged: (dept) {
                      setState(() {
                        selectedDepartment = dept;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? const CircularProgressIndicator()
                      : CreateAccountButton(
                          text: 'Create account',
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          onSuccess: () async {
                            if (usernameController.text.trim().isEmpty ||
                                emailController.text.trim().isEmpty ||
                                passwordController.text.trim().isEmpty ||
                                confirmPasswordController.text.trim().isEmpty ||
                                selectedYearLevel == null ||
                                selectedDepartment == null) {
                              // Handle if any field is left empty
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('All fields are required.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            // Check if username or email already exists
                            bool usernameExists = await DatabaseService()
                                .isUsernameTaken(
                                    usernameController.text.trim());
                            bool emailExists = await DatabaseService()
                                .isEmailTaken(emailController.text.trim());

                            if (usernameExists) {
                              // Username already taken
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Username is already taken.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            if (emailExists) {
                              // Email already taken
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Email is already registered.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            // If passwords match, save the user
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Passwords do not match.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            // Save user to Firestore
                            await DatabaseService().addUser(
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              yearLevel: selectedYearLevel!,
                              department: selectedDepartment!,
                            );

                            // Navigate or show success
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Success'),
                                content:
                                    const Text('Account created successfully!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      );
                                    },
                                    child: const Text('Go to Login'),
                                  ),
                                ],
                              ),
                            );
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
                              builder: (context) => const LoginScreen(),
                            ),
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
