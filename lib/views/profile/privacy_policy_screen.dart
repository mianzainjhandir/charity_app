import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          "Privacy policy",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: "1. Types of data we collect",
              content: "Duis tristique diam nunc. Sed at tincidunt orci. Mauris eget congue leo. Cras varius at ante vitae convallis. Duis semper magna nec tortor tincidunt, id tincidunt quam blandit. Vivamus vehicula dictum magna quis eleifend. Fusce ac odio ac nibh tempus euismod. Nullam bibendum velit et ex facilisis maximus. Donec vesed commodo. Vivamus sollicitudin risus quam",
            ),
            const Gap(25),
            _buildSection(
              title: "2. Use of your personal data",
              content: "Sed sollicitudin nisi mollis libero consectetur rutrum. Nam maximus mollis nisl quis facilisis. Integer fermentum commodo nibh. Ut mollis tincidunt hendrerit. Duis ipsum velit, maximus sed commodo imperdiet, dapibus id velit. Nullam in maximus enim. Pellentesque vulputate nisi sit amet lacus pulvinar finibus. Nullam sit amet enim id nibh volutpat gravida vitae in orci. Quisque nibh nisl, congue in ex a, ultricies ultrices metus.",
            ),
            const Gap(25),
            _buildSection(
              title: "3. Disclosure of your personal data",
              content: "Sed sollicitudin nisi mollis libero consectetur rutrum. Nam maximus mollis nisl quis facilisis. Integer fermentum commodo nibh. Ut mollis tincidunt hendrerit. Duis ipsum velit, maximus sed commodo imperdiet, dapibus id velit. Nullam in maximus enim. Pellentesque vulputate nisi sit amet lacus pulvinar finibus. Nullam sit amet enim id nibh volutpat gravida vitae in orci. Quisque nibh nisl, congue in ex a, ultricies ultrices metus. Maecenas egestas eu ligula sed commodo. Vivamus sollicitudin risus quam Maecenas egestas eu ligula sed commodo. Vivamus sollicitudin risus quam",
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const Gap(10),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
