import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modle/campaign_model.dart';
import '../../widgets/campaign_card.dart';
import '../home/campaigns/add_campaign_screen.dart';
import 'manage_volunteers_screen.dart';

class OrganizerDashboardScreen extends StatelessWidget {
  const OrganizerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
          "Organizer Dashboard",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: user == null
          ? const Center(child: Text("Please login to see your dashboard"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('campaigns')
                  .where('creatorId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, campaignSnapshot) {
                if (campaignSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFE87554)));
                }

                final campaigns = campaignSnapshot.data?.docs.map((doc) => 
                    CampaignModel.fromJson(doc.data() as Map<String, dynamic>)).toList() ?? [];

                double totalRaised = 0;
                for (var c in campaigns) {
                  totalRaised += c.raisedAmount;
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Row
                      Row(
                        children: [
                          _buildStatCard(
                            "Total Raised",
                            "\$${totalRaised.toInt()}",
                            Icons.account_balance_wallet_outlined,
                            const Color(0xFFE87554),
                          ),
                          const Gap(15),
                          _buildStatCard(
                            "Campaigns",
                            campaigns.length.toString(),
                            Icons.campaign_outlined,
                            Colors.blue,
                          ),
                        ],
                      ),
                      const Gap(25),

                      // Volunteer Card
                      _buildVolunteerSummary(user.uid),

                      const Gap(30),

                      // Manage Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Campaigns",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => Get.to(() => const AddCampaignScreen()),
                            icon: const Icon(Icons.add, size: 18),
                            label: Text("Add New", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                            style: TextButton.styleFrom(foregroundColor: const Color(0xFFE87554)),
                          ),
                        ],
                      ),
                      const Gap(15),

                      if (campaigns.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Icon(Icons.folder_open_outlined, size: 60, color: Colors.grey.shade300),
                                const Gap(10),
                                Text("No campaigns created yet", style: GoogleFonts.poppins(color: Colors.grey)),
                              ],
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: campaigns.length,
                          itemBuilder: (context, index) {
                            final campaign = campaigns[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Stack(
                                children: [
                                  CampaignCard(campaign: campaign, width: double.infinity),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () => _showDeleteDialog(campaign.id),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const Gap(15),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerSummary(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('volunteers')
          .where('campaignCreatorId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .snapshots(),
      builder: (context, snapshot) {
        int pendingCount = snapshot.data?.docs.length ?? 0;

        return GestureDetector(
          onTap: () => Get.to(() => const ManageVolunteersScreen()),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.people_outline, color: Color(0xFFE87554), size: 30),
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Volunteer Requests",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$pendingCount requests are waiting for approval",
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(String docId) {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Campaign", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to delete this campaign?", style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('campaigns').doc(docId).delete();
              Get.back();
              Get.snackbar("Deleted", "Campaign removed successfully", backgroundColor: Colors.orange, colorText: Colors.white);
            },
            child: Text("Delete", style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
