import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Snack extends StatelessWidget {
  final title;
  final subtitle;
  const Snack({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 239, 239, 239),
            borderRadius: BorderRadius.circular(20)),
        height: 80,
        padding: EdgeInsets.all(8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image:
                    AssetImage('assets/icons8-motivation-daily-quotes-100.png'),
                height: 120,
                // width: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 31, 33, 43),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 31, 33, 43),
                            fontWeight: FontWeight.w400),
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
