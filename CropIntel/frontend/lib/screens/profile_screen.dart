import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  final nameController =
      TextEditingController(text: 'Farmer');

  final emailController =
      TextEditingController(text: 'test2@cropintel.com');

  bool editing = false;


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }


  void saveProfile() {
    setState(() {
      editing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F8F4),

      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor:
            const Color(0xFF123D2A),

        foregroundColor: Colors.white,
      ),


      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),

          child: Container(
            width: 500,

            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.05),

                  blurRadius: 12,

                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              children: [

                // PROFILE ICON

                const CircleAvatar(
                  radius: 50,

                  backgroundColor:
                      Color(0xFFE7F3EA),

                  child: Icon(
                    Icons.person,

                    size: 55,

                    color:
                        Color(0xFF2E7D32),
                  ),
                ),

                const SizedBox(height: 20),


                const Text(
                  'My Profile',

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 30),


                // NAME

                TextField(
                  controller: nameController,

                  enabled: editing,

                  decoration: InputDecoration(
                    labelText: 'Name',

                    prefixIcon:
                        const Icon(
                      Icons.person_outline,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 18),


                // EMAIL

                TextField(
                  controller: emailController,

                  enabled: false,

                  decoration: InputDecoration(
                    labelText: 'Email',

                    prefixIcon:
                        const Icon(
                      Icons.email_outlined,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),


                // BUTTON

                SizedBox(
                  width: double.infinity,

                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (editing) {
                        saveProfile();
                      } else {
                        setState(() {
                          editing = true;
                        });
                      }
                    },

                    icon: Icon(
                      editing
                          ? Icons.save
                          : Icons.edit,
                    ),

                    label: Text(
                      editing
                          ? 'Save Changes'
                          : 'Edit Profile',
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2E7D32),

                      foregroundColor:
                          Colors.white,

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
}