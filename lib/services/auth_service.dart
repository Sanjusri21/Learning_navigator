import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// SIGN UP
  Future<User?> signUp({

    required String email,
    required String password,

  }) async {

    try {

      UserCredential userCredential =
          await _auth
              .createUserWithEmailAndPassword(

        email: email,
        password: password,
      );

      return userCredential.user;

    } on FirebaseAuthException catch (e) {

      throw e.message ??
          "Signup failed";
    }
  }

  /// LOGIN
  Future<User?> login({

    required String email,
    required String password,

  }) async {

    try {

      UserCredential userCredential =
          await _auth
              .signInWithEmailAndPassword(

        email: email,
        password: password,
      );

      return userCredential.user;

    } on FirebaseAuthException catch (e) {

      throw e.message ??
          "Login failed";
    }
  }

  /// RESET PASSWORD
  Future<void> resetPassword(
    String email,
  ) async {

    try {

      await _auth
          .sendPasswordResetEmail(
        email: email,
      );

    } on FirebaseAuthException catch (e) {

      throw e.message ??
          "Reset password failed";
    }
  }

  /// LOGOUT
  Future<void> logout() async {

    await _auth.signOut();
  }
}