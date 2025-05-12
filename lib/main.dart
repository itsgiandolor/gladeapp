import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart'; // Make sure this import matches your file structure
import 'screens/home_screen.dart';  // Add any other screens with named routes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glade',
      debugShowCheckedModeBanner: false,
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),     // You need this for logout
        '/home': (context) => const HomeScreen(),       // Optional, for your dashboard
        // Add more routes here if needed
      },
    );
  }
}
