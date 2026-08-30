
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';
import '../../widgets/textfield.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

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
                hintText: "Enter your password",
                isPassword: true,
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    print("Hello");
                  },
                    child: Text("Forgot password ?"),
                )
            ),
            Gap(20),

            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CustomButton(
                text: "Log in",
                onTap: () {
                  // Login logic yahan ayegi
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
          ],
        ),
      ),
    );
  }
}
