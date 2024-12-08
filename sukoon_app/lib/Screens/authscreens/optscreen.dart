import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sukoon_app/Screens/Username.dart';  // Import Username screen
import '../global_variable.dart';

class OtpScreen extends StatefulWidget {
  // Constructor without parameters
  OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  Future<void> _verifyOtp() async {
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      setState(() {
        _isLoading = true;
      });

      final email = GlobalVariables.email;  
      final token = GlobalVariables.token; 

      final Map<String, String> payload = {
        'email': email,
        'otp': otp,
        'token': token,
      };

      final Uri url = Uri.parse('https://login-signup-page-3z09.onrender.com/user/register/verify');

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          _showMessage(responseData['message']);

          // Pass the email and token to the Username screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Username(
              ),
            ),
          );
        } else {
          final responseData = json.decode(response.body);
          _showMessage(responseData['message']);
        }
      } catch (error) {
        _showMessage('An error occurred. Please try again.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter 6 digit OTP")));
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signupbg.jpg'),
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
                    "Verify Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: "Alice"
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Verify your account by entering the verification code we sent to ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: "Alice",
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: GlobalVariables.email, 
                          style: TextStyle(
                            fontSize: 16,
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
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF33D7FF)), // Custom color
                        )
                      : ElevatedButton(
                          onPressed: _verifyOtp,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
