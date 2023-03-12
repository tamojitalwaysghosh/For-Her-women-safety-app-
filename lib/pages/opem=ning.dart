import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_login/screens/login_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Opening extends StatelessWidget {
  Opening({Key? key}) : super(key: key);

  ///Changed a little bit of buttons styling and text for the thumbnail lol
  ///Thanks for coming here :-)
  final List<PageViewModel> pages = [
    PageViewModel(
        title: 'Always Together',
        body: 'Whenever you fell unsafe,\nthere will be someone for you',
        image: Center(
          child: Image.asset('assets/4.png'),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titleTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Color.fromARGB(255, 28, 25, 25),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        )),
    PageViewModel(
        title: 'SOS message & call',
        body: 'Add Trusted contacts and send \nSOS calls & messages to them',
        image: Center(
          child: Image.asset('assets/5.png'),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titleTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Color.fromARGB(255, 28, 25, 25),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        )),
    PageViewModel(
        title: 'Get nearest Services',
        body: 'Quickly access maps to \ngetnearest emergency services',
        image: Center(
          child: Image.asset('assets/6.png'),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titleTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Color.fromARGB(255, 28, 25, 25),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 130, 20, 12),
        child: IntroductionScreen(
          pages: pages,
          globalBackgroundColor: Colors.white,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: Color.fromARGB(255, 28, 25, 25),
            activeSize: Size.square(20),
            activeColor: Colors.red,
          ),
          showDoneButton: true,
          done: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("Done",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            color: Colors.red,
            size: 25,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
