import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Map<String, String>> notifications = [
      {
        "title": "Double your donation",
        "description": "For a limited time, we are doubling all donations up to 10,000.",
        "time": "30 seconds ago"
      },
      {
        "title": "Donate now and get a free gift",
        "description": "Donate 50 or more now and receive a free gift, such as a t-shirt, water bottle, or hat.",
        "time": "50 Minutes ago"
      },
      {
        "title": "Volunteer your time",
        "description": "Your time is just as valuable as your money. Consider volunteering.",
        "time": "2 hour ago"
      },
      {
        "title": "Executive Director",
        "description": "Donate 100 or more and receive a personalized thank-you note",
        "time": "12 hour ago"
      },
      {
        "title": "Estate plan",
        "description": "Leave a legacy by including our charity in your will give.",
        "time": "a few seconds ago"
      },
    ];

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
          "Notifications",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _buildNotificationCard(
            title: item['title']!,
            description: item['description']!,
            time: item['time']!,
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bell Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFFE87554),
              size: 24,
            ),
          ),
          const Gap(15),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Gap(5),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const Gap(10),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
