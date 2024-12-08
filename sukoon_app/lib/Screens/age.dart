import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:numberpicker/numberpicker.dart';

import 'global_variable.dart';
import 'suvery1.dart';  

class userAge extends StatefulWidget {
  @override
  State<userAge> createState() => _userAgeState();
}

class _userAgeState extends State<userAge> {
  int _currentValue = 18;

  Future<void> sendAge(String age) async {
    final url = ''; 
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'age': age,
        'email': GlobalVariables.email,  // Access global email
        'token': GlobalVariables.token,  // Access global token
      }),
    );

    if (response.statusCode == 200) {
      print('Age successfully submitted: $age');
    } else {
      print('Failed to submit age');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FCFE),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Please enter your age',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Alice',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.asset(
                      'assets/images/Userbg.png',
                      height: 350,
                      width: MediaQuery.of(context).size.width * 0.85,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: NumberPicker(
                          value: _currentValue,
                          minValue: 0,
                          maxValue: 100,
                          axis: Axis.horizontal,
                          onChanged: (value) => setState(() => _currentValue = value),
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          selectedTextStyle: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 4, 101, 180),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final age = _currentValue.toString();
                      if (age.isNotEmpty) {
                        sendAge(age);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Survey1(),  
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select your age')),
                        );
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 22, fontFamily: "Alice", color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      backgroundColor: Color(0xFF23B9FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
