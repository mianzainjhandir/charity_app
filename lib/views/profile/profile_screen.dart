
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../log_in/view.dart';

import 'my_cards_screen.dart';
import 'my_profile_screen.dart';
import 'notification_screen.dart';
import 'privacy_policy_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Gap(20),
              // Profile Image
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              const Gap(15),
              // Name
              Text(
                user?.displayName ?? "Ronald richards",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              // Email
              Text(
                user?.email ?? "ronaldrichards@gmail.com",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const Gap(40),
              // Menu Items
              _buildMenuItem(
                icon: Icons.person_outline_rounded,
                title: "My profile",
                onTap: () {
                  Get.to(() => const MyProfileScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.credit_card_outlined,
                title: "My cards",
                onTap: () {
                  Get.to(() => const MyCardsScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                onTap: () {
                  Get.to(() => const NotificationScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.shield_outlined,
                title: "Privacy policy",
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.help_outline_rounded,
                title: "Help & Support",
                onTap: () {
                  _showHelpSupport();
                },
              ),
              _buildMenuItem(
                icon: Icons.delete_outline_rounded,
                title: "Delete Account",
                titleColor: Colors.red,
                onTap: () {
                  _showDeleteAccountDialog();
                },
              ),
              _buildMenuItem(
                icon: Icons.logout_rounded,
                title: "Logout",
                onTap: () {
                  _showLogoutDialog();
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color titleColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(icon, color: titleColor == Colors.red ? Colors.red : Colors.black, size: 24),
              const Gap(15),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: titleColor == Colors.red ? Colors.red.withOpacity(0.5) : Colors.black,
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpSupport() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Help & Support",
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
            ListTile(
              leading: const Icon(Icons.email_outlined, color: Color(0xFFE87554)),
              title: const Text("Email Us"),
              subtitle: const Text("support@charityapp.com"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.phone_outlined, color: Color(0xFFE87554)),
              title: const Text("Call Us"),
              subtitle: const Text("+92 300 1234567"),
              onTap: () {},
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Account", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red)),
        content: Text("Are you sure you want to delete your account? This action cannot be undone.", style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              // Delete logic
              Get.back();
              Get.snackbar("Account Deleted", "Your account has been removed.", backgroundColor: Colors.red, colorText: Colors.white);
            },
            child: Text("Delete", style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Logout", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to logout?", style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(() => LogInPage());
            },
            child: Text("Logout", style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
