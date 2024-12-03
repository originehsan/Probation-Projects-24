import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'resetscreen.dart';

class Forgotverification extends StatefulWidget {
  final String email;
  final String token;

  Forgotverification({required this.email, required this.token});

  @override
  _ForgotverificationState createState() => _ForgotverificationState();
}

class _ForgotverificationState extends State<Forgotverification> {
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;  // Track loading state
  String _errorMessage = '';
  String _successMessage = '';

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp() async {
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
        _successMessage = '';
      });

      try {
        final response = await http.post(
          Uri.parse('https://login-signup-page-3z09.onrender.com/user/otp/verify'), // Replace with your backend URL
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': widget.email,
            'otp': otp,
            'token': widget.token,
          }),
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);

          if (responseBody['status'] == true) {
            setState(() {
              _successMessage = 'OTP verified successfully!';
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                  resetToken: responseBody['resetToken'], // Pass the reset token
                ),
              ),
            );
          } else {
            setState(() {
              _errorMessage = 'OTP verification failed. Please try again.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Unexpected error occured';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An unexpected error occurred. Please try again later.';
        });
      } finally {
        setState(() {
          _isLoading = false;  
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter 6 digit OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signupbg.jpg'), // Update the background image path
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0DBAD4),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                      iconSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Enter OTP to reset password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: "Alice"
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: RichText(
                    text: TextSpan(
                      text: "We have sent otp to registered email ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: "Alice",
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF01BBD6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 45,
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      child: Center(
                        child: TextField(
                          controller: otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          onChanged: (value) => _onOtpChanged(value, index),
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 4,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 60),
                Center(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF33D7FF)),
                        )
                      : ElevatedButton(
                          onPressed: verifyOtp,
                          child: Text("Verify OTP", style: TextStyle(fontSize: 22, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width * 0.70, 53),
                            backgroundColor: Color(0xFF33D7FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                if (_successMessage.isNotEmpty)
                  Text(
                    _successMessage,
                    style: TextStyle(color: Colors.green),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
