// lib/screens/reset_password_screen.dart
// Updated: shows confirmation that Firebase email was sent; no local reset logic needed.
import 'package:flutter/material.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    const blueColor = Color(0xFF2563EB);
    const purpleColor = Color(0xFFA855F7);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Email Sent', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)), centerTitle: true),
      body: Center(child: SingleChildScrollView(child: Container(width: 350, padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 20),
          Container(width: 110, height: 110,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [blueColor, purpleColor]), borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.mark_email_read, color: Colors.white, size: 60)),
          const SizedBox(height: 30),
          const Text('Check Your Email', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('A password reset link has been sent to\n$email\n\nOpen the link in your email to reset your password.',
            textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 35),
          SizedBox(width: double.infinity, height: 60,
            child: ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
              child: Ink(decoration: BoxDecoration(gradient: const LinearGradient(colors: [blueColor, purpleColor]), borderRadius: BorderRadius.circular(18)),
                child: const Center(child: Text('Back to Login', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))))),
          const SizedBox(height: 20),
        ])))),
    );
  }
}