import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadmapScreen extends StatefulWidget {
  final String pathId;
  final String title;

  const RoadmapScreen({
    super.key,
    required this.pathId,
    required this.title,
  });

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final Map<String, List<Map<String, dynamic>>> roadmapData = {
    "web_dev": [
      {
        "module": "HTML Basics",
        "steps": [
          {
            "title": "Intro to HTML",
            "resources": [
              "https://www.youtube.com",
              "https://www.w3schools.com"
            ],
            "completed": false
          },
          {
            "title": "Forms & Inputs",
            "resources": ["https://www.youtube.com"],
            "completed": false
          }
        ]
      },
      {
        "module": "CSS Basics",
        "steps": [
          {
            "title": "Flexbox",
            "resources": ["https://www.youtube.com"],
            "completed": false
          }
        ]
      }
    ]
  };

  void toggleComplete(int moduleIndex, int stepIndex) {
    setState(() {
      roadmapData[widget.pathId]![moduleIndex]["steps"][stepIndex]
              ["completed"] =
          !roadmapData[widget.pathId]![moduleIndex]["steps"][stepIndex]
              ["completed"];
    });
  }

  double calculateProgress() {
    final modules = roadmapData[widget.pathId] ?? [];

    int totalSteps = 0;
    int completedSteps = 0;

    for (var module in modules) {
      for (var step in module["steps"]) {
        totalSteps++;
        if (step["completed"] == true) {
          completedSteps++;
        }
      }
    }

    if (totalSteps == 0) return 0.0;

    return completedSteps / totalSteps;
  }

  void finishAndReturn() {
    final progress = calculateProgress();
    Navigator.pop(context, progress);
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final modules = roadmapData[widget.pathId] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF2563EB),

        /// 🔥 BACK RETURNS PROGRESS
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: finishAndReturn,
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, mIndex) {
          final module = modules[mIndex];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                )
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module["module"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                /// STEPS
                ...List.generate(module["steps"].length, (sIndex) {
                  final step = module["steps"][sIndex];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FF),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                step["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            Checkbox(
                              value: step["completed"],
                              onChanged: (_) {
                                toggleComplete(mIndex, sIndex);
                                setState(() {}); // refresh progress
                              },
                            )
                          ],
                        ),

                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          children: List.generate(
                            step["resources"].length,
                            (i) {
                              final link = step["resources"][i];

                              return GestureDetector(
                                onTap: () => openLink(link),
                                child: Chip(
                                  label: const Text("Open Resource"),
                                  backgroundColor: Colors.blue.shade50,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),

      /// 🔥 FLOATING BUTTON SHOWS LIVE PROGRESS
      floatingActionButton: FloatingActionButton.extended(
        onPressed: finishAndReturn,
        backgroundColor: const Color(0xFF2563EB),
        label: Text(
          "Finish (${(calculateProgress() * 100).toInt()}%)",
        ),
      ),
    );
  }
}