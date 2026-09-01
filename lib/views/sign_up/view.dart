
import 'package:charity_app/views/log_in/view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';
import '../../widgets/textfield.dart';
import 'logic.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 14, right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign up",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const Gap(5),
                const Text("Create an account and start living your best life."),
                const Gap(10),
                const Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Gap(2),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextField(
                    controller: controller.nameController,
                    hintText: "Enter your Name",
                    helperText: "Please enter your name",
                    keyboardType: TextInputType.name,
                  ),
                ),
                const Gap(10),
                const Text(
                  "Email address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Gap(2),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextField(
                    controller: controller.emailController,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const Gap(10),
                const Text(
                  "Phone Number",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Gap(2),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextField(
                    controller: controller.phoneController,
                    hintText: "Phone Number",
                    helperText: "Please enter your phone number",
                    prefixText: "+92 ",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const Gap(10),
                const Text(
                  "Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextField(
                    controller: controller.passwordController,
                    hintText: "Enter your password",
                    isPassword: true,
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomButton(
                    text: "Sign up",
                    onTap: () {
                      controller.SignUp();
                    },
                  ),
                ),
                const Gap(25),
                SocialLoginButtons(
                  onGoogleTap: () {
                    print("Google Login");
                  },
                  onFacebookTap: () {
                    print("Facebook Login");
                  },
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextButton(
                      onPressed: () {
                        Get.to(() =>  LogInPage());
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: "LogIn",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
