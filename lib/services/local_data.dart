import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/learning_path.dart';

class LocalData {
  static Future<List<LearningPath>> loadPrograms() async {
    try {
      final data = await rootBundle.loadString('assets/data/programs.json');
      final json = jsonDecode(data) as Map<String, dynamic>;
      final list = (json['programs'] as List).cast<Map<String, dynamic>>();
      return list
          .map((e) => LearningPath(
                title: e['title'] as String,
                subtitle: e['subtitle'] as String,
                iconEmoji: e['iconEmoji'] as String,
                students: (e['students'] as num).toInt(),
                duration: e['duration'] as String,
                skills: (e['skills'] as num).toInt(),
                progress: (e['progress'] as num).toDouble(),
                description: e['description'] as String,
                whatYouLearn:
                    (e['whatYouLearn'] as List).cast<String>(),
              ))
          .toList();
    } catch (_) {
      return samplePaths; // fallback to in-memory data
    }
  }

  static Future<List<Map<String, dynamic>>> loadEvents() async {
    try {
      final data = await rootBundle.loadString('assets/data/events.json');
      final json = jsonDecode(data) as Map<String, dynamic>;
      final list = (json['events'] as List).cast<Map<String, dynamic>>();
      return list;
    } catch (_) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> loadUsers() async {
    try {
      final data = await rootBundle.loadString('assets/data/users.json');
      final json = jsonDecode(data) as Map<String, dynamic>;
      final list = (json['users'] as List).cast<Map<String, dynamic>>();
      return list;
    } catch (_) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> loadSkills() async {
    try {
      final data = await rootBundle.loadString('assets/data/skills.json');
      final json = jsonDecode(data) as Map<String, dynamic>;
      final list = (json['skills'] as List).cast<Map<String, dynamic>>();
      return list;
    } catch (_) {
      return [];
    }
  }

  static Future<Map<String, dynamic>?> loadSkillByName(
      String skillName) async {
    final skills = await loadSkills();
    try {
      return skills.firstWhere((s) => s['title'] == skillName);
    } catch (_) {
      return null;
    }
  }
}