import 'package:flutter/material.dart';

import 'screen/home.dart';

void main() {
  runApp(const outfitr());
}

class outfitr extends StatelessWidget {
  const outfitr({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'outfitr',
      home: Home(),
    );
  }
}
