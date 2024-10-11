import 'package:flutter/material.dart';
import 'package:for_her_app/model/widgets/Speed_Call.dart';

class SpeedDial extends StatelessWidget {
  const SpeedDial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SpeedDialCard(
            title: 'Police',
            subtitle: "Dial 1-0-0",
            image: "assets/e1.jpg",
            number: "100",
          ),
          SpeedDialCard(
            title: 'Ambulance',
            subtitle: "Dial 1-0-2",
            image: "assets/e5.jpg",
            number: "102",
          ),
          SpeedDialCard(
            title: 'Fire \nBrigade',
            subtitle: "Dial 1-0-1",
            image: "assets/e3.jpg",
            number: "101",
          ),
          SpeedDialCard(
            title: 'Disaster \nManagement',
            subtitle: "Dial 1-0-8",
            image: "assets/e4.jpg",
            number: "108",
          ),
        ],
      ),
    );
  }
}
