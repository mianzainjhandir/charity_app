import 'package:charity_app/views/home/home_screen.dart';
import 'package:charity_app/views/onboarding/intro_page_1.dart';
import 'package:charity_app/views/onboarding/intro_page_2.dart';
import 'package:charity_app/views/onboarding/intro_page_3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../log_in/view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // ================= PAGE VIEW =================
          PageView(
            controller: _controller,

            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 2;
              });
            },

            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // ================= BOTTOM SECTION =================
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // ================= PAGE INDICATOR =================
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,

                  effect: WormEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    spacing: 6,

                    activeDotColor: Colors.deepOrange.shade200,
                    dotColor: Colors.grey.shade300,
                  ),
                ),

                const SizedBox(height: 25),

                // ================= NEXT / GET STARTED BUTTON =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton(
                      onPressed: () {

                        // ================= LAST PAGE =================
                        if (onLastPage) {

                          Get.to(() =>  LogInPage());

                        }

                        // ================= NEXT =================
                        else {

                          _controller.nextPage(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.easeIn,
                          );

                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange.shade300,
                        foregroundColor: Colors.white,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      child: Text(
                        onLastPage ? "Get Started" : "Next",

                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // ================= SKIP =================
                if (!onLastPage) ...[

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },

                    child: const Text(
                      "Skip",

                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}