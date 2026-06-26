import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {

  final Color blueColor =
      const Color(0xFF2563EB);

  final Color purpleColor =
      const Color(0xFFA855F7);

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      otpController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final TextEditingController
      confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  bool otpSent = false;

  /// I'M NOT A ROBOT
  bool isHumanVerified = false;

  /// SEND RESET EMAIL
  Future<void> sendOTP() async {

    String email =
        emailController.text.trim();

    if (email.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("Enter your email"),
        ),
      );

      return;
    }

    /// ROBOT CHECK
    if (!isHumanVerified) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Please verify that you are not a robot",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      /// SEND RESET EMAIL
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      );

      setState(() {
        otpSent = true;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Password reset email sent",
          ),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String errorMessage =
          "Something went wrong";

      if (e.code == "user-not-found") {

        errorMessage =
            "No user found with this email";
      }

      if (e.code == "invalid-email") {

        errorMessage =
            "Invalid email address";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(errorMessage),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
              Text(e.toString()),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  /// UPDATE PASSWORD INFO
  Future<void> updatePassword() async {

    String password =
        passwordController.text.trim();

    String confirmPassword =
        confirmPasswordController
            .text
            .trim();

    if (password.isEmpty ||
        confirmPassword.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("Fill all fields"),
        ),
      );

      return;
    }

    if (password.length < 6) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Password must be at least 6 characters",
          ),
        ),
      );

      return;
    }

    if (password != confirmPassword) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("Passwords do not match"),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(
        content: Text(
          "Use the reset link sent to your email to update the password",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {

    emailController.dispose();

    otpController.dispose();

    passwordController.dispose();

    confirmPasswordController
        .dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F5F5),

      body: Center(

        child: SingleChildScrollView(

          child: Container(

            width: 350,

            padding:
                const EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                      40),
            ),

            child: Column(

              children: [

                /// HEADER
                Row(

                  children: [

                    IconButton(

                      onPressed: () {
                        Navigator.pop(
                            context);
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),

                    const Spacer(),

                    const Text(

                      "Reset Password",

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),

                const SizedBox(
                    height: 30),

                /// ICON
                Container(

                  width: 110,
                  height: 110,

                  decoration: BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(
                            30),

                    gradient:
                        LinearGradient(
                      colors: [
                        blueColor,
                        purpleColor,
                      ],
                    ),
                  ),

                  child: const Icon(

                    Icons.lock_reset,

                    color: Colors.white,

                    size: 60,
                  ),
                ),

                const SizedBox(
                    height: 30),

                /// EMAIL FIELD
                TextField(

                  controller:
                      emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  decoration:
                      InputDecoration(

                    hintText: "Email",

                    prefixIcon:
                        const Icon(
                      Icons.email_outlined,
                    ),

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                /// I'M NOT A ROBOT
                Container(

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(

                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                            15),
                  ),

                  child: Row(

                    children: [

                      Checkbox(

                        value:
                            isHumanVerified,

                        activeColor:
                            blueColor,

                        onChanged:
                            (value) {

                          setState(() {

                            isHumanVerified =
                                value ?? false;
                          });
                        },
                      ),

                      const Expanded(

                        child: Text(

                          "I'm not a robot",

                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),

                      Icon(

                        Icons.verified_user,

                        color: blueColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 20),

                /// OTP FIELD
                if (otpSent)
                  TextField(

                    controller:
                        otpController,

                    keyboardType:
                        TextInputType.number,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Enter OTP",

                      prefixIcon:
                          const Icon(
                        Icons.numbers,
                      ),

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                    ),
                  ),

                if (otpSent)
                  const SizedBox(
                      height: 20),

                /// NEW PASSWORD
                if (otpSent)
                  TextField(

                    controller:
                        passwordController,

                    obscureText: true,

                    decoration:
                        InputDecoration(

                      hintText:
                          "New Password",

                      prefixIcon:
                          const Icon(
                        Icons.lock_outline,
                      ),

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                    ),
                  ),

                if (otpSent)
                  const SizedBox(
                      height: 20),

                /// CONFIRM PASSWORD
                if (otpSent)
                  TextField(

                    controller:
                        confirmPasswordController,

                    obscureText: true,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Confirm Password",

                      prefixIcon:
                          const Icon(
                        Icons.lock_reset,
                      ),

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                    ),
                  ),

                const SizedBox(
                    height: 30),

                /// BUTTON
                SizedBox(

                  width:
                      double.infinity,

                  height: 60,

                  child: ElevatedButton(

                    onPressed:
                        isLoading
                            ? null
                            : otpSent
                                ? updatePassword
                                : sendOTP,

                    style:
                        ElevatedButton
                            .styleFrom(

                      padding:
                          EdgeInsets.zero,

                      elevation: 0,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                    ),

                    child: Ink(

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                                18),

                        gradient:
                            LinearGradient(
                          colors: [
                            blueColor,
                            purpleColor,
                          ],
                        ),
                      ),

                      child: Center(

                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                    color:
                                        Colors.white,
                                  )
                                : Text(

                                    otpSent
                                        ? "Update Password"
                                        : "Send OTP",

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors.white,

                                      fontSize:
                                          20,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}