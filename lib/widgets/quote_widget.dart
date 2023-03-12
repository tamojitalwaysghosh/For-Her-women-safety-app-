import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteWidget extends StatelessWidget {
  var quote = "";
  var author = "";
  var onShareClick;
  var onLikeClick;
  var onNextClick;
  var onPrClick;
  var onCopy;
  var onFavou;
  var bgColor;
  var icono;
  var onNext;
  bool? islike;
  var onPressed;
  var onTextShare;
  var onImgShare;

  QuoteWidget({
    this.bgColor,
    required this.quote,
    required this.author,
    this.onNextClick,
    this.onPrClick,
    this.onFavou,
    this.onCopy,
    this.onPressed,
    this.icono,
    this.islike,
    this.onImgShare,
    this.onTextShare,
    this.onNext,
    this.onShareClick,
    this.onLikeClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            quote,
            style: GoogleFonts.lora(
              textStyle: TextStyle(
                  color: Color.fromARGB(255, 52, 52, 52),
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Center(
            child: Text(
              author,
              style: GoogleFonts.lora(
                textStyle: TextStyle(
                    color: Color.fromARGB(255, 58, 57, 57),
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
