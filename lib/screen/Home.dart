import 'package:flutter/material.dart';
import '../slider/_slider.dart';
import '../widets/support.dart';
import 'shirtdetail.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'images': 'assets/images/shirt1.png', 'text': 'Shirts'},
      {'images': 'assets/images/tshirt1.png', 'text': 'Tshirts'},
      {'images': 'assets/images/hoodie1.png', 'text': 'Hoodies'},
      {'images': 'assets/images/jacket1.png', 'text': 'Jackets'},
      {'images': 'assets/images/jeans1.png', 'text': 'Jeans'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 35, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hey, User", style: Appwidgets.boldtextstyle()),
                    Text("Welcome", style: Appwidgets.lighttextstyle()),
                  ],
                ),
                Image.asset(
                  "assets/logos/logo3.jpeg",
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/images/avatar.png",
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 7),
            Container(
              padding: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 216, 216),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: Appwidgets.lighttextstyle(),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(height: 8),
            SliderScreen(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: Appwidgets.semiboldText()),
                Text("See All", style: Appwidgets.semiboldText()),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 165,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    image: categories[index]['images']!,
                    text: categories[index]['text']!,
                  );
                },
              ),
            ),
            Text("Special for you",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 140,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Special(
                    image1: categories[index]['images']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;
  final String text;

  CategoryTile({
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryItemsScreen(
              categoryName: text,
              updateLikedItems: (items) {},
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 251, 167, 77),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 145,
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(
                image,
                height: 140,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 3),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Special extends StatelessWidget {
  final String image1;

  Special({required this.image1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image1,
            height: 140,
            width: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
