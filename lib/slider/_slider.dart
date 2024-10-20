import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List imageList = [
    {"id": 1, "image_path": 'assets/images/sliderimg1.png'},
    {"id": 2, "image_path": 'assets/images/sliderimg2.png'},
    {"id": 3, "image_path": 'assets/images/sliderimg5.png'},
    {"id": 4, "image_path": 'assets/images/sliderimg3.png'},
  ];
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int Currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            print(Currentindex);
          },
          child: CarouselSlider(
            items: imageList
                .map(
                  (item) => Image.asset(
                    item['image_path'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              height: 200,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  Currentindex = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              print(entry);
              print(entry.key);
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: Currentindex == entry.key ? 14 : 7,
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Currentindex == entry.key
                          ? Colors.orange
                          : Colors.grey),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
