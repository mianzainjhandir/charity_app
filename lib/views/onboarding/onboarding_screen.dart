
import 'package:charity_app/views/onboarding/intro_page_1.dart';
import 'package:charity_app/views/onboarding/intro_page_2.dart';
import 'package:charity_app/views/onboarding/intro_page_3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          PageView(
            controller: _controller,
          children: [
           IntroPage1(),
            IntroPage2(),
            IntroPage3()
          ],
        ),
          Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: (){
                        _controller.jumpToPage(2);
                      },
                      child: Text("Skip")),
                  SmoothPageIndicator(controller: _controller, count: 3),
                  GestureDetector(
                      onTap: (){
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      },
                      child: Text("Next")),
                ],
              ))
    ]
      ),
    );
  }
}
