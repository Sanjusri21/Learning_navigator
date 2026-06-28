import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class AdminCourseManagementScreen extends StatefulWidget {
  const AdminCourseManagementScreen({super.key});
  @override
  State<AdminCourseManagementScreen> createState() => _AdminCourseManagementScreenState();
}

class _AdminCourseManagementScreenState extends State<AdminCourseManagementScreen> {
  static const _blue = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: _blue, foregroundColor: Colors.white,
        title: const Text('Course Management', style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _blue, foregroundColor: Colors.white,
        icon: const Icon(Icons.add), label: const Text('Add Course'),
        onPressed: () => _showCourseDialog(context, null, null)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.getAllCourses(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.library_books, size: 64, color: Colors.grey),
              SizedBox(height: 12),
              Text('No courses yet.\nTap + to add one.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))]));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snap.data!.docs.length,
            itemBuilder: (_, i) {
              final doc = snap.data!.docs[i];
              final data = doc.data() as Map<String, dynamic>;
              return _CourseTile(doc: doc, data: data,
                onEdit: () => _showCourseDialog(context, doc.id, data),
                onDelete: () => _confirmDelete(context, doc.id, data['title'] ?? 'Course'),
                onTogglePublish: () => FirestoreService.toggleCoursePublish(doc.id, !(data['published'] as bool? ?? false)));
            });
        }),
    );
  }

  void _showCourseDialog(BuildContext context, String? docId, Map<String, dynamic>? existing) {
    final titleCtrl = TextEditingController(text: existing?['title'] ?? '');
    final descCtrl = TextEditingController(text: existing?['description'] ?? '');
    final durationCtrl = TextEditingController(text: existing?['duration'] ?? '');
    final levelCtrl = TextEditingController(text: existing?['level'] ?? '');
    bool published = existing?['published'] as bool? ?? false;

    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, setS) => AlertDialog(
      title: Text(docId == null ? 'Add Course' : 'Edit Course'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        _field(titleCtrl, 'Course Title', Icons.title),
        const SizedBox(height: 12),
        _field(descCtrl, 'Description', Icons.description, maxLines: 3),
        const SizedBox(height: 12),
        _field(durationCtrl, 'Duration (e.g. 4 weeks)', Icons.timer),
        const SizedBox(height: 12),
        _field(levelCtrl, 'Level (Beginner/Intermediate/Advanced)', Icons.bar_chart),
        const SizedBox(height: 12),
        Row(children: [
          const Text('Published:'),
          Switch(value: published, onChanged: (v) => setS(() => published = v)),
        ]),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            final data = {'title': titleCtrl.text.trim(), 'description': descCtrl.text.trim(),
              'duration': durationCtrl.text.trim(), 'level': levelCtrl.text.trim(), 'published': published};
            if (docId == null) await FirestoreService.addCourse(data);
            else await FirestoreService.updateCourse(docId, data);
            if (ctx.mounted) Navigator.pop(ctx);
          },
          child: Text(docId == null ? 'Add' : 'Save')),
      ],
    )));
  }

  void _confirmDelete(BuildContext context, String docId, String title) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Delete Course'),
      content: Text('Delete "$title"? This cannot be undone.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: () async { await FirestoreService.deleteCourse(docId); if (mounted) Navigator.pop(context); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Delete', style: TextStyle(color: Colors.white))),
      ]));
  }

  Widget _field(TextEditingController ctrl, String hint, IconData icon, {int maxLines = 1}) {
    return TextField(controller: ctrl, maxLines: maxLines,
      decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))));
  }
}

class _CourseTile extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final Map<String, dynamic> data;
  final VoidCallback onEdit, onDelete, onTogglePublish;
  const _CourseTile({required this.doc, required this.data, required this.onEdit, required this.onDelete, required this.onTogglePublish});

  @override
  Widget build(BuildContext context) {
    final published = data['published'] as bool? ?? false;
    return Container(margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.menu_book, color: Colors.orange)),
        title: Text(data['title'] ?? 'Untitled', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(data['description'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Row(children: [
            if ((data['duration'] as String?)?.isNotEmpty == true) ...[
              const Icon(Icons.timer, size: 12, color: Colors.grey), const SizedBox(width: 3),
              Text(data['duration'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.grey)), const SizedBox(width: 8)],
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: published ? Colors.green.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
              child: Text(published ? 'Published' : 'Draft', style: TextStyle(fontSize: 10, color: published ? Colors.green : Colors.grey))),
          ]),
        ]),
        trailing: PopupMenuButton<String>(onSelected: (v) {
          if (v == 'edit') onEdit();
          else if (v == 'delete') onDelete();
          else if (v == 'publish') onTogglePublish();
        }, itemBuilder: (_) => [
          PopupMenuItem(value: 'edit', child: Row(children: const [Icon(Icons.edit, size: 16), SizedBox(width: 8), Text('Edit')])),
          PopupMenuItem(value: 'publish', child: Row(children: [Icon(published ? Icons.visibility_off : Icons.visibility, size: 16), const SizedBox(width: 8), Text(published ? 'Unpublish' : 'Publish')])),
          PopupMenuItem(value: 'delete', child: Row(children: const [Icon(Icons.delete, size: 16, color: Colors.red), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.red))])),
        ])));
  }
}