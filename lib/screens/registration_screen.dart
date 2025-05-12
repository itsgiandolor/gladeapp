import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import '../widgets/custom_dropdown.dart';
import '../database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool areLengthsValid() {
    return emailController.text.length <= 100 && passwordController.text.length <= 50;
  }

  bool isUsernameLengthValid(String username) {
    return username.length >= 1 && username.length <= 10;
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
  if (!isUsernameLengthValid(username)) {
    setState(() => isLoading = false);
    showError('Username must be between 1 and 10 characters.');
    return;
  }

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
    // 1. Register the user with Firebase Auth
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // 2. Store additional user info in Firestore (uid, username, year level, department)
    if (userCredential.user != null) {
      await DatabaseService().addUser(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        yearLevel: selectedYearLevel!,
        department: selectedDepartment!,
      );

      // 3. Initialize the streak for the new user
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'streak': 1, // Initialize streak to 1
        'lastCheckedIn': Timestamp.fromDate(DateTime.now()), // Set the current date
      }, SetOptions(merge: true)); // Merge to avoid overwriting existing data

      // Optionally, update the Firebase Auth user’s display name (for example)
      await userCredential.user!.updateDisplayName(username);

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
              child: const Text('Log In'),
            ),
          ],
        ),
      );
    }
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

  void showSuccessDialog() {
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
                          onSuccess: handleRegister,
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
