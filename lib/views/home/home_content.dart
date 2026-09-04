
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modle/campaign_model.dart';
import '../../widgets/campaign_card.dart';
import '../../widgets/categories_widget.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Hello,\nEngineer Zain 👋",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Notification screen logic
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.grey,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.asset(
                    'assets/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            const Gap(10),
            const CategoriesWidget(),
            const Gap(25),

            // Most Popular Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most popular",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "View all",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),

            // Real-time Campaigns from Firestore
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('campaigns')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "No campaigns found. Add one!",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 310, // Adjusted height for CampaignCard
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var campaign = CampaignModel.fromJson(doc.data() as Map<String, dynamic>);
                      return CampaignCard(campaign: campaign);
                    },
                  ),
                );
              },
            ),

            const Gap(30),
          ],
        ),
      ),
    );
  }
}
