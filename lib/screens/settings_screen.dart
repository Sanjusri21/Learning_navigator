import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = AppSettings.darkMode;
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool learningReminders = true;

  String selectedLanguage = "English";
  String selectedGoal = "Career Growth";
  String selectedTheme = "Blue";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppSettings.darkMode ? Colors.grey.shade900 : Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Manage Account"),
            subtitle: const Text("Profile and account details"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(
                    currentName: "Learner",
                    currentEmail: "learner@example.com",
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_reset),
            title: const Text("Change Password"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChangePasswordScreen(),
                ),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Appearance",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
                AppSettings.darkMode = value;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Theme Color"),
            subtitle: Text(selectedTheme),
            trailing: DropdownButton<String>(
              value: selectedTheme,
              items: const [
                DropdownMenuItem(
                  value: "Blue",
                  child: Text("Blue"),
                ),
                DropdownMenuItem(
                  value: "Purple",
                  child: Text("Purple"),
                ),
                DropdownMenuItem(
                  value: "Green",
                  child: Text("Green"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedTheme = value!;
                  if (value == "Blue") {
                    AppSettings.primaryColor = const Color(0xFF2563EB);
                  } else if (value == "Purple") {
                    AppSettings.primaryColor = Colors.purple;
                  } else if (value == "Green") {
                    AppSettings.primaryColor = Colors.green;
                  }
                });
              },
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Push Notifications"),
            value: pushNotifications,
            onChanged: (value) {
              setState(() {
                pushNotifications = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.email),
            title: const Text("Email Notifications"),
            value: emailNotifications,
            onChanged: (value) {
              setState(() {
                emailNotifications = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.alarm),
            title: const Text("Learning Reminders"),
            value: learningReminders,
            onChanged: (value) {
              setState(() {
                learningReminders = value;
              });
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Learning Preferences",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: Text(selectedLanguage),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text("English"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "English";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Hindi"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "Hindi";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Telugu"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "Telugu";
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text("Learning Goal"),
            subtitle: Text(selectedGoal),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text("Career Growth"),
                        onTap: () {
                          setState(() {
                            selectedGoal = "Career Growth";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Interview Preparation"),
                        onTap: () {
                          setState(() {
                            selectedGoal = "Interview Preparation";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Skill Development"),
                        onTap: () {
                          setState(() {
                            selectedGoal = "Skill Development";
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Privacy Policy"),
                  content: const SingleChildScrollView(
                    child: Text(
                      "Learning Navigator respects your privacy. "
                      "Your learning progress, profile information, "
                      "and preferences are stored securely and are "
                      "never shared without your permission.",
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Help & Support"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Contact support at support@learningnavigator.com",
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About App"),
            subtitle: const Text("Learning Navigator v1.0"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}