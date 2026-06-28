// lib/screens/home_screen.dart
// Updated: Welcome message uses Firebase Auth displayName.
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/learning_path.dart';
import '../models/user_data.dart';
import 'events_screen.dart';
import 'profile_screen.dart';
import 'path_detail_screen.dart';
import 'all_paths_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const blueColor = Color(0xFF2563EB);
    final activePaths = samplePaths.where((p) => p.progress > 0).toList();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final displayName = firebaseUser?.displayName ?? UserData.name;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) Navigator.push(context, MaterialPageRoute(builder: (_) => const AllPathsScreen()));
          else if (index == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen()));
          else if (index == 3) Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(userName: displayName, userEmail: firebaseUser?.email ?? UserData.email)));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Paths'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Welcome Back, $displayName 👋', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Keep up the great work!', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 20),
            // Search bar
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllPathsScreen())),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                child: const Row(children: [Icon(Icons.search, color: Colors.grey), SizedBox(width: 10), Text('Search Programs...', style: TextStyle(color: Colors.grey))])),
            ),
            const SizedBox(height: 20),
            // Analytics grid
            GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 1.3,
              children: [
                _AnalyticsCard('Active Paths', '${samplePaths.length}', Icons.school,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllPathsScreen()))),
                _AnalyticsCard('Enrolled', '${activePaths.length}', Icons.book,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllPathsScreen()))),
                const _AnalyticsCard('Completed', '2', Icons.check_circle),
                const _AnalyticsCard('Rewards', '25', Icons.star),
              ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Continue Learning', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllPathsScreen())),
                child: const Text('See All', style: TextStyle(color: blueColor))),
            ]),
            const SizedBox(height: 10),
            ...activePaths.map((path) => _CourseCard(title: path.title, progress: path.progress,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PathDetailScreen(path: path))))),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Upcoming Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen())),
                child: const Text('See All', style: TextStyle(color: blueColor))),
            ]),
            const SizedBox(height: 10),
            _EventCard('Flutter Workshop', '15 July', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen()))),
            _EventCard('Cyber Security Session', '18 July', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen()))),
            _EventCard('AI Webinar', '22 July', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen()))),
          ]),
        ),
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String title; final String value; final IconData icon; final VoidCallback? onTap;
  const _AnalyticsCard(this.title, this.value, this.icon, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
      child: Container(padding: const EdgeInsets.all(15), margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 28), const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey))])));
  }
}

class _CourseCard extends StatelessWidget {
  final String title; final double progress; final VoidCallback? onTap;
  const _CourseCard({required this.title, required this.progress, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
      child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)]),
          const SizedBox(height: 10),
          ClipRRect(borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: progress, minHeight: 6, backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)))),
          const SizedBox(height: 4),
          Text('${(progress * 100).toInt()}% completed', style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ])));
  }
}

class _EventCard extends StatelessWidget {
  final String title; final String date; final VoidCallback? onTap;
  const _EventCard(this.title, this.date, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
      child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18),
          border: const Border(left: BorderSide(color: Color(0xFFA855F7), width: 4))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13))])));
  }
}