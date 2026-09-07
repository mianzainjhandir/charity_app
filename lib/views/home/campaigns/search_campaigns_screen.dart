import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../modle/campaign_model.dart';
import '../../../widgets/campaign_card.dart';

class SearchCampaignsScreen extends StatefulWidget {
  const SearchCampaignsScreen({super.key});

  @override
  State<SearchCampaignsScreen> createState() => _SearchCampaignsScreenState();
}

class _SearchCampaignsScreenState extends State<SearchCampaignsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
          },
          style: GoogleFonts.poppins(fontSize: 16),
          decoration: InputDecoration(
            hintText: "Search campaigns...",
            hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = "";
                });
              },
            ),
        ],
      ),
      body: _searchQuery.isEmpty
          ? _buildEmptyState("Search for campaigns by title")
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('campaigns')
                  .where('title', isGreaterThanOrEqualTo: _searchQuery)
                  .where('title', isLessThanOrEqualTo: '$_searchQuery\uf8ff')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFE87554)));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildEmptyState("No campaigns found matching '$_searchQuery'");
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var campaign = CampaignModel.fromJson(doc.data() as Map<String, dynamic>);
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CampaignCard(campaign: campaign, width: double.infinity),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
