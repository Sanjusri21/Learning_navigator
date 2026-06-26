import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// GET CURRENT USER
  User? get currentUser =>
      _auth.currentUser;

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

      print(e.message);
      return null;

    } catch (e) {

      print(e);
      return null;
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

      print(e.message);
      return null;

    } catch (e) {

      print(e);
      return null;
    }
  }

  /// LOGOUT
  Future<void> logout() async {

    await _auth.signOut();
  }
}