import 'package:flutter/material.dart';
import '../models/learning_path.dart';
import 'path_detail_screen.dart';
import '../services/local_data.dart';

class ProgramListScreen extends StatelessWidget {
  ProgramListScreen({super.key});

  final Color blue = const Color(0xFF2563EB);
  final Color purple = const Color(0xFFA855F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 🔵 App Bar
      appBar: AppBar(
        title: const Text("Programs / Learning Paths"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // 🔵 Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFFA855F7)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Explore Learning Paths",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Choose your program and start learning",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔵 Program Cards List
          ...samplePaths.map((path) {

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PathDetailScreen(path: path),
                  ),
                );
              },

              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                    )
                  ],
                ),

                child: Row(
                  children: [

                    // Icon Box
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [blue, purple],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          path.iconEmoji,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            path.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            path.subtitle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Progress bar
                          LinearProgressIndicator(
                            value: path.progress,
                            backgroundColor: Colors.grey.shade200,
                            color: blue,
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "${(path.progress * 100).toInt()}% completed",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}