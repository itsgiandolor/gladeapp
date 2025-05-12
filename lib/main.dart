import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- Needed before Firebase init
  await Firebase.initializeApp(); // <-- Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Glade',
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}
