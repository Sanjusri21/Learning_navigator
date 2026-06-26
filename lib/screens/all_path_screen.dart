import 'package:flutter/material.dart';

import '../services/local_data.dart';
import 'path_detail_screen.dart';

class AllPathsScreen extends StatelessWidget {
  const AllPathsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning Paths"),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: samplePaths.length,

        itemBuilder: (context, index) {

          final path = samplePaths[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(16),

              leading: CircleAvatar(
                radius: 28,

                child: Text(
                  path.iconEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),

              title: Text(path.title),

              subtitle: Text(path.subtitle),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PathDetailScreen(path: path),
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