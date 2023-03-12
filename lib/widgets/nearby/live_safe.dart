import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_login/widgets/nearby/bus_station.dart';
import 'package:google_login/widgets/nearby/hospital.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_login/widgets/nearby/pharmacy.dart';
import 'package:google_login/widgets/nearby/police_station.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'something went wrong! call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 0,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        // controller: controller,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: PoliceStationCard(onMapFunction: openMap),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: HospitalCard(onMapFunction: openMap),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: PharmacyCard(onMapFunction: openMap),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: BusStationCard(onMapFunction: openMap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
