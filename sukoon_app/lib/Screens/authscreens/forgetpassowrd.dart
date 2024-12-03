import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sukoon_app/Screens/authscreens/forgotverification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sukoon_app/Screens/authscreens/loginScreen.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  String _successMessage = '';

  Future<void> requestOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _successMessage = '';
    });

    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email.';
        _isLoading = false;
      });
      return;
    }

    if (!EmailValidator.validate(email)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address.';
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://login-signup-page-3z09.onrender.com/user/forget/password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          setState(() {
            _successMessage = responseBody['message'];
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Forgotverification(
                email: email,
                token: responseBody['token'],
              ),
            ),
          );
        } else {
          setState(() {
            _errorMessage = 'Failed to send OTP. Please try again later.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'An error occurred while processing your request. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signupbg.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Alice',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xCC4B84926E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: requestOtp,
                              child: Text('Send OTP',style: TextStyle(color: Colors.white,fontFamily: "Alice"),),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                                backgroundColor: Color(0xFF33D7FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                      SizedBox(height: 20),
                      if (_successMessage.isNotEmpty)
                        Text(
                          _successMessage,
                          style: TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 8, 73, 135),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alice",
                          fontSize: 20,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           Navigator.pushReplacement(
              context,
            MaterialPageRoute(
              builder: (context) => LoginScreen() 
            ),
          );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
