import 'dart:convert';

import 'package:google_login/widgets/quote_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_login/model/contact.dart';
import 'package:google_login/model/text_widget.dart';
import 'package:google_login/screens/emergency.dart';
import 'package:google_login/widgets/constants.dart';
import 'package:google_login/widgets/nearby/live_safe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = 'Null, Press Button';
  String Address = 'search';
  List<TContact>? contacts;

  Box? box;

  var apiURL = "https://type.fit/api/quotes";

  PageController controller = PageController();
  //final screenShotController = ScreenshotController();
  final _myBox = Hive.box('settings');

  Future<List<dynamic>> getPost() async {
    final response = await http.get(Uri.parse(apiURL));
    return postFromJson(response.body);
  }

  List<dynamic> postFromJson(String str) {
    List<dynamic> jsonData = json.decode(str);
    jsonData.shuffle();
    return jsonData;
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextWidget(
                color: Color.fromARGB(255, 49, 48, 48),
                fontsize: 24,
                fontweight: FontWeight.bold,
                text: "Hey There!",
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextWidget(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontsize: 20,
                          fontweight: FontWeight.w400,
                          text: "My Location",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            Address,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 20, bottom: 10),
                    child: ElevatedButton(
                        onPressed: () async {
                          Position position = await _getGeoLocationPosition();
                          location =
                              'Lat: ${position.latitude} , Long: ${position.longitude}';
                          GetAddressFromLatLong(position);
                        },
                        child: Text('Get Location')),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextWidget(
                color: Color.fromARGB(255, 32, 32, 32),
                fontsize: 20,
                fontweight: FontWeight.w400,
                text: "Explore Nearby",
              ),
            ),
            LiveSafe(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextWidget(
                color: Color.fromARGB(255, 32, 32, 32),
                fontsize: 20,
                fontweight: FontWeight.w400,
                text: "Emergency",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Emergency(),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  //height: 00,
                  //width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: TextWidget(
                text: "Made with ❤️ \n   by PaperQ",
                fontsize: 24,
                fontweight: FontWeight.bold,
                color: Color.fromARGB(194, 147, 146, 146),
              ))),
            )
          ],
        ),
      ),
    );
  }
}
