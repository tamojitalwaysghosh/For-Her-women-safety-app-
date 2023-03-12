import 'package:google_fonts/google_fonts.dart';

import 'package:google_login/provider/internet_provider.dart';
import 'package:google_login/provider/sign_in_provider.dart';
import 'package:google_login/screens/bottom_nav.dart';

import 'package:google_login/screens/phoneauth_screen.dart';
import 'package:google_login/utils/config.dart';
import 'package:google_login/utils/next_screen.dart';
import 'package:google_login/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/443.jpg"),
                    height: 400,
                    width: 400,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: const Text("No Boring Forms!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "It's simpler than ever...",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                )
              ],
            ),
          ),

          // roundedbutton
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedLoadingButton(
                onPressed: () {
                  handleGoogleSignIn();
                },
                controller: googleController,
                successColor: Colors.red,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                borderRadius: 10,
                color: Colors.red,
                child: Wrap(
                  children: [
                    Icon(
                      FontAwesomeIcons.google,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Sign in with Google",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    context.read<SignInProvider>().isSignedIn == false;
                  });
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => BottomNav()));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 28, 25, 25),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Join as a guest",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 28, 25, 25),
                          fontSize: 21,
                          fontWeight: FontWeight.normal),
                    ),
                  )),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              // facebook login button
            ],
          )
        ],
      )),
    );
  }

  // handling google sigin in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handling facebookauth

  // handle after signin
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const BottomNav());
    });
  }
}
