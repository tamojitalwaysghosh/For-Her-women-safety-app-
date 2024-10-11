import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_her_app/model/Fav_contact/fav_contact.dart';
import 'package:for_her_app/model/dbHelper/dbHelper.dart';
import 'package:for_her_app/model/sos_card.dart';
import 'package:for_her_app/view/Speed_Dial.dart';
import 'package:for_her_app/view/customize_screen.dart';
import 'package:for_her_app/view/favorite_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Telephony telephony = Telephony.instance;
  PermissionStatus _locationPermissionStatus = PermissionStatus.denied;
  Future<void> _sendSMS(String message, List<String> recipients) async {
    try {
      for (String recipient in recipients) {
        await Telephony.instance.sendSms(
          to: recipient,
          message: message,
        );
      }
      _showSnackBar('Message sent successfully to all recipients!');
    } on PlatformException catch (error) {
      print('Error sending SMS: ${error.message}');
      _showSnackBar('Error sending SMS: ${error.message}');
    }
  }

  Position? currentPosition;
  String? currentAddress;

  Future<void> _getCurrentLocation() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (currentPosition != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude,
          currentPosition!.longitude,
        );
        // currentAddress = placemarks.first.toString();
        currentAddress =
            '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.subLocality}- ${placemarks.first.postalCode}';
        setState(() {}); // Trigger UI update
        //_showSnackBar('Location Updated');
      }
    } on PlatformException catch (e) {
      //_showSnackBar('e.message.toString()');
      _showSnackBar(
          'Please check your Internet connection\nOr, restart the app');
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    _getCurrentLocation();
    setState(() {
      _locationPermissionStatus = status;
    });
  }

  Future<void> _checkInternetConnectivity() async {
    try {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print('Internet connected');
        //_showSnackBar('Internet connected');
      }
    } on SocketException catch (_) {
      print('No internet connection');
      _showSnackBar('No internet connection');
      setState(() {
        currentAddress = 'Unavailable';
      });
    }
  }

  Future<void> openMap(String location) async {
    String query = Uri.encodeComponent(location);
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$query near me';
    final Uri url = Uri.parse(googleUrl);
    try {
      await launch(url.toString());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong! Call emergency number'),
      ));
    }
  }

  // Function to show toast
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // You can adjust the duration
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Do something when the user taps on the action
          },
        ),
      ),
    );
  }

  late Future<List<FavContact>> _futureFavoriteContacts;

  String _savedSOSText = 'I Need Help';
// Load the saved SOS text
  Future<void> _loadSavedSOSText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedSOSText = prefs.getString('sosText') ?? '';
    });
  }

  Future<void> _loadFavContacts() async {
    _futureFavoriteContacts = DbHelper.getFavContacts();
    _loadSavedSOSText();
  }

  Future<void> _refreshData() async {
    // Add the logic to refresh data here
    _requestLocationPermission();
    await _getCurrentLocation();
    await _checkInternetConnectivity();
    await _loadFavContacts();
    _loadSavedSOSText();
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Request location permission when the app starts
    _getCurrentLocation();
    _checkInternetConnectivity();
    _loadFavContacts();
    // Load the saved SOS text when the page is initialized
    _loadSavedSOSText();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh the contact list when the dependencies (e.g., Navigator) change
    _loadFavContacts();
    _loadSavedSOSText();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .1,
        centerTitle: true,
        title: Text(
          'For Her',
          style: GoogleFonts.aboreto(
            textStyle: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 19, 1, 7),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          children: [
            Container(
              height: height * 0.18,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.pink,
                    //    Colors.pink,
                    Colors.pink, // Light PinkAccpinkAccent
                    Colors.pinkAccent, // Medium PinkAccpinkAccent
                    Color.fromARGB(255, 240, 124, 163),
                    Colors.pinkAccent, // Dark PinkAccpinkAccent
                    // Colors.pink,
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Location',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: width * .6,
                          child: Text(
                            currentAddress ?? 'Fetching Location...',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => openMap(currentAddress!),
                          child: Icon(Icons.pin_drop_outlined),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.pinkAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _showSnackBar('Refreshing Current Location');
                            _getCurrentLocation();
                            _showSnackBar('Location Updated');
                          },
                          child: Icon(Icons.refresh),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.pinkAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Speed Dial',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 19, 1, 7),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SpeedDial(),
            SizedBox(
              height: height * .04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Emergency',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 19, 1, 7),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            FutureBuilder<List<FavContact>>(
              future: _futureFavoriteContacts,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Error fetching contacts: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  final contacts = snapshot.data!;
                  List<String> allPhoneNumbers = contacts
                      .map((contact) => contact.phoneNumbers.split(', '))
                      .expand((numbers) => numbers)
                      .toList();
                  return SOSCard(
                    text: _savedSOSText,
                    onShare: () {
                      Share.share(
                          '${_savedSOSText}\n${currentAddress}\nLatitude: ${currentPosition!.latitude}\nLongitude: ${currentPosition!.longitude}',
                          subject: _savedSOSText);
                    },
                    onContactTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteContactsScreen(),
                          ));

                      await _loadFavContacts();
                    },
                    onSOSTap: () async {
                      // Load the saved SOS text
                      //await _loadSavedSOSText();

                      // Navigate to CustomizeScreen
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomizeScreen(),
                        ),
                      );

                      // Optionally, reload data or perform any actions needed after returning
                      await _loadSavedSOSText();
                    },
                    numberOfContacts: contacts.length.toString(),
                    onPressed: () async {
                      bool? permissionsGranted =
                          await telephony.requestPhoneAndSmsPermissions;
                      if (permissionsGranted!) {
                        // Create a confirmation dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Send SOS'),
                              content: Text(
                                  'Are you sure you want to send an SOS message to selected contacts?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    await _sendSMS(
                                      'I Need HELP!\n${currentAddress}\nLatitude: ${currentPosition!.latitude}\nLongitude: ${currentPosition!.longitude}',
                                      allPhoneNumbers, // Pass the list of phone numbers here
                                    );
                                  },
                                  child: Text('Send'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        _showSnackBar('Permission Not Given');
                      }
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
