import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 182, 155, 244),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialImage('assets/images/github.png', 'https://github.com/yourusername'),
              SizedBox(width: 20),
              _buildSocialImage('assets/images/linkedin.png', 'https://linkedin.com/in/yourusername'),
              SizedBox(width: 20),
              _buildSocialImage('assets/images/instagram.png', 'https://instagram.com/yourusername'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '© Ehsan Ali. All rights reserved.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialImage(String imagePath, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
