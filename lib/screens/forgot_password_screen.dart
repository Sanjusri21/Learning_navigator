import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool _loading = false;
  static const blueColor = Color(0xFF2563EB);
  static const purpleColor = Color(0xFFA855F7);

  @override
  void dispose() { emailController.dispose(); super.dispose(); }

  Future<void> _sendReset() async {
    final email = emailController.text.trim();
    if (email.isEmpty) { _showMsg('Please enter your email.', isError: true); return; }
    setState(() => _loading = true);
    final error = await AuthService.sendPasswordReset(email);
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) { _showMsg(error, isError: true); }
    else { _showMsg('Reset link sent! Check your inbox.', isError: false); Navigator.pop(context); }
  }

  void _showMsg(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: isError ? Colors.redAccent : Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: const BackButton(color: Colors.black),
        title: const Text('Forgot Password', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)), centerTitle: true),
      body: Center(child: SingleChildScrollView(child: Container(width: 350, padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 20),
            Container(width: 110, height: 110,
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [blueColor, purpleColor]), borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.lock_reset, color: Colors.white, size: 60)),
            const SizedBox(height: 30),
            const Text('Reset Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Enter your email to receive a reset link', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 35),
            TextField(controller: emailController, keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email Address', prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)))),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, height: 60,
              child: ElevatedButton(onPressed: _loading ? null : _sendReset,
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                child: Ink(decoration: BoxDecoration(gradient: const LinearGradient(colors: [blueColor, purpleColor]), borderRadius: BorderRadius.circular(18)),
                  child: Center(child: _loading ? const CircularProgressIndicator(color: Colors.white) :
                    const Text('Send Reset Link', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))))),
            const SizedBox(height: 20),
          ])))),
    );
  }
}