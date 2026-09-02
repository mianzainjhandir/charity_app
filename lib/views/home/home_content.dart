
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Hello,\nEngineer Zain 👋",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              // Notification screen open karni ho to yahan code likhein
            },
            icon: Icon(
              Icons.notifications_none,
              color: Colors.grey,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14,right: 14,top: 8),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200, // 👈 height yahan se adjust karein
              child: Image.asset(
                'assets/images/banner.png',
                fit: BoxFit.cover,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
