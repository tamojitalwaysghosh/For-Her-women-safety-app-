import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_login/pages/about.dart';

import 'package:google_login/provider/sign_in_provider.dart';
import 'package:google_login/utils/next_screen.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            /* Expanded(
              child: FutureBuilder(
                future: getDocId(),
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: GetUserName(documentid: docIDs[index]),
                      );
                    },
                  );
                },
              ),
            ),*/
            Container(
              padding: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height / 3.8,
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                      sp.isSignedIn ? NetworkImage("${sp.imageUrl}") : null,
                  radius: 60,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'My Profile',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 31, 33, 43),
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Container(
                        padding: EdgeInsets.all(8.6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              // spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                            //borderRadius: BorderRadius.circular(15.0),
                            child: Icon(Icons.person)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    sp.isSignedIn
                        ? Text(
                            "${sp.name}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 31, 33, 43),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            overflow: TextOverflow.visible,
                          )
                        : Text(
                            "Guest User",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 31, 33, 43),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            overflow: TextOverflow.visible,
                          ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Container(
                        padding: EdgeInsets.all(8.6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              // spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                            //borderRadius: BorderRadius.circular(15.0),
                            child: Icon(Icons.email)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    sp.isSignedIn
                        ? Text(
                            "${sp.email}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 31, 33, 43),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            overflow: TextOverflow.visible,
                          )
                        : Text(
                            "Email Section",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 31, 33, 43),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            overflow: TextOverflow.visible,
                          ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Container(
                            padding: EdgeInsets.all(8.6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 248, 248),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  // spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            height: 40,
                            width: 40,
                            child: ClipRRect(
                                //borderRadius: BorderRadius.circular(15.0),
                                child: Icon(Icons.info_outline)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "About For Her",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 31, 33, 43),
                                fontSize: 15.9,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => About())),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Container(
                          padding: EdgeInsets.all(8.6),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                // spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                              //borderRadius: BorderRadius.circular(15.0),
                              child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Container(
                            padding: EdgeInsets.all(8.6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 248, 248),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  // spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            height: 40,
                            width: 40,
                            child: ClipRRect(
                                //borderRadius: BorderRadius.circular(15.0),
                                child: Icon(Icons.logout_outlined)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        sp.isSignedIn
                            ? Text(
                                "Log Out",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 31, 33, 43),
                                      fontSize: 15.9,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            : Text(
                                "Join Now!",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 31, 33, 43),
                                      fontSize: 15.9,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                      ],
                    ),
                    sp.isSignedIn
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.black,
                                      content: Text(
                                        "Do you surely wanna log out?",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            sp.userSignOut();
                                            nextScreenReplace(
                                                context, const LoginScreen());
                                          },
                                          child: Text(
                                            "Yes",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          color: Colors.red.withOpacity(0.3),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          color: Colors.red.withOpacity(0.3),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Container(
                                padding: EdgeInsets.all(8.6),
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      // spreadRadius: 4,
                                      blurRadius: 4,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                    //borderRadius: BorderRadius.circular(15.0),
                                    child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Container(
                                padding: EdgeInsets.all(8.6),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 28, 25, 25),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      // spreadRadius: 4,
                                      blurRadius: 4,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                    //borderRadius: BorderRadius.circular(15.0),
                                    child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
