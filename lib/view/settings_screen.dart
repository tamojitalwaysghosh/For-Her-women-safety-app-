import 'package:flutter/material.dart';
import 'package:for_her_app/model/settings_card.dart';
import 'package:for_her_app/view/PolicyPage.dart';
import 'package:for_her_app/view/customize_screen.dart';
import 'package:for_her_app/view/info_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: height * .1,
          centerTitle: true,
          title: Text(
            'More',
            style: GoogleFonts.aboreto(
              textStyle: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 19, 1, 7),
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SettingsCard(
                  text: 'Customize SOS',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomizeScreen(),
                      ),
                    );
                  }),
              Divider(
                height: 40,
              ),
              SettingsCard(
                  text: 'About For Her',
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InfoPage(title: 'About For Her', description: '''
“For Her” is a mobile application designed to provide safety and security to women, particularly when they are traveling alone or in an unfamiliar environment. These apps typically come with various features that can help women feel more secure and alert authorities or emergency contacts in case of an emergency.

The app may include features such as- 
\n• Emergency alerts: This feature allows the user to send an SOS message or call for help to their emergency contacts with just a click of a button. 
\n• Real-time tracking: This feature allows the user's family or friends to track their location in real-time, which can be helpful in case of an emergency. 
\n• Safety tips: The app may also provide safety tips and advice to women on how to stay safe while traveling alone or in an unfamiliar environment. 

Overall, For Her is designed to provide women with a sense of security and comfort, particularly when they are traveling alone or in an unfamiliar environment. By providing features such as real-time tracking, emergency alerts, and safety tips, these apps can help women stay safe and secure.

'''),
                      ),
                    );
                  })),
              Divider(
                height: 40,
              ),
              SettingsCard(
                text: 'Give Feedback',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoPage(
                        title: 'Give Feedback',
                        description: '''
If you want to give any feedback regarding the app, you can email us at: rhobustdev@gmail.com
''',
                      ),
                    ),
                  );
                },
              ),
              Divider(
                height: 40,
              ),
              SettingsCard(
                text: 'Read Privacy Policy',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PolicyPage()));
                },
              ),
              Divider(
                height: 40,
              ),
              SettingsCard(
                text: 'Share the App',
                onPressed: () {
                  Share.share(
                    'Check out the Women Safety App: For Her!\n\nProtect yourself with real-time location tracking, emergency alerts, and more. Download "For Her" from the Play Store now!\n\nhttps://play.google.com/store/apps/details?id=com.rohbust.women_safety',
                    subject: 'Share',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
