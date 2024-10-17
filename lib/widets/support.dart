import 'package:flutter/material.dart';

class Appwidgets {
  static TextStyle boldtextstyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontFamily: "assets\fonts\OpenSans-Semibold.ttf",
        fontWeight: FontWeight.bold);
  }

  static TextStyle lighttextstyle() {
    return TextStyle(
        color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500);
  }

  static TextStyle semiboldText() {
    return TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
  }
}
