import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsCard extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const SettingsCard({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent, // Background color of the button
        padding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 20), // Padding around the button text
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            //textAlign: TextAlign.start,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(247, 255, 255, 255),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(247, 255, 255, 255),
          ),
        ],
      ),
    );
  }
}
