import 'package:google_login/pages/about.dart';
import 'package:google_login/pages/opem=ning.dart';
import 'package:google_login/provider/internet_provider.dart';
import 'package:google_login/provider/sign_in_provider.dart';
import 'package:google_login/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

const String SETTINGS_BOX = "settings";
const String API_BOX = "api_data";
const String FAVORITES_BOX = "favorites_box";

void main() async {
  // initialize the application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  await Hive.openBox('settings');
  await Hive.openBox(SETTINGS_BOX);
  await Hive.openBox(API_BOX);
  await Hive.openBox(FAVORITES_BOX);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
      ),
    );
  }
}
