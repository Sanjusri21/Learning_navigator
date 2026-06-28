// lib/services/firestore_service.dart
//
// All Firestore read/write operations for the Admin Dashboard
// and general app data (courses, enrollments, certificates, notifications).

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─────────────────────────────────────────────────────────────────────────
  // USERS
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns all user documents (admin use only).
  static Stream<QuerySnapshot> getAllUsers() {
    return _db.collection('users').orderBy('createdAt', descending: true).snapshots();
  }

  /// Search users by name or email prefix.
  static Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    final q = query.trim().toLowerCase();
    final snap = await _db.collection('users').get();
    return snap.docs
        .map((d) => d.data())
        .where((u) =>
            (u['name'] as String? ?? '').toLowerCase().contains(q) ||
            (u['email'] as String? ?? '').toLowerCase().contains(q))
        .toList();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // COURSES
  // ─────────────────────────────────────────────────────────────────────────

  static Stream<QuerySnapshot> getAllCourses() {
    return _db.collection('courses').orderBy('createdAt', descending: true).snapshots();
  }

  static Future<void> addCourse(Map<String, dynamic> data) async {
    await _db.collection('courses').add({
      ...data,
      'published': false,
      'enrollmentCount': 0,
      'completionCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateCourse(String id, Map<String, dynamic> data) async {
    await _db.collection('courses').doc(id).update(data);
  }

  static Future<void> deleteCourse(String id) async {
    await _db.collection('courses').doc(id).delete();
  }

  static Future<void> toggleCoursePublish(String id, bool published) async {
    await _db.collection('courses').doc(id).update({'published': published});
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ENROLLMENTS
  // ─────────────────────────────────────────────────────────────────────────

  static Stream<QuerySnapshot> getAllEnrollments() {
    return _db.collection('enrollments').snapshots();
  }

  static Future<List<Map<String, dynamic>>> getEnrollmentsForUser(String uid) async {
    final snap = await _db
        .collection('enrollments')
        .where('userId', isEqualTo: uid)
        .get();
    return snap.docs.map((d) => {...d.data(), 'id': d.id}).toList();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ANALYTICS
  // ─────────────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> getAnalyticsSummary() async {
    final usersSnap = await _db.collection('users').get();
    final coursesSnap = await _db.collection('courses').get();
    final enrollmentsSnap = await _db.collection('enrollments').get();
    final certificatesSnap = await _db.collection('certificates').get();

    final totalUsers = usersSnap.size;
    final totalCourses = coursesSnap.size;
    final totalEnrollments = enrollmentsSnap.size;
    final totalCertificates = certificatesSnap.size;

    // Active users: signed up in last 30 days
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    final activeUsers = usersSnap.docs.where((d) {
      final ts = d.data()['createdAt'];
      if (ts == null) return false;
      return (ts as Timestamp).toDate().isAfter(cutoff);
    }).length;

    // Completion count
    final completed = enrollmentsSnap.docs
        .where((d) => d.data()['completed'] == true)
        .length;

    // Monthly user growth (last 6 months)
    final Map<String, int> monthlyGrowth = {};
    for (final d in usersSnap.docs) {
      final ts = d.data()['createdAt'];
      if (ts == null) continue;
      final date = (ts as Timestamp).toDate();
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      monthlyGrowth[key] = (monthlyGrowth[key] ?? 0) + 1;
    }

    return {
      'totalUsers': totalUsers,
      'activeUsers': activeUsers,
      'totalCourses': totalCourses,
      'totalEnrollments': totalEnrollments,
      'totalCertificates': totalCertificates,
      'completionCount': completed,
      'completionRate': totalEnrollments > 0
          ? (completed / totalEnrollments * 100).toStringAsFixed(1)
          : '0.0',
      'monthlyGrowth': monthlyGrowth,
    };
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CERTIFICATES
  // ─────────────────────────────────────────────────────────────────────────

  static Stream<QuerySnapshot> getAllCertificates() {
    return _db.collection('certificates').orderBy('issuedAt', descending: true).snapshots();
  }

  static Future<void> issueCertificate({
    required String userId,
    required String userName,
    required String courseId,
    required String courseName,
  }) async {
    await _db.collection('certificates').add({
      'userId': userId,
      'userName': userName,
      'courseId': courseId,
      'courseName': courseName,
      'certificateNumber': 'CERT-${DateTime.now().millisecondsSinceEpoch}',
      'issuedAt': FieldValue.serverTimestamp(),
      'status': 'issued',
    });
  }

  static Future<void> deleteCertificate(String id) async {
    await _db.collection('certificates').doc(id).delete();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // NOTIFICATIONS
  // ─────────────────────────────────────────────────────────────────────────

  static Stream<QuerySnapshot> getAllNotifications() {
    return _db
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Sends a notification to all users (targetType = 'all')
  /// or to a specific user (targetType = 'user', targetUserId required).
  static Future<void> sendNotification({
    required String title,
    required String message,
    required String targetType, // 'all' | 'user'
    String? targetUserId,
  }) async {
    await _db.collection('notifications').add({
      'title': title,
      'message': message,
      'targetType': targetType,
      'targetUserId': targetUserId,
      'createdAt': FieldValue.serverTimestamp(),
      'read': false,
    });
  }

  static Future<void> deleteNotification(String id) async {
    await _db.collection('notifications').doc(id).delete();
  }
}