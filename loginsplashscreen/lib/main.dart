import 'package:flutter/material.dart';
import 'splash_screen.dart';// Import your splash screen
import 'login_screen.dart';
import 'home.dart';
// import 'demo.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grievance Redressal',
      home: SplashScreen(), // Set the splash screen as the initial route
      routes: {
        '/login': (context) => LoginScreen(), // Login route
        '/home': (context) => HomePage(),
      },
    );
  }
}