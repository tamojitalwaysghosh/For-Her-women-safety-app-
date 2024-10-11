import 'package:flutter/material.dart';
import 'package:for_her_app/view/bottom_navbar.dart';

void main() async {
  //The WidgetsFlutterBinding.ensureInitialized() function
  //declares an instance that interacts with the flutter engine.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        primaryColor: Colors.pink,
        useMaterial3: true,
      ),
      home: BottomNavBar(),
    );
  }
}
