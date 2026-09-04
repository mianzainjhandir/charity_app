import 'package:charity_app/views/home/category_campaigns_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ... categories list stays same ...
    final List<Map<String, dynamic>> categories = [
      {
        "title": "Education",
        "icon": Icons.school_rounded,
        "color": const Color(0xFFF3E5F5), // Light Purple
        "iconColor": Colors.deepPurple,
      },
      {
        "title": "Paramedic",
        "icon": Icons.medical_services_rounded,
        "color": const Color(0xFFFCE4EC), // Light Pink
        "iconColor": Colors.pink,
      },
      {
        "title": "Hospital",
        "icon": Icons.local_hospital_rounded,
        "color": const Color(0xFFE3F2FD), // Light Blue
        "iconColor": Colors.blue,
      },
      {
        "title": "Food",
        "icon": Icons.fastfood_rounded,
        "color": const Color(0xFFFFF3E0), // Light Orange
        "iconColor": Colors.orange,
      },
      {
        "title": "Water",
        "icon": Icons.water_drop_rounded,
        "color": const Color(0xFFE0F7FA), // Light Cyan
        "iconColor": Colors.cyan,
      },
      {
        "title": "Shelter",
        "icon": Icons.home_rounded,
        "color": const Color(0xFFE8F5E9), // Light Green
        "iconColor": Colors.green,
      },
      {
        "title": "Clothing",
        "icon": Icons.checkroom_rounded,
        "color": const Color(0xFFF1F8E9), // Light Lime
        "iconColor": Colors.lightGreen,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Categories",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        const Gap(15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: categories.map((cat) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => CategoryCampaignsScreen(categoryName: cat['title']));
                },
                child: Container(
                  width: 85,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: cat['color'],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        cat['icon'],
                        color: cat['iconColor'],
                        size: 28,
                      ),
                      const Gap(8),
                      Text(
                        cat['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
