import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        "title": "Flutter Fundamentals",
        "status": "Completed",
        "icon": Icons.workspace_premium,
      },
      {
        "title": "AI & ML Basics",
        "status": "Completed",
        "icon": Icons.emoji_events,
      },
      {
        "title": "Data Structures",
        "status": "Completed",
        "icon": Icons.school,
      },
      {
        "title": "Web Development",
        "status": "Completed",
        "icon": Icons.language,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Achievements"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final item = achievements[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber.shade100,
                child: Icon(
                  item["icon"] as IconData,
                  color: Colors.orange,
                ),
              ),
              title: Text(
                item["title"].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item["status"].toString(),
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}