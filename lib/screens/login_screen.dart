import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';
import 'registration_screen.dart';
import '../widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false; // To toggle password visibility

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser(String input, String password, BuildContext context) async {
    if (input.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both email/username and password.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      String email = input;

      // If input is not an email, treat as username and look up email in Firestore
      if (!input.contains('@')) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: input)
            .limit(1)
            .get();

        if (snapshot.docs.isEmpty) {
          throw FirebaseAuthException(code: 'user-not-found');
        }

        email = snapshot.docs.first['email'];
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      _showErrorDialog('Unexpected error. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found for that username or email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  void _showErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome back to Glade!',
                  style: TextStyle(
                    color: Color(0xFF512DA8),
                    fontFamily: 'Roboto',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                LoginInputField(
                  label: 'Username or Email',
                  controller: emailOrUsernameController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                LoginInputField(
                  label: 'Password',
                  obscureText: !_passwordVisible,
                  controller: passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: _isLoading
                      ? null
                      : () => _loginUser(
                            emailOrUsernameController.text.trim(),
                            passwordController.text.trim(),
                            context,
                          ),
                  child: Container(
                    width: 250,
                    height: 50, // Increased height for better accessibility
                    decoration: BoxDecoration(
                      color: const Color(0xFF673AB7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)
                          : const Text(
                              'Log in',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16, // Slightly larger font size
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New to Glade?',
                      style: TextStyle(
                        color: Color(0xFF512DA8),
                        fontFamily: 'Roboto',
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create an account',
                        style: TextStyle(
                          color: Color(0xFF512DA8),
                          fontFamily: 'Roboto',
                          fontSize: 15,
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
    );
  }
}
