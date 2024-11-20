import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectSection extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {
      'name': 'Ecommerce App',
      'image': 'assets/images/outfitrlogo2.jpeg',
      'url': 'https://github.com/originehsan/Probation-Projects-24/tree/ehsan',
    },
    {
      'name': 'Todo App',
      'image': 'assets/images/quizimg.png',
      'url': 'https://github.com/originehsan/Probation-Projects-24/tree/ehsan_t2',
    },
    {
      'name': 'Quizz App',
      'image': 'assets/images/quizify2.png',
      'url': 'https://github.com/originehsan/Probation-Projects-24/tree/ehsan_t3',
    },
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;
        double margin;

        if (constraints.maxWidth > 900) {
          columns = 3;
          margin = 30.0;
        } else if (constraints.maxWidth > 600) {
          columns = 2;
          margin = 20.0;
        } else {
          columns = 1;
          margin = 10.0;
        }

        double gridWidth = constraints.maxWidth * 0.7;
        double leftRightPadding = (constraints.maxWidth - gridWidth) / 2;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: leftRightPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: gridWidth,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: margin,
                    mainAxisSpacing: margin,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];

                    return GestureDetector(
                      onTap: () => _launchURL(project['url']!),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.asset(
                                  project['image']!,
                                  width: double.infinity,
                                  height: constraints.maxWidth > 600
                                      ? 250
                                      : 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MouseRegion(
                                  onEnter: (_) {},
                                  onExit: (_) {},
                                  child: GestureDetector(
                                    onTap: () => _launchURL(project['url']!),
                                    child: Text(
                                      project['name']!,
                                      style: TextStyle(
                                        fontSize: constraints.maxWidth > 600
                                            ? 18
                                            : constraints.maxWidth > 400
                                                ? 16
                                                : 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
