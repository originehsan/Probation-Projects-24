import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart'; 

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC107),

      appBar: AppBar(
        title: Text('Select Category'),
        backgroundColor: const Color(0xFFFFC107),
        elevation: 0,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _categoryButton(
                  context, 'General', 'general', FontAwesomeIcons.question),
              _categoryButton(
                  context, 'Geography', 'geography', FontAwesomeIcons.globe),
              _categoryButton(context, 'Mathematics', 'mathematics',
                  FontAwesomeIcons.calculator),
              _categoryButton(
                  context, 'Music', 'music', FontAwesomeIcons.music),
              _categoryButton(context, 'Sports', 'sportsleisure',
                  FontAwesomeIcons.basketballBall),
              _categoryButton(context, 'Mythology', 'religionmythology',
                  FontAwesomeIcons.bookOpen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryButton(BuildContext context, String categoryName,
      String category, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              selectedCategory: category,
              categoryName: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: Color.fromARGB(226, 0, 39, 105),
                size: 28),
            SizedBox(width: 10),
            Text(
              categoryName,
              style: TextStyle(
                color: Color.fromARGB(226, 0, 39, 105),
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
