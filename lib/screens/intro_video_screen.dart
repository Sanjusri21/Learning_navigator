import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shown after a user successfully registers for an event.
/// Displays event details and provides a button to watch the introduction video.
class IntroVideoScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const IntroVideoScreen({super.key, required this.event});

  Future<void> _launchVideo(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open video link.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = event['title'] as String? ?? 'Event';
    final String date = event['date'] as String? ?? '';
    final String time = event['time'] as String? ?? '';
    final String desc = event['desc'] as String? ?? '';
    final List<String> videos =
        (event['videos'] as List?)?.cast<String>() ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        title: const Text('Enrollment Confirmed',
            style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFFA855F7)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle,
                        color: Colors.white, size: 48),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'You\'re Registered!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Event details card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Event Details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(Icons.event, 'Event', title),
                  const Divider(height: 20),
                  _InfoRow(Icons.calendar_today, 'Date', date),
                  const Divider(height: 20),
                  _InfoRow(Icons.access_time, 'Time', time),
                  if (desc.isNotEmpty) ...[
                    const Divider(height: 20),
                    _InfoRow(Icons.info_outline, 'About', desc),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Intro video section
            if (videos.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2563EB).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.play_circle_outline,
                            color: Color(0xFF2563EB), size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Introduction Video',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF2563EB)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Watch the intro video to get prepared for this event.',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 14),
                    ...videos.asMap().entries.map((entry) {
                      final i = entry.key;
                      final url = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () => _launchVideo(context, url),
                            icon: const Icon(Icons.play_arrow,
                                color: Colors.white),
                            label: Text(
                              videos.length > 1
                                  ? 'Watch Video ${i + 1}'
                                  : 'Watch Introduction Video',
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline,
                        color: Colors.orange, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'No introduction video available for this event. Details will be sent to your email.',
                        style: TextStyle(color: Colors.orange, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Email confirmation note
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: const [
                  Icon(Icons.email_outlined, color: Colors.green, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'A confirmation has been sent to your registered email.',
                      style: TextStyle(color: Colors.green, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Done button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // Pop back to Events list
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst || route.settings.name == '/events',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF5B5FEF)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.grey)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      color: Colors.black87, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}