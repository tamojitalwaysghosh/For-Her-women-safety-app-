import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_login/screens/bottom_nav.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 25, 25),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Container(
              margin: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BottomNav())),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Container(
                        //padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Icon(
                            Icons.home_outlined,
                            color: Color.fromARGB(255, 28, 25, 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Text(
                          "About ",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(43, 103, 102, 102),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(43, 103, 102, 102),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
                child: Column(
                  children: [
                    Text(
                      '''For Her is a mobile application designed to provide safety and security to women, particularly when they are traveling alone or in an unfamiliar environment. These apps typically come with various features that can help women feel more secure and alert authorities or emergency contacts in case of an emergency.

The app may include features such as:

Emergency alerts: This feature allows the user to send an SOS message or call for help to their emergency contacts with just a click of a button.

Real-time tracking: This feature allows the user's family or friends to track their location in real-time, which can be helpful in case of an emergency.

Safety tips: The app may also provide safety tips and advice to women on how to stay safe while traveling alone or in an unfamiliar environment.

Self-defense tutorials: The app may also provide self-defense tutorials, which can be helpful in case of an attack or emergency.

If you want to give any feedback regarding the app, you can email us at: paperqteam@gmail.com

Overall, For Her is designed to provide women with a sense of security and comfort, particularly when they are traveling alone or in an unfamiliar environment. By providing features such as real-time tracking, emergency alerts, and safety tips, these apps can help women stay safe and secure.''',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
