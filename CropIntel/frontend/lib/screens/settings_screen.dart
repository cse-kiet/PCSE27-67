import 'package:flutter/material.dart';

import '../services/api_service.dart';

import 'login_screen.dart';
import 'profile_screen.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;

  String language = 'English';


  Future<void> _logout() async {
    await ApiService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }


  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),

      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color(0xFF123D2A),

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 850,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // =========================
                // ACCOUNT
                // =========================

                const Text(
                  'Account',

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 15),


                // PROFILE

                _settingsCard(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle:
                      'View and manage your profile',

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const ProfileScreen(),
                      ),
                    );
                  },
                ),


                // CHANGE PASSWORD

                _settingsCard(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  subtitle:
                      'Update your account password',

                  onTap: () {
                    _showMessage(
                      'Change password coming soon',
                    );
                  },
                ),


                const SizedBox(height: 30),


                // =========================
                // PREFERENCES
                // =========================

                const Text(
                  'Preferences',

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 15),


                // NOTIFICATIONS

                _settingsSwitch(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  subtitle:
                      'Receive farming and market updates',

                  value: notifications,

                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                ),


                // DARK MODE

                _settingsSwitch(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle:
                      'Use dark appearance',

                  value: darkMode,

                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });

                    _showMessage(
                      'Dark mode preference updated',
                    );
                  },
                ),


                // LANGUAGE

                _settingsCard(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: language,

                  onTap: () {
                    _showLanguageDialog();
                  },
                ),


                const SizedBox(height: 30),


                // =========================
                // APP
                // =========================

                const Text(
                  'App',

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 15),


                // ABOUT

                _settingsCard(
                  icon: Icons.info_outline,
                  title: 'About CropIntel',
                  subtitle:
                      'Learn more about CropIntel',

                  onTap: () {
                    _showAboutDialog();
                  },
                ),


                // PRIVACY

                _settingsCard(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle:
                      'Read our privacy policy',

                  onTap: () {
                    _showMessage(
                      'Privacy policy coming soon',
                    );
                  },
                ),


                const SizedBox(height: 30),


                // =========================
                // LOGOUT
                // =========================

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: OutlinedButton.icon(
                    onPressed: _logout,

                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),

                    label: const Text(
                      'Logout',

                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style:
                        OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.red,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // ==================================================
  // SETTINGS CARD
  // ==================================================

  Widget _settingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),

            blurRadius: 8,

            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: onTap,

          borderRadius:
              BorderRadius.circular(14),

          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 5,
            ),

            leading: Container(
              padding:
                  const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color:
                    const Color(0xFFE7F3EA),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Icon(
                icon,

                color:
                    const Color(0xFF1E593C),
              ),
            ),

            title: Text(
              title,

              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            subtitle: Text(
              subtitle,

              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }


  // ==================================================
  // SWITCH
  // ==================================================

  Widget _settingsSwitch({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),

        leading: Container(
          padding:
              const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color:
                const Color(0xFFE7F3EA),

            borderRadius:
                BorderRadius.circular(10),
          ),

          child: Icon(
            icon,

            color:
                const Color(0xFF1E593C),
          ),
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }


  // ==================================================
  // LANGUAGE
  // ==================================================

  void _showLanguageDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Select Language',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              RadioListTile<String>(
                title: const Text('English'),

                value: 'English',

                groupValue: language,

                onChanged: (value) {
                  setState(() {
                    language = value!;
                  });

                  Navigator.pop(context);
                },
              ),

              RadioListTile<String>(
                title: const Text('Hindi'),

                value: 'Hindi',

                groupValue: language,

                onChanged: (value) {
                  setState(() {
                    language = value!;
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  // ==================================================
  // ABOUT
  // ==================================================

  void _showAboutDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [

              Icon(
                Icons.eco,
                color: Color(0xFF2E7D32),
              ),

              SizedBox(width: 10),

              Text('CropIntel'),
            ],
          ),

          content: const Text(
            'CropIntel is an intelligent agriculture platform '
            'designed to help farmers make smarter decisions '
            'using AI-powered crop disease detection, '
            'price prediction and agricultural insights.',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}