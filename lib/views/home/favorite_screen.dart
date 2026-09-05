import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modle/campaign_model.dart';
import '../../widgets/campaign_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Favorites",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: user == null
          ? const Center(child: Text("Please login to see favorites"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('favorites')
                  .where('userId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFE87554)));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.favorite_border_rounded, size: 80, color: Colors.grey),
                        const Gap(10),
                        Text(
                          "No favorites yet",
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                // Get campaign IDs from favorites
                List<String> favIds = snapshot.data!.docs.map((doc) => doc['campaignId'] as String).toList();

                // Fetch actual campaign details
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('campaigns')
                      .where('id', whereIn: favIds)
                      .snapshots(),
                  builder: (context, campSnapshot) {
                    if (!campSnapshot.hasData) return const SizedBox();

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: campSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = campSnapshot.data!.docs[index];
                        var campaign = CampaignModel.fromJson(doc.data() as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CampaignCard(campaign: campaign),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
