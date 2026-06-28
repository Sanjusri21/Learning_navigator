import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});
  @override
  State<AdminUserManagementScreen> createState() => _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {
  static const _blue = Color(0xFF2563EB);
  final TextEditingController _searchCtrl = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _searching = false;

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) { setState(() { _searching = false; _searchResults = []; }); return; }
    setState(() => _searching = true);
    final results = await FirestoreService.searchUsers(query);
    if (mounted) setState(() { _searchResults = results; _searching = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: _blue, foregroundColor: Colors.white,
        title: const Text('User Management', style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: true),
      body: Column(children: [
        // Search bar
        Padding(padding: const EdgeInsets.all(12),
          child: TextField(controller: _searchCtrl, onChanged: _search,
            decoration: InputDecoration(hintText: 'Search by name or email...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchCtrl.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _searchCtrl.clear(); _search(''); }) : null,
              filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)))),
        // List
        Expanded(child: _searching
          ? const Center(child: CircularProgressIndicator())
          : _searchCtrl.text.isNotEmpty
            ? _buildSearchResults()
            : _buildAllUsers()),
      ]),
    );
  }

  Widget _buildAllUsers() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService.getAllUsers(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text('No users found.'));
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: snap.data!.docs.length,
          itemBuilder: (_, i) {
            final data = snap.data!.docs[i].data() as Map<String, dynamic>;
            return _UserTile(user: data, docId: snap.data!.docs[i].id);
          });
      });
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) return const Center(child: Text('No users found.'));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _searchResults.length,
      itemBuilder: (_, i) => _UserTile(user: _searchResults[i], docId: _searchResults[i]['uid'] ?? ''));
  }
}

class _UserTile extends StatelessWidget {
  final Map<String, dynamic> user;
  final String docId;
  const _UserTile({required this.user, required this.docId});

  @override
  Widget build(BuildContext context) {
    final role = user['role'] as String? ?? 'user';
    final name = user['name'] as String? ?? 'Unknown';
    final email = user['email'] as String? ?? '';
    final createdAt = user['createdAt'];
    String joinDate = '';
    if (createdAt is Timestamp) joinDate = 'Joined: ${_fmt(createdAt.toDate())}';

    return Container(margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(backgroundColor: role == 'admin' ? Colors.deepPurple : const Color(0xFF2563EB),
          child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?', style: const TextStyle(color: Colors.white))),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(email, style: const TextStyle(fontSize: 12)),
          if (joinDate.isNotEmpty) Text(joinDate, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ]),
        trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: role == 'admin' ? Colors.deepPurple.shade50 : Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
          child: Text(role.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: role == 'admin' ? Colors.deepPurple : Colors.blue))),
        onTap: () => _showUserDetail(context, name, email, role, joinDate),
      ));
  }

  void _showUserDetail(BuildContext context, String name, String email, String role, String joinDate) {
    showModalBottomSheet(context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: CircleAvatar(radius: 36, backgroundColor: role == 'admin' ? Colors.deepPurple : const Color(0xFF2563EB),
            child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?', style: const TextStyle(color: Colors.white, fontSize: 28)))),
          const SizedBox(height: 16),
          Center(child: Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Center(child: Text(email, style: const TextStyle(color: Colors.grey))),
          const SizedBox(height: 16),
          _DetailRow(Icons.badge, 'Role', role.toUpperCase()),
          _DetailRow(Icons.calendar_today, 'Join Date', joinDate.replaceAll('Joined: ', '')),
          const SizedBox(height: 20),
        ])));
  }

  String _fmt(DateTime dt) => '${dt.day}/${dt.month}/${dt.year}';
}

class _DetailRow extends StatelessWidget {
  final IconData icon; final String label; final String value;
  const _DetailRow(this.icon, this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 10),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(color: Colors.grey)),
      ]));
  }
}