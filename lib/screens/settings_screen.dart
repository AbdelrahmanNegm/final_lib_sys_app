import 'package:flutter/material.dart';
import 'package:library_app/screens/about_us_screen.dart';
import 'package:library_app/screens/notification_screen.dart';
import 'package:library_app/screens/terms_and_conditions_screen.dart';
import 'package:library_app/screens/user_profile_screen.dart';

import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfbeecb),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbeecb),
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.iconsColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          ListTile(
            leading: const Icon(
              Icons.person_outline_rounded,
              color: AppConstants.iconsColor,
              size: 30,
            ),
            title: const Text(
              "Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppConstants.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserProfileScreen()));
              // Navigate to Account screen
            },
          ),
          const Divider(color: AppConstants.primaryColor),
          ListTile(
            leading: const Icon(Icons.notifications_none_sharp,
                color: AppConstants.iconsColor, size: 30),
            title: const Text(
              "Notification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppConstants.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen()));
              // Navigate to Notification settings
            },
          ),
          const Divider(color: AppConstants.primaryColor),
          ListTile(
            leading: const Icon(Icons.description_outlined,
                color: AppConstants.iconsColor, size: 30),
            title: const Text(
              "Terms & Conditions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppConstants.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LibraryTermsScreen()));
              // Navigate to Terms & Conditions screen
            },
          ),
          const Divider(color: AppConstants.primaryColor),
          ListTile(
            leading: const Icon(Icons.info_outline,
                color: AppConstants.iconsColor, size: 30),
            title: const Text(
              "About",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppConstants.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutUsScreen()));
              // Navigate to About screen
            },
          ),
          const Divider(
            color: AppConstants.primaryColor,
          ),
          ListTile(
            leading: const Icon(Icons.logout,
                color: AppConstants.iconsColor, size: 30),
            title: const Text(
              "Logout",
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Logout",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
            // trailing: const Icon(Icons.arrow_forward_ios, size: 16 ,color: AppConstants.primaryColor,),
          ),
        ],
      ),
    );
  }
}
