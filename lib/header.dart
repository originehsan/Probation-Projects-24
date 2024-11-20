import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 182, 155, 244),
      title: Text(
        " Welcome to EHSAN ALI's PORTFOLIO",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      actions: [
        _buildHeaderButton('Home'),
        _buildHeaderButton('About'),
        _buildHeaderButton('Skills'),
        _buildHeaderButton('Projects'),
        _buildHeaderButton('Contact'),
      ],
      centerTitle: true,
    );
  }

  Widget _buildHeaderButton(String title) {
    return MouseRegion(
      onEnter: (_) {},
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.3)),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
