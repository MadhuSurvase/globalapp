import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalapp/registrationscreen.dart';
import 'package:globalapp/productlistscreen.dart'; // Import ProductListScreen
import 'package:globalapp/splashscreen.dart'; // If you have a splash screen
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(), // Use AuthGate to determine the initial screen
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen(); // Show a splash screen while waiting for authentication status
        } else if (snapshot.hasData) {
          return ProductListScreen(); // Navigate to ProductListScreen if user is signed in
        } else {
          return CustomerRegistrationScreen(); // Navigate to registration screen if user is not signed in
        }
      },
    );
  }
}
