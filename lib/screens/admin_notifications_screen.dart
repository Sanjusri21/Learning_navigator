import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});
  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  static const _blue = Color(0xFF2563EB);
  String _targetType = 'all'; // 'all' or 'user'
  final _titleCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  final _userIdCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() { _titleCtrl.dispose(); _msgCtrl.dispose(); _userIdCtrl.dispose(); super.dispose(); }

  Future<void> _send() async {
    if (_titleCtrl.text.trim().isEmpty || _msgCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title and message are required.')));
      return;
    }
    setState(() => _sending = true);
    await FirestoreService.sendNotification(
      title: _titleCtrl.text.trim(),
      message: _msgCtrl.text.trim(),
      targetType: _targetType,
      targetUserId: _targetType == 'user' ? _userIdCtrl.text.trim() : null);
    if (mounted) {
      setState(() => _sending = false);
      _titleCtrl.clear(); _msgCtrl.clear(); _userIdCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification sent!'), backgroundColor: Colors.green));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: _blue, foregroundColor: Colors.white,
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: true),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Compose card
        Container(padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Send Notification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Target
            const Text('Send to:', style: TextStyle(fontWeight: FontWeight.w500)),
            Row(children: [
              Expanded(child: RadioListTile<String>(title: const Text('All Users'), value: 'all', groupValue: _targetType,
                onChanged: (v) => setState(() => _targetType = v!), contentPadding: EdgeInsets.zero)),
              Expanded(child: RadioListTile<String>(title: const Text('Specific User'), value: 'user', groupValue: _targetType,
                onChanged: (v) => setState(() => _targetType = v!), contentPadding: EdgeInsets.zero)),
            ]),
            if (_targetType == 'user') ...[
              TextField(controller: _userIdCtrl,
                decoration: InputDecoration(hintText: 'User ID (UID)', prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 12),
            ],
            TextField(controller: _titleCtrl,
              decoration: InputDecoration(hintText: 'Notification Title', prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(controller: _msgCtrl, maxLines: 3,
              decoration: InputDecoration(hintText: 'Message body...', prefixIcon: const Icon(Icons.message),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sending ? null : _send,
                icon: _sending ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.send),
                label: Text(_sending ? 'Sending...' : 'Send Notification'),
                style: ElevatedButton.styleFrom(backgroundColor: _blue, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
          ])),
        const SizedBox(height: 24),

        // History
        const Text('Sent Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        StreamBuilder<QuerySnapshot>(
          stream: FirestoreService.getAllNotifications(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
            if (!snap.hasData || snap.data!.docs.isEmpty) {
              return const Center(child: Padding(padding: EdgeInsets.all(20),
                child: Text('No notifications sent yet.', style: TextStyle(color: Colors.grey))));
            }
            return ListView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              itemCount: snap.data!.docs.length,
              itemBuilder: (_, i) {
                final doc = snap.data!.docs[i];
                final data = doc.data() as Map<String, dynamic>;
                final createdAt = data['createdAt'];
                String dateStr = '';
                if (createdAt is Timestamp) { final d = createdAt.toDate(); dateStr = '${d.day}/${d.month}/${d.year}'; }
                final targetType = data['targetType'] as String? ?? 'all';
                return Container(margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: ListTile(
                    leading: Container(padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.notifications, color: Colors.red)),
                    title: Text(data['title'] ?? 'No Title', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(data['message'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 3),
                      Row(children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: targetType == 'all' ? Colors.blue.shade50 : Colors.orange.shade50, borderRadius: BorderRadius.circular(6)),
                          child: Text(targetType == 'all' ? 'All Users' : 'Specific User',
                            style: TextStyle(fontSize: 10, color: targetType == 'all' ? Colors.blue : Colors.orange))),
                        if (dateStr.isNotEmpty) ...[const SizedBox(width: 8), Text(dateStr, style: const TextStyle(fontSize: 10, color: Colors.grey))],
                      ]),
                    ]),
                    trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async { await FirestoreService.deleteNotification(doc.id); }),
                  ));
              });
          }),
      ])),
    );
  }
}