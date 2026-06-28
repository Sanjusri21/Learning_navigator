import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_settings.dart';
import '../models/user_data.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'all_paths_screen.dart';
import 'events_screen.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'learning_history_screen.dart';
import 'achievements_screen.dart';
import 'settings_screen.dart';
import 'feedback_screen.dart';
import 'admin_dashboard_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  const ProfileScreen({super.key, required this.userName, required this.userEmail});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userName;
  late String _userEmail;
  String _selectedAvatar = '👨';
  File? _profileFile;
  final ImagePicker _picker = ImagePicker();
  String _userRole = 'user';
  bool _roleLoaded = false;

  @override
  void initState() {
    super.initState();
    _userName = UserData.name.isNotEmpty ? UserData.name : widget.userName;
    _userEmail = UserData.email.isNotEmpty ? UserData.email : widget.userEmail;
    _loadRole();
  }

  Future<void> _loadRole() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) { setState(() => _roleLoaded = true); return; }
    final role = await AuthService.getUserRole(uid);
    if (mounted) setState(() { _userRole = role; _roleLoaded = true; });
  }

  final Color _blue = const Color(0xFF2563EB);
  final Color _purple = const Color(0xFFA855F7);

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Change Profile Photo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          ListTile(leading: const Icon(Icons.photo_library_outlined), title: const Text('Choose From Gallery'),
            onTap: () { Navigator.pop(context); _pickFromGallery(); }),
          ListTile(leading: const Icon(Icons.camera_alt_outlined), title: const Text('Take a Photo'),
            onTap: () { Navigator.pop(context); _pickFromCamera(); }),
          const Divider(),
          const Padding(padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text('Or choose an avatar', style: TextStyle(color: Colors.grey, fontSize: 13))),
          Wrap(spacing: 14, runSpacing: 14,
            children: ['👨','👩','🧑','👨‍💻','👩‍💻','👨‍🎓'].map((emoji) => GestureDetector(
              onTap: () { setState(() { _selectedAvatar = emoji; UserData.profileImage = null; _profileFile = null; }); Navigator.pop(context); },
              child: CircleAvatar(radius: 28, backgroundColor: const Color(0xFFEEF0FF),
                child: Text(emoji, style: const TextStyle(fontSize: 24))))).toList()),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }

  Future<void> _pickFromGallery() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) { final bytes = await img.readAsBytes(); setState(() { _profileFile = File(img.path); UserData.profileImage = bytes; }); }
  }

  Future<void> _pickFromCamera() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.camera);
    if (img != null) { final bytes = await img.readAsBytes(); setState(() { _profileFile = File(img.path); UserData.profileImage = bytes; }); }
  }

  void _showEditNameDialog() {
    final ctrl = TextEditingController(text: _userName);
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Edit Name'),
      content: TextField(controller: ctrl, autofocus: true,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(onPressed: () {
          if (ctrl.text.trim().isNotEmpty) { setState(() { _userName = ctrl.text.trim(); UserData.name = _userName; }); }
          Navigator.pop(ctx);
        }, child: const Text('Save')),
      ],
    ));
  }

  void _openAdminDashboard() {
    if (_userRole == 'admin') {
     Navigator.push(context, MaterialPageRoute(builder: (_) => AdminDashboardScreen()));
    } else {
      showDialog(context: context, builder: (_) => AlertDialog(
        title: const Row(children: [Icon(Icons.lock, color: Colors.red), SizedBox(width: 8), Text('Access Denied')]),
        content: const Text('You do not have admin privileges.\n\nOnly users with Admin role can access the Admin Dashboard.'),
        actions: [ElevatedButton(onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('OK', style: TextStyle(color: Colors.white)))],
      ));
    }
  }

  void _confirmLogout() {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () async {
          await AuthService.logout();
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false);
        }, child: const Text('Logout', style: TextStyle(color: Colors.red))),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = AppSettings.darkMode;
    final bgColor = dark ? Colors.black : const Color(0xFFF5F5F5);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(backgroundColor: _blue, foregroundColor: Colors.white,
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.logout), tooltip: 'Logout', onPressed: _confirmLogout)]),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 3, selectedItemColor: _blue, unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          else if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AllPathsScreen()));
          else if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const EventsScreen()));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Paths'),
          BottomNavigationBarItem(icon: Icon(Icons.event_outlined), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ]),
      body: SingleChildScrollView(child: Column(children: [
        // Header
        Container(width: double.infinity, padding: const EdgeInsets.fromLTRB(20,30,20,30),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue, _purple])),
          child: Column(children: [
            Stack(children: [
              GestureDetector(onTap: _showAvatarPicker,
                child: CircleAvatar(radius: 52, backgroundColor: Colors.white24,
                  backgroundImage: UserData.profileImage != null ? MemoryImage(UserData.profileImage!) : null,
                  child: UserData.profileImage == null ? Text(_selectedAvatar, style: const TextStyle(fontSize: 40)) : null)),
              Positioned(bottom: 0, right: 0,
                child: GestureDetector(onTap: _showAvatarPicker,
                  child: Container(padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.camera_alt, size: 16, color: _blue)))),
            ]),
            const SizedBox(height: 14),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(child: Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))),
              IconButton(icon: const Icon(Icons.edit, color: Colors.white70, size: 18), onPressed: _showEditNameDialog),
            ]),
            if (_roleLoaded && _userRole == 'admin')
              Container(margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                child: const Text('Admin', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            Text(_userEmail, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen(currentName: _userName, currentEmail: _userEmail)));
                if (result != null && result is Map) setState(() { _userName = result['name'] ?? _userName; _userEmail = result['email'] ?? _userEmail; });
              },
              icon: const Icon(Icons.edit, size: 16), label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: _blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
          ])),
        const SizedBox(height: 20),
        // Stats
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _StatCard('8', 'Paths', Icons.school),
            _StatCard('24', 'Skills', Icons.code),
            _StatCard('156h', 'Learning', Icons.timer),
          ])),
        const SizedBox(height: 20),
        // Learning Section
        _buildSection('Learning', [
          _buildTile(context, Icons.history, 'Learning History', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningHistoryScreen()))),
          _buildTile(context, Icons.emoji_events, 'My Achievements', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementsScreen()))),
          _buildTile(context, Icons.book, 'Course History', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Course History coming soon!')))),
        ]),
        // Account Section
        _buildSection('Account', [
          _buildTile(context, Icons.admin_panel_settings, 'Admin Dashboard', _openAdminDashboard,
            iconColor: _userRole == 'admin' ? Colors.deepPurple : Colors.grey,
            textColor: _userRole == 'admin' ? Colors.deepPurple : Colors.black87),
          _buildTile(context, Icons.settings, 'Settings', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
          _buildTile(context, Icons.feedback_outlined, 'Send Feedback', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen()))),
          _buildTile(context, Icons.notifications_outlined, 'Notification Settings',
            () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification settings coming soon!')))),
          _buildTile(context, Icons.privacy_tip_outlined, 'Privacy Policy', () => showDialog(context: context, builder: (_) => AlertDialog(
            title: const Text('Privacy Policy'),
            content: const SingleChildScrollView(child: Text('Learning Navigator respects your privacy. Your learning progress and profile information are stored securely.')),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))]))),
          _buildTile(context, Icons.logout, 'Logout', _confirmLogout, textColor: Colors.red, iconColor: Colors.red),
        ]),
        const SizedBox(height: 20),
      ])),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(20,4,20,8),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey))),
      Container(margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(children: children)),
      const SizedBox(height: 16),
    ]);
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, VoidCallback onTap,
      {Color iconColor = const Color(0xFF2563EB), Color textColor = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  const _StatCard(this.value, this.label, this.icon);
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(margin: const EdgeInsets.symmetric(horizontal: 4), padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [Icon(icon, color: const Color(0xFF2563EB), size: 22), const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))])));
  }
}