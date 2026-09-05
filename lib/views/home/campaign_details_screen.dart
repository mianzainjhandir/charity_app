import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modle/campaign_model.dart';
import '../../widgets/custom_button.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final CampaignModel campaign;
  const CampaignDetailsScreen({super.key, required this.campaign});

  Future<void> _toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection('favorites')
        .doc("${user.uid}_${campaign.id}");

    final doc = await favRef.get();

    if (doc.exists) {
      await favRef.delete();
    } else {
      await favRef.set({
        'userId': user.uid,
        'campaignId': campaign.id,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    double progress = campaign.raisedAmount / campaign.targetAmount;
    if (progress > 1.0) progress = 1.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        actions: [
          StreamBuilder<DocumentSnapshot>(
            stream: user == null 
                ? const Stream.empty() 
                : FirebaseFirestore.instance.collection('favorites').doc("${user.uid}_${campaign.id}").snapshots(),
            builder: (context, snapshot) {
              bool isFav = snapshot.hasData && snapshot.data!.exists;
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.black,
                ),
                onPressed: _toggleFavorite,
              );
            }
          ),
          const Gap(10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large Cover Image
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _buildImage(campaign.coverImage, height: 250),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "1 / 2",
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  // Title
                  Text(
                    campaign.title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(15),
                  // Fund Info
                  Text.rich(
                    TextSpan(
                      text: "\$${campaign.raisedAmount.toInt()} ",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "fund raised from \$${campaign.targetAmount.toInt()}",
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  // Progress Bar
                  Stack(
                    children: [
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE87554),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(15),
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "3,488 donators",
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        campaign.expirationDate,
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  const Gap(25),
                  // Description
                  Text(
                    campaign.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                  const Gap(30),
                  // Organize By Card
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFE87554).withOpacity(0.1),
                          child: const Icon(Icons.group_outlined, color: Color(0xFFE87554)),
                        ),
                        const Gap(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Organize by",
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              "Helps organization trust",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
          // Donate Now Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: "Donate now",
              onTap: () {
                Get.snackbar("Thank You!", "Donation processing feature coming soon.",
                    backgroundColor: Colors.orange, colorText: Colors.white);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageStr, {required double height}) {
    if (imageStr.isEmpty) {
      return Container(
        height: height,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: const Icon(Icons.image, color: Colors.grey),
      );
    }

    if (imageStr.startsWith('http')) {
      return Image.network(
        imageStr,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    try {
      Uint8List bytes = base64Decode(imageStr);
      return Image.memory(
        bytes,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return Container(
        height: height,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: const Icon(Icons.broken_image, color: Colors.grey),
      );
    }
  }
}
