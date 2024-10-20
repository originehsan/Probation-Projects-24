import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  final Function() onHomePressed;

  const Wishlist({Key? key, required this.onHomePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onHomePressed,
        ),
      ),
      body: Center(
        child: Text(
          'No items in your wishlist',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}
