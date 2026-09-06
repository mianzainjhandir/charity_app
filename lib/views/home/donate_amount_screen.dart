import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_button.dart';
import '../../modle/campaign_model.dart';

import 'payment_method_screen.dart';

class DonateAmountScreen extends StatefulWidget {
  final CampaignModel campaign;
  const DonateAmountScreen({super.key, required this.campaign});

  @override
  State<DonateAmountScreen> createState() => _DonateAmountScreenState();
}

class _DonateAmountScreenState extends State<DonateAmountScreen> {
  double selectedAmount = 100.00;
  final List<double> quickAmounts = [5.00, 10.00, 25.00, 50.00];

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
          "Donate amount",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Gap(30),
                  Text(
                    "Enter donation amount",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    "How much would you like to top up?",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const Gap(30),
                  
                  // Amount Display Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "\$ ${selectedAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  
                  const Gap(25),
                  
                  // Quick Amount Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: quickAmounts.map((amount) {
                      bool isSelected = selectedAmount == amount;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAmount = amount;
                          });
                        },
                        child: Container(
                          width: 75,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE87554) : const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "\$${amount.toInt()}.00",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Continue Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: CustomButton(
                text: "Continue to payment",
                onTap: () {
                  Get.to(() => PaymentMethodScreen(amount: selectedAmount));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
