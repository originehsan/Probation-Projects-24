import 'package:flutter/material.dart';
import 'package:portfolio/Section/contactme.dart';
import 'package:portfolio/footer.dart';
import 'Section/aboutme.dart';
import 'Section/project.dart';
import 'Section/skill.dart';
import 'header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        hintColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 155, 244),
        title: Text(
          'Hello,',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            SizedBox(height: 40),
            AboutMeSection(),
            SizedBox(height: 40),
            SkillSection(),
            SizedBox(height: 40),
            ProjectSection(),
             SizedBox(height: 40),
            ContactSection(),
            SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }
}
