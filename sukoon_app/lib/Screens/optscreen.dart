import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String token;

  OtpScreen({required this.email, required this.token});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> _verifyOtp() async {
    final String otp = otpController.text;
    final String email = widget.email;
    final String token = widget.token;

    if (otp.isEmpty) {
      _showMessage('Please enter the OTP');
      return;
    }

    final Map<String, String> payload = {
      'email': email,
      'otp': otp,
      'token': token,
    };

    final Uri url = Uri.parse('https://login-signup-page-w7f2.onrender.com/user/register/verify');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _showMessage(responseData['message']);

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        final responseData = json.decode(response.body);
        _showMessage(responseData['message']);
      }
    } catch (error) {
      _showMessage('An error occurred. Please try again.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text('Verify OTP'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xFF33D7FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
