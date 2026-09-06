import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modle/campaign_model.dart';
import '../../widgets/custom_button.dart';

class VolunteerRegistrationScreen extends StatefulWidget {
  final CampaignModel campaign;
  const VolunteerRegistrationScreen({super.key, required this.campaign});

  @override
  State<VolunteerRegistrationScreen> createState() => _VolunteerRegistrationScreenState();
}

class _VolunteerRegistrationScreenState extends State<VolunteerRegistrationScreen> {
  String? selectedRole;
  bool isLoading = false;

  final List<String> roles = [
    "Food Distribution",
    "Media & Photography",
    "Medical Support",
    "Transport & Logistics",
    "Social Media Outreach",
    "Fundraising Support"
  ];

  Future<void> _applyAsVolunteer() async {
    if (selectedRole == null) {
      Get.snackbar("Error", "Please select a role",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => isLoading = true);

    try {
      final volunteerId = "${user.uid}_${widget.campaign.id}";
      
      await FirebaseFirestore.instance.collection('volunteers').doc(volunteerId).set({
        'id': volunteerId,
        'campaignId': widget.campaign.id,
        'campaignTitle': widget.campaign.title,
        'userId': user.uid,
        'userName': user.displayName ?? "Anonymous",
        'userEmail': user.email ?? "",
        'role': selectedRole,
        'status': 'pending',
        'appliedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Your application has been sent!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Volunteer Registration",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFE87554)))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select your volunteer role",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  Text(
                    "Choose how you would like to contribute to '${widget.campaign.title}'",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const Gap(30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: roles.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedRole == roles[index];
                        return GestureDetector(
                          onTap: () => setState(() => selectedRole = roles[index]),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFE87554).withOpacity(0.1) : const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFE87554) : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                                  color: isSelected ? const Color(0xFFE87554) : Colors.grey,
                                ),
                                const Gap(15),
                                Text(
                                  roles[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                    color: isSelected ? const Color(0xFFE87554) : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  CustomButton(
                    text: "Submit Application",
                    onTap: _applyAsVolunteer,
                  ),
                  const Gap(20),
                ],
              ),
            ),
    );
  }
}
