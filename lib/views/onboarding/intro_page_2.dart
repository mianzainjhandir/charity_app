import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/girl.png',
                  width: 280,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Make a difference in the \n lives of others.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Lets make the world batter place. One act of\n kindness at a time. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
