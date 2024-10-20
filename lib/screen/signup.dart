import 'package:flutter/material.dart';
import 'package:outfitr/screen/Bottomnavigation.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextField('First Name'),
                SizedBox(height: 16.0),
                _buildTextField('Last Name'),
                SizedBox(height: 16.0),
                _buildTextField('Email'),
                SizedBox(height: 16.0),
                _buildTextField('Birthday (YYYY-MM-DD)'),
                SizedBox(height: 16.0),
                _buildTextField('Phone Number'),
                SizedBox(height: 16.0),
                _buildTextField('Password', isObscured: true),
                SizedBox(height: 16.0),
                _buildTextField('Confirm Password', isObscured: true),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    backgroundColor: Colors.grey[300],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Bottomnavigation()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTextField(String label, {bool isObscured = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[800]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[800]!),
        ),
      ),
      obscureText: isObscured,
    );
  }
}
