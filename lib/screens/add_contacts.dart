import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_login/db/db_services.dart';
import 'package:google_login/model/contact.dart';
import 'package:google_login/model/text_widget.dart';
import 'package:google_login/screens/contact_screen.dart';
import 'package:google_login/widgets/constants.dart';
import 'package:google_login/widgets/primary_button.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;
  Box? _box;
  bool valuefirst = false;
  bool isdone = false;
  late TextEditingController _controllerPeople, _controllerMessage;
  String? _message, body;
  String _canSendSMSMessage = 'Check is not run.';
  List<String> people = [];
  bool sendDirect = false;
  bool loctap = false;
  Position? position;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
          databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "contact removed succesfully");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });
    initPlatformState();

    super.initState();
  }

  String location = 'Null, Press Button';
  String Address = 'search';
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
    if (contactList == null) {
      contactList = [];
    }
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              PrimaryButton(
                  title: "Add Trusted Contacts",
                  onPressed: () async {
                    bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactsPage(),
                        ));
                    if (result == true) {
                      showList();
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'swipe tile to add to messaging or delete it',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: StretchMotion(), children: [
                          //settings option
                          SlidableAction(
                            onPressed: (context) async {
                              people.add(contactList![index].number);
                              var box = await Hive.openBox('someBox');
                              box.put('myList', people);

                              //_box!.add(contactList![index].number);

                              isdone = !isdone;
                              setState(() {});
                            },
                            icon: Icons.add,
                            backgroundColor: Color.fromARGB(255, 13, 157, 165),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ]),
                        startActionPane:
                            ActionPane(motion: StretchMotion(), children: [
                          //delete option
                          SlidableAction(
                            onPressed: (context) {
                              deleteContact(contactList![index]);
                            },
                            icon: Icons.delete,
                            backgroundColor: Color.fromARGB(255, 223, 60, 60),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ]),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                    fontsize: 15,
                                    fontweight: FontWeight.w500,
                                    text: contactList![index].name,
                                    color: Color.fromARGB(255, 8, 8, 8)),
                                Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(90)),
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () async {
                                          await FlutterPhoneDirectCaller
                                              .callNumber(
                                                  contactList![index].number);
                                        },
                                        icon: Icon(
                                          Icons.call,
                                          color: Color.fromARGB(
                                              255, 244, 241, 241),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              if (people.isEmpty)
                const SizedBox(height: 0)
              else
                SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          List<Widget>.generate(people.length, (int index) {
                        return _phoneTile(people[index]);
                      }),
                    ),
                  ),
                ),
              ListTile(
                leading: const Icon(Icons.message),
                title: TextField(
                  decoration: const InputDecoration(labelText: 'Add Message'),
                  controller: _controllerMessage,
                  onChanged: (String value) => setState(() {}),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: TextWidget(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontsize: 16,
                          fontweight: FontWeight.w400,
                          text: "Include my Location",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${Address}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 13,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                      value: this.valuefirst,
                      onChanged: (bool? value) async {
                        setState(() {
                          this.valuefirst = value!;
                        });
                        Position position = await _getGeoLocationPosition();
                        location =
                            'Lat: ${position.latitude} , Long: ${position.longitude}';
                        GetAddressFromLatLong(position);
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              PrimaryButton(
                  title: "SEND",
                  onPressed: () {
                    _send();
                  }),
              Visibility(
                visible: _message != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          _message ?? 'No Data',
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _phoneTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
            top: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => people.remove(name)),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    name,
                    textScaleFactor: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> initPlatformState() async {
    _controllerPeople = TextEditingController();
    _controllerMessage = TextEditingController();
  }

  void _send() {
    if (people.isEmpty) {
      setState(() => _message = 'At Least 1 Person or Message Required');
    } else {
      _sendSMS(people);
    }
  }

  Future<void> _sendSMS(List<String> recipients) async {
    try {
      String _result = await sendSMS(
        message: _controllerMessage.text + '\n${Address}',
        recipients: recipients,
        sendDirect: sendDirect,
      );
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<bool> _canSendSMS() async {
    bool _result = await canSendSMS();
    setState(() => _canSendSMSMessage =
        _result ? 'This unit can send SMS' : 'This unit cannot send SMS');
    return _result;
  }
}
