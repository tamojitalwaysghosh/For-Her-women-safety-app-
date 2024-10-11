import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SOSCard extends StatelessWidget {
  final String numberOfContacts;
  final VoidCallback onPressed;
  final VoidCallback onShare;
  final VoidCallback onContactTap;
  final VoidCallback onSOSTap;
  final String text;

  const SOSCard({
    Key? key,
    required this.numberOfContacts,
    required this.onPressed,
    required this.onShare,
    required this.onContactTap,
    required this.onSOSTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.4, color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: onContactTap,
                        child: Row(
                          children: [
                            Text(
                              numberOfContacts,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Contacts selected',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 19, 1, 7),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: onSOSTap,
                        child: Text(
                          text,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.pinkAccent,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.share),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  'Send SOS',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 242, 241, 241),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
