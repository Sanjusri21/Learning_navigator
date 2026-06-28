import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_data.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  String selectedAvatar = "👨";
  Uint8List? profileImage;
  final ImagePicker picker = ImagePicker();

  final TextEditingController phoneController =
      TextEditingController(text: "+91 9876543210");

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: UserData.name);
    emailController = TextEditingController(text: UserData.email);
    phoneController.text = UserData.phone;
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _avatarOption("👨"),
              _avatarOption("👩"),
              _avatarOption("🧑"),
              _avatarOption("👨‍💻"),
              _avatarOption("👩‍💻"),
              _avatarOption("👨‍🎓"),
            ],
          ),
        );
      },
    );
  }

  Widget _avatarOption(String avatar) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAvatar = avatar;
        });
        Navigator.pop(context);
      },
      child: CircleAvatar(
        radius: 30,
        child: Text(
          avatar,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        profileImage = bytes;
        UserData.profileImage = bytes;
      });
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        profileImage = bytes;
        UserData.profileImage = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: UserData.profileImage != null
                    ? MemoryImage(UserData.profileImage!)
                    : null,
                child: UserData.profileImage == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text("Camera"),
                          onTap: () {
                            Navigator.pop(context);
                            pickFromCamera();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text("Gallery"),
                          onTap: () {
                            Navigator.pop(context);
                            pickFromGallery();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text("Choose Avatar"),
                          onTap: () {
                            Navigator.pop(context);
                            _showAvatarPicker();
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Change Photo"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserData.name = nameController.text;
                      UserData.email = emailController.text;
                      UserData.phone = phoneController.text;
                      Navigator.pop(
                        context,
                        {
                          'name': UserData.name,
                          'email': UserData.email,
                          'phone': UserData.phone,
                        },
                      );
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}