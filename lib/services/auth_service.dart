// lib/services/auth_service.dart
//
// Centralises all Firebase Auth + Firestore user operations.
// All screens import this one class — no direct firebase calls elsewhere.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Current user ────────────────────────────────────────────────
  static User? get currentUser => _auth.currentUser;
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Sign Up ─────────────────────────────────────────────────────
  /// Creates the Firebase Auth account then writes a Firestore user doc.
  /// Returns null on success or an error message string.
  static Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = credential.user!.uid;

      // Write user document to Firestore
      await _db.collection('users').doc(uid).set({
        'uid': uid,
        'name': name.trim(),
        'email': email.trim(),
        'role': 'user', // default role
        'createdAt': FieldValue.serverTimestamp(),
        'enrolledCourses': [],
        'progress': {},
      });

      // Also update displayName in Auth
      await credential.user!.updateDisplayName(name.trim());

      return null; // success
    } on FirebaseAuthException catch (e) {
      return _friendlyAuthError(e.code);
    } catch (_) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // ── Login ───────────────────────────────────────────────────────
  /// Returns null on success or an error message string.
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _friendlyAuthError(e.code);
    } catch (_) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // ── Forgot Password ─────────────────────────────────────────────
  /// Sends a Firebase password-reset email.
  /// Returns null on success or an error message string.
  static Future<String?> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return _friendlyAuthError(e.code);
    } catch (_) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // ── Logout ──────────────────────────────────────────────────────
  static Future<void> logout() async {
    await _auth.signOut();
  }

  // ── Get user role from Firestore ────────────────────────────────
  static Future<String> getUserRole(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return (doc.data()?['role'] as String?) ?? 'user';
      }
      return 'user';
    } catch (_) {
      return 'user';
    }
  }

  // ── Fetch full user doc ─────────────────────────────────────────
  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      return doc.exists ? doc.data() : null;
    } catch (_) {
      return null;
    }
  }

  // ── Helper: human-readable Firebase error messages ─────────────
  static String _friendlyAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      // Firebase SDK v5+ uses this code instead of wrong-password/user-not-found
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return 'Authentication error: $code';
    }
  }
}