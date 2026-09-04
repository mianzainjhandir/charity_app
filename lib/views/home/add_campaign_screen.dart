import 'dart:convert';
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../widgets/custom_button.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});

  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  String? selectedCategory;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  XFile? coverImage;
  final List<XFile?> smallImages = List.generate(4, (index) => null);
  final ImagePicker picker = ImagePicker();

  bool isLoading = false;

  final List<String> categories = [
    "Education",
    "Paramedic",
    "Hospital",
    "Food",
    "Water",
    "Shelter",
    "Clothing"
  ];

  Future<void> _pickImage(int index) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (image != null) {
      setState(() {
        if (index == -1) {
          coverImage = image;
        } else {
          smallImages[index] = image;
        }
      });
    }
  }

  Future<void> _saveCampaign() async {
    if (titleController.text.isEmpty || 
        selectedCategory == null || 
        amountController.text.isEmpty || 
        dateController.text.isEmpty || 
        coverImage == null) {
      Get.snackbar("Error", "Please fill all fields and add a cover image",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() => isLoading = true);

    try {
      // Convert Image to Base64 String (Alternative to Firebase Storage)
      final bytes = await coverImage!.readAsBytes();
      String base64Image = base64Encode(bytes);

      // Save Data to Firestore
      final user = FirebaseAuth.instance.currentUser;
      final campaignId = DateTime.now().millisecondsSinceEpoch.toString();

      await FirebaseFirestore.instance.collection('campaigns').doc(campaignId).set({
        'id': campaignId,
        'title': titleController.text.trim(),
        'category': selectedCategory,
        'targetAmount': double.parse(amountController.text.trim()),
        'raisedAmount': 0.0,
        'expirationDate': dateController.text,
        'description': descriptionController.text.trim(),
        'coverImage': base64Image,
        'creatorId': user?.uid ?? 'anonymous',
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Campaign published successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
      
      // Fixed navigation error for Web
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE87554),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
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
          "Add campaign",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFE87554)))
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        // Cover Image Placeholder
                        GestureDetector(
                          onTap: () => _pickImage(-1),
                          child: Container(
                            width: double.infinity,
                            height: 160,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(15),
                              image: coverImage != null
                                  ? DecorationImage(
                                      image: kIsWeb
                                          ? NetworkImage(coverImage!.path)
                                          : FileImage(File(coverImage!.path))
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: coverImage == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image_outlined, size: 40, color: Colors.grey),
                                      const Gap(10),
                                      Text(
                                        "Add cover image",
                                        style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        ),
                        const Gap(15),
                        // Small Image Placeholders
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) => _buildSmallImagePlaceholder(index)),
                        ),
                        const Gap(25),
                        Text(
                          "Funding details",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const Gap(15),

                        _buildLabel("Title"),
                        _buildTextField(titleController, "Enter your title here"),

                        const Gap(15),
                        _buildLabel("Category"),
                        _buildCategoryDropdown(),

                        const Gap(15),
                        _buildLabel("Total donation required"),
                        _buildTextField(amountController, "Enter donation amount", 
                            keyboardType: TextInputType.number, suffix: const Text("\$ ", style: TextStyle(fontWeight: FontWeight.bold))),

                        const Gap(15),
                        _buildLabel("Expiration date"),
                        _buildDateField(),

                        const Gap(15),
                        _buildLabel("Description"),
                        _buildTextField(descriptionController, "Write your description", maxLines: 4),
                        
                        const Gap(30),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    text: "Save",
                    onTap: _saveCampaign,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSmallImagePlaceholder(int index) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          image: smallImages[index] != null
              ? DecorationImage(
                  image: kIsWeb
                      ? NetworkImage(smallImages[index]!.path)
                      : FileImage(File(smallImages[index]!.path))
                          as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: smallImages[index] == null
            ? const Icon(Icons.image_outlined, color: Colors.grey, size: 24)
            : null,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text, int maxLines = 1, Widget? suffix}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: GoogleFonts.poppins(fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffix != null ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [suffix]) : null,
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: selectedCategory,
          hint: Text("Select your category", style: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          decoration: const InputDecoration(border: InputBorder.none),
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category, style: GoogleFonts.poppins(fontSize: 15)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCategory = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateController.text.isEmpty ? "Enter expiration date" : dateController.text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: dateController.text.isEmpty ? Colors.grey.shade400 : Colors.black,
              ),
            ),
            const Icon(Icons.calendar_month_outlined, color: Colors.black54, size: 22),
          ],
        ),
      ),
    );
  }
}
