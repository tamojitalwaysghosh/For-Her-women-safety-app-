import 'dart:async';

import 'package:google_login/pages/opem=ning.dart';
import 'package:google_login/provider/sign_in_provider.dart';
import 'package:google_login/screens/bottom_nav.dart';
import 'package:google_login/screens/home_screen.dart';
import 'package:google_login/screens/login_screen.dart';
import 'package:google_login/utils/config.dart';
import 'package:google_login/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, Opening())
          : nextScreen(context, BottomNav());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 237, 237),
      body: SafeArea(
        child: Center(
            child: Image(
          image: AssetImage("assets/Logo.png"),
          height: 80,
          width: 80,
        )),
      ),
    );
  }
}
