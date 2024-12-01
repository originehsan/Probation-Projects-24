import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  final String token;

  // Constructor to accept email and token
  HomeScreen({required this.email, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: Color(0xFF33D7FF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home Screen",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Email: $email",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Token: $token",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
