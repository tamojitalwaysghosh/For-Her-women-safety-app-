import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:for_her_app/view/essential_screen.dart';
import 'package:for_her_app/view/favorite_contacts.dart';
import 'package:for_her_app/view/home_screen.dart';
import 'package:for_her_app/view/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [
    HomeScreen(),
    FavoriteContactsScreen(),
    EssentialScreen(),
    SettingsScreen(),
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
            Icons.sos,
            color: Colors.white,
          ),
          Icon(
            Icons.local_police,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.article,
            color: Colors.white,
          ),
        ],
        height: 50,
        buttonBackgroundColor: Colors.pink,
        color: Colors.pink,
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
