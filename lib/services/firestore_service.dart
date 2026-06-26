import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// CREATE USER
  Future<void> createUser({

    required String uid,

    required String name,

    required String email,

  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .set({

      "name": name,

      "email": email,

      "progress": 0,

      "completedTopics": [],

      "selectedSkill": "",

      "createdAt":
          FieldValue.serverTimestamp(),
    });
  }

  /// UPDATE PROGRESS
  Future<void> updateProgress({

    required List<String>
        completedTopics,

    required int progress,

  }) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .update({

      "completedTopics":
          completedTopics,

      "progress": progress,
    });
  }

  /// GET USER DATA
  Future<Map<String, dynamic>>
      getUserData() async {

    final user =
        _auth.currentUser;

    if (user == null) {
      return {};
    }

    final doc =
        await _firestore
            .collection("users")
            .doc(user.uid)
            .get();

    return doc.data() ?? {};
  }

  /// SAVE SELECTED SKILL
  Future<void> saveSelectedSkill({

    required String skill,

  }) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .update({

      "selectedSkill": skill,
    });
  }

  /// SAVE QUIZ SCORE
  Future<void> saveQuizScore({

    required String skillName,

    required int score,

  }) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore

        .collection("users")

        .doc(user.uid)

        .collection("quiz_scores")

        .add({

      "skillName": skillName,

      "score": score,

      "createdAt":
          FieldValue.serverTimestamp(),
    });
  }

  /// GET QUIZ SCORES
  Future<QuerySnapshot>
      getQuizScores() async {

    final user =
        _auth.currentUser;

    return await _firestore

        .collection("users")

        .doc(user!.uid)

        .collection("quiz_scores")

        .orderBy(
          "createdAt",
          descending: true,
        )

        .get();
  }

  /// RESET USER PROGRESS
  Future<void> resetProgress() async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .update({

      "progress": 0,

      "completedTopics": [],
    });
  }
}