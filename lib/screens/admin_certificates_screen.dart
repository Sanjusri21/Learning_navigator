import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class AdminCertificatesScreen extends StatefulWidget {
  const AdminCertificatesScreen({super.key});
  @override
  State<AdminCertificatesScreen> createState() => _AdminCertificatesScreenState();
}

class _AdminCertificatesScreenState extends State<AdminCertificatesScreen> {
  static const _blue = Color(0xFF2563EB);

  void _showIssueCertDialog() {
    final userNameCtrl = TextEditingController();
    final userIdCtrl = TextEditingController();
    final courseNameCtrl = TextEditingController();
    final courseIdCtrl = TextEditingController();

    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Issue Certificate'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        _field(userNameCtrl, 'User Name', Icons.person),
        const SizedBox(height: 10),
        _field(userIdCtrl, 'User ID (UID)', Icons.badge),
        const SizedBox(height: 10),
        _field(courseNameCtrl, 'Course Name', Icons.menu_book),
        const SizedBox(height: 10),
        _field(courseIdCtrl, 'Course ID', Icons.key),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            if (userNameCtrl.text.isEmpty || courseNameCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in required fields.')));
              return;
            }
            await FirestoreService.issueCertificate(
              userId: userIdCtrl.text.trim(), userName: userNameCtrl.text.trim(),
              courseId: courseIdCtrl.text.trim(), courseName: courseNameCtrl.text.trim());
            if (ctx.mounted) { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Certificate issued!'), backgroundColor: Colors.green)); }
          },
          child: const Text('Issue')),
      ]));
  }

  Widget _field(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(controller: ctrl,
      decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: _blue, foregroundColor: Colors.white,
        title: const Text('Certificates', style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _blue, foregroundColor: Colors.white,
        icon: const Icon(Icons.add), label: const Text('Issue Certificate'),
        onPressed: _showIssueCertDialog),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.getAllCertificates(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.card_membership, size: 64, color: Colors.grey),
              SizedBox(height: 12),
              Text('No certificates issued yet.', style: TextStyle(color: Colors.grey))]));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snap.data!.docs.length,
            itemBuilder: (_, i) {
              final doc = snap.data!.docs[i];
              final data = doc.data() as Map<String, dynamic>;
              final issuedAt = data['issuedAt'];
              String dateStr = '';
              if (issuedAt is Timestamp) {
                final d = issuedAt.toDate();
                dateStr = '${d.day}/${d.month}/${d.year}';
              }
              return Container(margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: Container(padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.card_membership, color: Colors.deepPurple)),
                  title: Text(data['courseName'] ?? 'Unknown Course', style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Issued to: ${data['userName'] ?? ''}', style: const TextStyle(fontSize: 12)),
                    Text('Cert #: ${data['certificateNumber'] ?? ''}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    if (dateStr.isNotEmpty) Text('Issued: $dateStr', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ]),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(context: context, builder: (_) => AlertDialog(
                        title: const Text('Delete Certificate'),
                        content: const Text('This cannot be undone.'),
                        actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                          ElevatedButton(onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Delete', style: TextStyle(color: Colors.white)))]));
                      if (confirm == true) await FirestoreService.deleteCertificate(doc.id);
                    }),
                ));
            });
        }),
    );
  }
}