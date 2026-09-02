
import 'package:charity_app/views/home/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_nevigation_appbar.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Alag alag tabs ke mukhtalif screens ya contents
  final List<Widget> _screens = [
    const HomeContent(),
    const Center(child: Text('Favorite Screen Content', style: TextStyle(fontSize: 20))),
    const Center(child: Text('History Screen Content', style: TextStyle(fontSize: 20))),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_selectedIndex], // Selected tab ka content yahan show hoga

      // Center Floating Action Button (+)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yahan '+' button ka action likhein
        },
        backgroundColor: const Color(0xFFE87554),
        elevation: 4.0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Separated Custom Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onAddPressed: () {
          // Optional callback agar plus button ko bhi bottom bar se handle karna ho
        },
      ),
    );
  }
}





//Now i am starting working for home screen..