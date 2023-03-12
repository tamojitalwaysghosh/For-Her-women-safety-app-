import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  double fontsize;
  final fontweight;
  String text;
  Color color;

  TextWidget(
      {super.key,
      required this.fontsize,
      required this.fontweight,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle:
            TextStyle(fontSize: fontsize, color: color, fontWeight: fontweight),
      ),
    );
  }
}
