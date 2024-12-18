import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:for_her_app/model/widgets/text_widget.dart';

class SpeedDialCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final number;
  final image;
  const SpeedDialCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await FlutterPhoneDirectCaller.callNumber(number);
        },
        child: Container(
          //height: 150,
          width: MediaQuery.of(context).size.width * 0.43,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pink,
                  //    Colors.pink,
                  Colors.pink, // Light PinkAccpinkAccent
                  Colors.pinkAccent, // Medium PinkAccpinkAccent
                  Color.fromARGB(255, 240, 124, 163),
                  Colors.pinkAccent, // Dark PinkAccpinkAccent
                  // Colors.pink,
                ],
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 240,
                //width: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        image,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                height: 240,
                //width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black45.withOpacity(0.3),
                      Colors.black54.withOpacity(0.3),
                      Colors.black38.withOpacity(0.3),
                    ],
                    stops: [0.1, 0.5, 0.7, 0.8],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 11, //bottom: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        fontsize: 20,
                        fontweight: FontWeight.w700,
                        text: title,
                        color: Color.fromARGB(255, 219, 216, 216)),
                    TextWidget(
                        fontsize: 16,
                        fontweight: FontWeight.w300,
                        text: subtitle,
                        color: Color.fromARGB(255, 219, 216, 216)),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call),
                    iconSize: 24,
                    color: Colors.white,
                    onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(number);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
