import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.8;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: Container(
              width: containerWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: constraints.maxWidth < 600 ? 150 : 250,
                        height: constraints.maxWidth < 600 ? 150 : 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/images/profilimg.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: 20),

                      Expanded(
                        child: Text(
                          'My name is Ehsan Ali.\n'
                          'I am an application developer with a passion for programming.\n'
                          'I have a keen eye for design and enjoy creating seamless, user-friendly experiences.',
                          style: TextStyle(
                            fontSize: constraints.maxWidth > 600
                                ? 20
                                : constraints.maxWidth > 400
                                    ? 18
                                    : 16,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(221, 9, 59, 122),
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
