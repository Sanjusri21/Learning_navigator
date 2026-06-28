import 'package:flutter/material.dart';
import '../models/learning_path.dart';
import 'path_detail_screen.dart';

class LearningHistoryScreen extends StatelessWidget {
  const LearningHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enrolledCourses =
        samplePaths.where((path) => path.progress > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning History"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: enrolledCourses.isEmpty
          ? const Center(
              child: Text(
                "No learning history found",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: enrolledCourses.length,
              itemBuilder: (context, index) {
                final course = enrolledCourses[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF2563EB).withOpacity(0.1),
                      child: const Icon(
                        Icons.school,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                    title: Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          "Progress: ${(course.progress * 100).toInt()}%",
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: course.progress,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PathDetailScreen(
                            path: course,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}