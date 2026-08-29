import 'package:charity_app/views/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Charity App',
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
