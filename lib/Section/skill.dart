import 'package:flutter/material.dart';

class SkillSection extends StatelessWidget {
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
                    'Skills',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns;
                      double margin;

                      if (constraints.maxWidth > 900) {
                        columns = 5;
                        margin = 30.0;
                      } else if (constraints.maxWidth > 600) {
                        columns = 3;
                        margin = 20.0;
                      } else {
                        columns = 2;
                        margin = 10.0;
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            crossAxisSpacing: margin,
                            mainAxisSpacing: margin,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SkillCard(index);
                          },
                        ),
                      );
                    },
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

class SkillCard extends StatelessWidget {
  final int index;

  SkillCard(this.index);

  @override
  Widget build(BuildContext context) {
    List<String> skillNames = [
      'Flutter',
      'Dart',
      'Java',
      'LeetCode',
      'Android',
    ];
    List<String> imagePaths = [
      'assets/images/flutter.png',
      'assets/images/dart.png',
      'assets/images/java.png',
      'assets/images/leetcode.png',
      'assets/images/android_icon.png',
    ];

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePaths[index],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            skillNames[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
