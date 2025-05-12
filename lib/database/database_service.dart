import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add user to Firestore
  Future<void> addUser({
    required String username,
    required String email,
    required String password,
    required String yearLevel,
    required String department,
  }) async {
    try {
      // Create a new user document in Firestore
      await _db.collection('users').add({
        'username': username,
        'email': email,
        'password': password,
        'yearLevel': yearLevel,
        'department': department,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Register the user with Firebase Authentication
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // Check if the username already exists in Firestore
  Future<bool> isUsernameTaken(String username) async {
    try {
      var result = await _db
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking username: $e');
      return false;
    }
  }

  // Check if the email already exists in Firestore
  Future<bool> isEmailTaken(String email) async {
    try {
      var result =
          await _db.collection('users').where('email', isEqualTo: email).get();
      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

  // Log in user with email and password
  Future<UserCredential?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Attempt to sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }
}
