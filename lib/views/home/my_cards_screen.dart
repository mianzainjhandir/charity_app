import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCardsScreen extends StatelessWidget {
  const MyCardsScreen({super.key});

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
          "My cards",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 28),
            onPressed: () {
              // Add card action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Text(
              "Payment method",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Gap(20),
            _buildCardItem(
              icon: FontAwesomeIcons.paypal,
              iconColor: const Color(0xFF003087),
              title: "Paypal",
              onTap: () {},
            ),
            _buildCardItem(
              icon: FontAwesomeIcons.ccVisa,
              iconColor: const Color(0xFF1A1F71),
              title: "Visa",
              onTap: () {},
            ),
            _buildCardItem(
              icon: FontAwesomeIcons.googlePay,
              iconColor: Colors.black,
              title: "Google pay",
              onTap: () {},
            ),
            _buildCardItem(
              icon: FontAwesomeIcons.applePay,
              iconColor: Colors.black,
              title: "Apple pay",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: FaIcon(icon, color: iconColor, size: 24),
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
