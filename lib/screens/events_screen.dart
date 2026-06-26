import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'all_paths_screen.dart';
import 'profile_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Flutter Workshop',
        'date': '15 July 2026',
        'time': '10:00 AM – 12:00 PM',
        'type': 'Workshop',
        'desc': 'Hands-on Flutter UI building session for beginners and intermediates.',
      },
      {
        'title': 'Cyber Security Session',
        'date': '18 July 2026',
        'time': '2:00 PM – 4:00 PM',
        'type': 'Session',
        'desc': 'Learn about ethical hacking, network security, and threat prevention.',
      },
      {
        'title': 'AI Career Webinar',
        'date': '22 July 2026',
        'time': '6:00 PM – 7:30 PM',
        'type': 'Webinar',
        'desc': 'Industry experts discuss career paths in Artificial Intelligence.',
      },
      {
        'title': 'Hackathon 2026',
        'date': '30 July 2026',
        'time': '9:00 AM – 9:00 PM',
        'type': 'Hackathon',
        'desc': 'Build a working project in 12 hours and compete for prizes.',
      },
      {
        'title': 'Data Science Bootcamp',
        'date': '5 August 2026',
        'time': '9:00 AM – 5:00 PM',
        'type': 'Bootcamp',
        'desc': 'Full-day intensive bootcamp covering Python, Pandas, and ML basics.',
      },
      {
        'title': 'UI/UX Design Summit',
        'date': '12 August 2026',
        'time': '11:00 AM – 3:00 PM',
        'type': 'Summit',
        'desc': 'Explore modern design principles, Figma workflows, and user research.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Events', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const AllPathsScreen()));
          } else if (index == 2) {
            // already here
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Paths'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFFA855F7)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${events.length} Upcoming Events',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Join live sessions, workshops & webinars',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailScreen(event: event),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: const Border(
                        left: BorderSide(color: Color(0xFFA855F7), width: 4),
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Type badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF0FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  event['type']!,
                                  style: const TextStyle(
                                    color: Color(0xFF5B5FEF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                event['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(event['date']!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.access_time,
                                      size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(event['time']!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 14, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Event Detail Screen ────────────────────────────────────────────────────────
class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        title: Text(event['type']!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF5B5FEF)),
              ),
              child: Text(
                event['type']!,
                style: const TextStyle(
                  color: Color(0xFF5B5FEF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              event['title']!,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _DetailRow(Icons.calendar_today, 'Date', event['date']!),
                  const Divider(height: 20),
                  _DetailRow(Icons.access_time, 'Time', event['time']!),
                  const Divider(height: 20),
                  _DetailRow(Icons.info_outline, 'Description', event['desc']!),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registered for ${event['title']}!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Register Now',
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow(this.icon, this.label, this.value);

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
                      fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 3),
              Text(value,
                  style: const TextStyle(color: Colors.black54, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}