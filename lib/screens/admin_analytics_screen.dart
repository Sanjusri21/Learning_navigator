import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});
  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  static const _blue = Color(0xFF2563EB);
  static const _purple = Color(0xFFA855F7);

  Map<String, dynamic> _stats = {};
  bool _loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final stats = await FirestoreService.getAnalyticsSummary();
    if (mounted) setState(() { _stats = stats; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: _blue, foregroundColor: Colors.white,
        title: const Text('Analytics Dashboard', style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () { setState(() => _loading = true); _load(); })]),
      body: _loading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(onRefresh: _load, child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Primary metrics
              const Text('Key Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2, childAspectRatio: 1.3, mainAxisSpacing: 10, crossAxisSpacing: 10,
                children: [
                  _MetricCard('Total Users', '${_stats['totalUsers'] ?? 0}', Icons.people, Colors.blue),
                  _MetricCard('Active Users\n(30 days)', '${_stats['activeUsers'] ?? 0}', Icons.person_pin, Colors.green),
                  _MetricCard('Total Courses', '${_stats['totalCourses'] ?? 0}', Icons.menu_book, Colors.orange),
                  _MetricCard('Enrollments', '${_stats['totalEnrollments'] ?? 0}', Icons.assignment, Colors.purple),
                ]),
              const SizedBox(height: 20),

              // Completion stats
              const Text('Completion Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _InfoCard(
                rows: [
                  _Row('Certificates Issued', '${_stats['totalCertificates'] ?? 0}', Icons.card_membership, Colors.deepPurple),
                  _Row('Completed Enrollments', '${_stats['completionCount'] ?? 0}', Icons.check_circle, Colors.green),
                  _Row('Completion Rate', '${_stats['completionRate'] ?? '0.0'}%', Icons.percent, Colors.teal),
                ]),
              const SizedBox(height: 20),

              // Monthly growth
              const Text('User Growth (Monthly)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildGrowthChart(),
              const SizedBox(height: 20),
            ]))),
    );
  }

  Widget _buildGrowthChart() {
    final growth = (_stats['monthlyGrowth'] as Map<String, dynamic>?) ?? {};
    if (growth.isEmpty) {
      return Container(padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: const Center(child: Text('No growth data available.', style: TextStyle(color: Colors.grey))));
    }

    final sorted = growth.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    final maxVal = sorted.map((e) => e.value as int).fold(0, (a, b) => a > b ? a : b);

    return Container(padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('New Users Per Month', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        SizedBox(height: 160,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: sorted.take(6).map((e) {
              final pct = maxVal > 0 ? (e.value as int) / maxVal : 0.0;
              final month = e.key.split('-').lastOrNull ?? e.key;
              return Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('${e.value}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 120 * pct,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFFA855F7)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    borderRadius: BorderRadius.circular(6))),
                const SizedBox(height: 4),
                Text(month, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ]));
            }).toList())),
      ]));
  }
}

class _MetricCard extends StatelessWidget {
  final String label; final String value; final IconData icon; final Color color;
  const _MetricCard(this.label, this.value, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ]));
  }
}

class _InfoCard extends StatelessWidget {
  final List<_Row> rows;
  const _InfoCard({required this.rows});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(children: rows.map((r) => ListTile(
        leading: Icon(r.icon, color: r.color),
        title: Text(r.label, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(r.value, style: TextStyle(fontWeight: FontWeight.bold, color: r.color, fontSize: 16)))).toList()));
  }
}

class _Row {
  final String label; final String value; final IconData icon; final Color color;
  const _Row(this.label, this.value, this.icon, this.color);
}