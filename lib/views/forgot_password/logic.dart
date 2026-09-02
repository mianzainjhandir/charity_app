import 'package:charity_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Current Step: 0 = Email, 1 = OTP, 2 = Reset Password
  var currentStep = 0.obs;

  // Controllers
  final emailController = TextEditingController();
  final List<TextEditingController> otpControllers = 
      List.generate(4, (index) => TextEditingController());
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  String get otpCode => otpControllers.map((e) => e.text).join();

  // Move to OTP Step
  void sendOTP() {
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Please enter a valid email address",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    
    // Mock sending OTP
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      currentStep.value = 1;
      Get.snackbar("Success", "OTP sent to your email",
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  // Move to Reset Password Step
  void verifyOTP() {
    if (otpCode.length < 4) {
      Get.snackbar("Error", "Please enter a valid 4-digit OTP",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Mock verification
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      currentStep.value = 2;
    });
  }

  // Final Reset and go to Home
  void resetPassword() {
    if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Mock Reset
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar("Success", "Password reset successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      
      // Navigate to Home
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
