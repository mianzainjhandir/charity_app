import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhone;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  XFile? _pickedFile;
  final picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  String selectedCountryCode = "+92";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    
    // Extracting phone and country code if exists
    if (widget.currentPhone.contains(" ")) {
      var parts = widget.currentPhone.split(" ");
      selectedCountryCode = parts[0];
      phoneController = TextEditingController(text: parts.sublist(1).join(" "));
    } else {
      phoneController = TextEditingController(text: widget.currentPhone);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedFile = image;
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() => isLoading = true);
    try {
      String fullPhone = "$selectedCountryCode ${phoneController.text.trim()}";
      
      await _firestore.collection('charity_users').doc(currentUser!.uid).update({
        'name': nameController.text.trim(),
        'phone': fullPhone,
      });

      await currentUser!.updateDisplayName(nameController.text.trim());

      Get.snackbar("Success", "Profile updated successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      
      // Return updated data
      Get.back(result: true);
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile",
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
          "Edit profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFE87554)))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          // Profile Image
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    image: _pickedFile != null
                                        ? DecorationImage(
                                            image: kIsWeb
                                                ? NetworkImage(_pickedFile!.path)
                                                : FileImage(File(_pickedFile!.path))
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: _pickedFile == null
                                      ? Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey.shade400,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          // Full Name
                          _buildLabel("Full Name"),
                          _buildTextField(nameController, "Enter full name"),
                          const Gap(20),
                          // Email
                          _buildLabel("Email address"),
                          _buildTextField(emailController, "Enter email", enabled: false),
                          const Gap(20),
                          // Phone Number
                          _buildLabel("Phone number"),
                          _buildPhoneField(),
                          const Gap(30),
                        ],
                      ),
                    ),
                  ),
                  // Save Button at bottom
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      text: "Save",
                      onTap: _saveProfile,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool enabled = true}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: GoogleFonts.poppins(fontSize: 15, color: enabled ? Colors.black : Colors.grey),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Country Code Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  selectedCountryCode,
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 20),
                const Gap(8),
                Container(width: 1, height: 25, color: Colors.grey.shade300),
              ],
            ),
          ),
          // Number Input
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.poppins(fontSize: 15),
              decoration: const InputDecoration(
                hintText: "(405) 555-0128",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
