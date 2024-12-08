import 'package:flutter/material.dart';
import 'package:sukoon_app/Screens/Username.dart';
import 'package:sukoon_app/Screens/age.dart';
import 'package:sukoon_app/Screens/authscreens/loginScreen.dart';
import 'package:sukoon_app/Screens/authscreens/onboardmain.dart';
import 'package:sukoon_app/Screens/homescreen.dart';
import 'package:sukoon_app/Screens/suvery1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}


