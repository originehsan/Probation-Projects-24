import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outfitr/screen/Home.dart';
import 'package:outfitr/screen/order.dart';
import 'package:outfitr/screen/profile.dart';
import 'package:outfitr/screen/wishlist.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  late List<Widget> pages;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      Home(),
      Wishlist(onHomePressed: () {
        setState(() {
          currentTabIndex = 0;
        });
      }),
      Order(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[currentTabIndex],
        transitionBuilder: (Widget child, Animation<double> animation) {
          const offset = Offset(0.0, 1.0); // Slide from bottom
          final slideTransition = SlideTransition(
            position: animation.drive(Tween<Offset>(
              begin: offset,
              end: Offset.zero,
            )),
            child: child,
          );

          return slideTransition;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 42, 66, 43),
        selectedItemColor: Colors.orange,
        currentIndex: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,
                size: 28,
                color: currentTabIndex == 0 ? Colors.orange : Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart,
                size: 28,
                color: currentTabIndex == 1 ? Colors.orange : Colors.black),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined,
                size: 28,
                color: currentTabIndex == 2 ? Colors.orange : Colors.black),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined,
                size: 28,
                color: currentTabIndex == 3 ? Colors.orange : Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
