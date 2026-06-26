import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const LearningNavigatorApp());
}

class LearningNavigatorApp extends StatelessWidget {
  const LearningNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Navigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
