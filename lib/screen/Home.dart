import 'package:flutter/material.dart';

import '../widets/support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "assets/images/colorshirt.jpg",
    "assets/images/tshirt1.jpg",
    "assets/images/regularjeans.jpg",
    "assets/images/men-s-jackets.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 15),
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
                  "assets/logos/outfitrlogo2.jpeg",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/images/avatar.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 216, 216), borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: Appwidgets.lighttextstyle(),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: Appwidgets.semiboldText()),
                Text("See All", style: Appwidgets.semiboldText()),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 150,
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(image: categories[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryTile extends StatelessWidget {
  String image;
  CategoryTile({required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 200,
      width: 120,
      child: Column(
       children: [
          Image.asset(
            image,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
