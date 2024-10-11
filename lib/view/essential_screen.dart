import 'package:flutter/material.dart';
import 'package:for_her_app/model/widgets/Grid_Item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EssentialScreen extends StatelessWidget {
  final List<GridItem> items = [
    GridItem('Pharmacy', Icons.local_pharmacy),
    GridItem('Library', Icons.local_library),
    GridItem('Hospital', Icons.local_hospital),
    GridItem('Police Station', Icons.local_police),
    GridItem('ATM', Icons.atm),
    GridItem('Ambulance\nServices', Icons.local_hospital_outlined),
    GridItem('Bus Station', Icons.directions_bus),
    GridItem('Grocery Store', Icons.shopping_cart),
    GridItem('Restaurant', Icons.restaurant),
    GridItem('Cafe', Icons.local_cafe),
    GridItem('Gym', Icons.fitness_center),
    GridItem('Laundry', Icons.local_laundry_service),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .1,
        centerTitle: true,
        title: Text(
          'Essentials',
          style: GoogleFonts.aboreto(
            textStyle: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 19, 1, 7),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () =>
                openMap(items[index].title, context), // Open Google Maps
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    items[index].icon,
                    size: 50.0,
                    color: Colors.pink,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    items[index].title,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 19, 1, 7),
                          fontWeight: FontWeight.w400),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> openMap(String location, BuildContext context) async {
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
}
