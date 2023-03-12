import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_login/pages/profile.dart';

import 'package:google_login/screens/add_contacts.dart';
import 'package:google_login/screens/articles.dart';
import 'package:google_login/screens/home_screen.dart';

import 'package:google_login/screens/loc.dart';
import 'package:google_login/widgets/constants.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List pages = [
    HomeScreen(),
    AddContactsPage(),
    BlogsScreen(),
    ProfileScreen()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTap,
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.sos,
            color: Colors.white,
          ),
          Icon(
            Icons.article,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        height: 50,
        buttonBackgroundColor: primaryColor,
        color: primaryColor,
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        animationDuration: Duration(milliseconds: 450),
      ),
    );
  }
}
