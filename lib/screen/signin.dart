import 'package:flutter/material.dart';
import 'Bottomnavigation.dart';
import 'signup.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.transparent,
        elevation: 0, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logos/logo3.jpeg',
              height: 100,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.green),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[800]!),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[800]!),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.orange,
                backgroundColor: Colors.grey[300],
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Bottomnavigation()),
                );
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
                backgroundColor: Colors.grey[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
