
import 'package:charity_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';
import '../../widgets/textfield.dart';
import '../forgot_password/view.dart';
import 'logic.dart';

class LogInPage extends StatelessWidget {
 LogInPage({super.key});


  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 14, left: 14,right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Log in",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            Gap(5),
            Text("Log in to your account and access all the features."),
            Gap(10),
            Text("Email address",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            Gap(2),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CustomTextField(
                controller: controller.emailController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Gap(10),
            Text("Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            Gap(5),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CustomTextField(
                controller: controller.passwordController,
                hintText: "Enter your password",
                isPassword: true,
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=> ForgotPassword());
                  },
                    child: Text("Forgot password ?"),
                )
            ),
            Gap(20),

            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CustomButton(
                text: "Log in",
                onTap: () async {
                  bool isLoggedIn = await controller.logIn(); // Login function call
                  if (isLoggedIn) {
                    Get.to(HomeScreen()); // Home screen pe navigate
                  } else {
                    Get.snackbar("Login Failed", "Invalid email or password",
                        backgroundColor: Colors.red, colorText: Colors.white);
                  }
                },
              ),
            ),
            Gap(25),

            SocialLoginButtons(
              onGoogleTap: () {
                print("Google Login");
              },

              onFacebookTap: () {
                print("Facebook Login");
              },
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: "Sign Up",
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
    );
  }
}
