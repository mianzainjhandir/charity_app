import 'package:charity_app/views/home/home_screen.dart';
import 'package:charity_app/views/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Charity App',
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
      getPages: [
        GetPage(name: '/', page: () => const OnboardingScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
// Fixed the error: Fix Git push failure with HTTP 408 RPC error.