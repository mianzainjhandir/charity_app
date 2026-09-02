import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/textfield.dart';
import '../home/home_screen.dart';
import 'logic.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.currentStep.value == 0) _buildEmailStep(),
                      if (controller.currentStep.value == 1) _buildOTPStep(),
                      if (controller.currentStep.value == 2) _buildResetStep(),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  // STEP 0: Email Input
  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forgot Password",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(10),
        const Text("Enter your email address to receive an OTP code."),
        const Gap(30),
        const Text(
          "Email Address",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Gap(10),
        CustomTextField(
          controller: controller.emailController,
          hintText: "Enter your email",
          keyboardType: TextInputType.emailAddress,
        ),
        const Gap(30),
        CustomButton(
          text: "Send OTP",
          onTap: () => controller.sendOTP(),
        ),
      ],
    );
  }

  // STEP 1: OTP Verification
  Widget _buildOTPStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify OTP",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(10),
        Text(
          "Enter the 4-digit code sent to \n${controller.emailController.text}",
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        const Gap(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => _otpBox(index),
          ),
        ),
        const Gap(40),
        CustomButton(
          text: "Verify",
          onTap: () => controller.verifyOTP(),
        ),
        const Gap(20),
        Center(
          child: TextButton(
            onPressed: () => controller.sendOTP(),
            child: Text(
              "Resend Code",
              style: GoogleFonts.poppins(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _otpBox(int index) {
    return SizedBox(
      height: 60,
      width: 60,
      child: TextField(
        controller: controller.otpControllers[index],
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            Get.focusScope?.nextFocus();
          }
          if (value.isEmpty && index > 0) {
            Get.focusScope?.previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
          ),
        ),
      ),
    );
  }

  // STEP 2: Reset Password
  Widget _buildResetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reset Password",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(10),
        const Text("Create a new strong password for your account."),
        const Gap(30),
        const Text(
          "New Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Gap(10),
        CustomTextField(
          controller: controller.newPasswordController,
          hintText: "Enter new password",
          isPassword: true,
        ),
        const Gap(20),
        const Text(
          "Confirm Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Gap(10),
        CustomTextField(
          controller: controller.confirmPasswordController,
          hintText: "Confirm new password",
          isPassword: true,
        ),
        const Gap(40),
        CustomButton(
          text: "Reset Password",
          onTap: () {
            // After reset, go to Home
            controller.resetPassword();
          },
        ),
      ],
    );
  }
}
