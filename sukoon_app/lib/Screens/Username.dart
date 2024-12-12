import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import secure storage
import 'package:sukoon_app/Screens/age.dart'; // Import userAge screen
import 'global_variable.dart'; // Import global variables

class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final TextEditingController _controller = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage(); // Initialize secure storage

  // Method to store the username and email directly when entered by the user
  Future<void> storeUsernameAndEmail(String username) async {
    // Store username and email in FlutterSecureStorage using the 'email' key
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'user_email', value: GlobalVariables.email); // Storing the email as 'email'
    
    // Update the global variable with the entered username
    GlobalVariables.username = username;

    print('Stored username: $username');
    print('Stored email: ${GlobalVariables.email}'); // Email remains unchanged
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
                  'Please enter your name',
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 25, bottom: 20),
                        child: Text(
                          'What we should call you ?',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Alice",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30),
                        child: Container(
                          width: 280,
                          height: 65,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'Enter your name',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Alice",
                                  fontSize: 16),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
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
                      final username = _controller.text.trim();
                      if (username.isNotEmpty) {
                        storeUsernameAndEmail(username);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => userAge()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter username')),
                        );
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Alice",
                          color: Colors.white),
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
