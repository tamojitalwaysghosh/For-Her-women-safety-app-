import 'package:flutter/material.dart';
import 'package:google_login/screens/emergencies/ambulance.dart';
import 'package:google_login/screens/emergencies/army.dart';
import 'package:google_login/screens/emergencies/fire.dart';
import 'package:google_login/screens/emergencies/police.dart';
import 'package:google_login/screens/emergencies/polosk.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Police(
            title: 'Police',
            subtitle: "Tap here or dial 1-0-0",
            image: "assets/e1.jpg",
            number: "100",
          ),
          Police(
            title: 'Ambulance',
            subtitle: "Tap here or dial 1-0-2",
            image: "assets/e5.jpg",
            number: "102",
          ),
          Police(
            title: 'Fire Brigade',
            subtitle: "Tap here or dial 1-0-1",
            image: "assets/e3.jpg",
            number: "101",
          ),
          Police(
            title: 'Disaster Management',
            subtitle: "Tap here or dial 1-0-8",
            image: "assets/e4.jpg",
            number: "108",
          ),
        ],
      ),
    );
  }
}
