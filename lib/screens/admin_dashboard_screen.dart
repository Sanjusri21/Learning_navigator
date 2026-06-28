import 'package:flutter/material.dart';
import 'admin_user_management_screen.dart';
import 'admin_course_management_screen.dart';
import 'admin_analytics_screen.dart';
import 'admin_certificates_screen.dart';
import 'admin_notifications_screen.dart';
import '../../services/firestore_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});
  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static const _blue = Color(0xFF2563EB);
  static const _purple = Color(0xFFA855F7);

  Map<String, dynamic> _stats = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await FirestoreService.getAnalyticsSummary();
    if (mounted) setState(() { _stats = stats; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: _blue,
        foregroundColor: Colors.white,
        title: const Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () { setState(() => _loading = true); _loadStats(); })],
      ),
      body: RefreshIndicator(
        onRefresh: _loadStats,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Welcome banner
            Container(width: double.infinity, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [_blue, _purple]), borderRadius: BorderRadius.circular(16)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Welcome, Admin 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Manage your Learning Navigator platform', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ])),
            const SizedBox(height: 20),

            // Quick stats
            const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else
              GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 1.4, mainAxisSpacing: 10, crossAxisSpacing: 10,
                children: [
                  _StatTile('Total Users', '${_stats['totalUsers'] ?? 0}', Icons.people, Colors.blue),
                  _StatTile('Active Users', '${_stats['activeUsers'] ?? 0}', Icons.person_pin, Colors.green),
                  _StatTile('Total Courses', '${_stats['totalCourses'] ?? 0}', Icons.menu_book, Colors.orange),
                  _StatTile('Enrollments', '${_stats['totalEnrollments'] ?? 0}', Icons.assignment_turned_in, Colors.purple),
                ]),
            const SizedBox(height: 24),

            // Feature cards
            const Text('Management', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _FeatureCard(icon: Icons.manage_accounts, title: 'User Management',
              subtitle: 'View users, search, check progress',
              color: Colors.blue,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminUserManagementScreen()))),
            _FeatureCard(icon: Icons.library_books, title: 'Course Management',
              subtitle: 'Add, edit, publish/unpublish courses',
              color: Colors.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminCourseManagementScreen()))),
            _FeatureCard(icon: Icons.bar_chart, title: 'Analytics Dashboard',
              subtitle: 'User growth, completions, enrollments',
              color: Colors.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminAnalyticsScreen()))),
            _FeatureCard(icon: Icons.card_membership, title: 'Certificate Management',
              subtitle: 'Issue, view and manage certificates',
              color: Colors.deepPurple,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminCertificatesScreen()))),
            _FeatureCard(icon: Icons.notifications_active, title: 'Notifications',
              subtitle: 'Send announcements to users',
              color: Colors.red,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminNotificationsScreen()))),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label; final String value; final IconData icon; final Color color;
  const _StatTile(this.label, this.value, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ]));
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon; final String title; final String subtitle;
  final Color color; final VoidCallback onTap;
  const _FeatureCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 26)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 3),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ])),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ])));
  }
}