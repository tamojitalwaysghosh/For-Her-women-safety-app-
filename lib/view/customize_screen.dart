import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  TextEditingController _sosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load the saved SOS text when the screen is initialized
    _loadSOSText();
  }

  // Load the saved SOS text
  void _loadSOSText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSOSText = prefs.getString('sosText');

    // Check if saved SOS text is null
    if (savedSOSText == null) {
      // Set default SOS text in SharedPreferences
      await prefs.setString('sosText', 'I Need Help!!!');
      // Set default SOS text in the text controller
      setState(() {
        _sosController.text = 'I Need Help!!!';
      });
    } else {
      // Set saved SOS text in the text controller
      setState(() {
        _sosController.text = savedSOSText;
      });
    }
  }

  // Save the SOS text
  void _saveSOSText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sosText', _sosController.text);

    // Show a Snackbar to indicate that the SOS text has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('SOS Text Saved!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .1,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Customize SOS',
          style: GoogleFonts.aboreto(
            textStyle: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 19, 1, 7),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            TextField(
              controller: _sosController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Enter SOS Text',
                hintText: 'I Need Help',
                suffixIcon: _sosController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _sosController.clear();
                        },
                        icon: Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (_sosController.text.isNotEmpty) {
                  _saveSOSText();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please write a messaeg!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pinkAccent, // Text color
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
