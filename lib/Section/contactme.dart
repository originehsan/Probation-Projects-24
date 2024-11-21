import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Me',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF5A623),
            ),
          ),
          SizedBox(height: 20),

          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Your Email',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Enter your email address',
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 20),

          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Your Message',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Enter your message or inquiry',
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Message sent!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF5A623),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            child: Text('Connect'),
          ),
        ],
      ),
    );
  }
}
