import 'package:flutter/material.dart';
import 'package:sukoon_app/Screens/bottomnavscreens/exercise.dart';
import 'package:sukoon_app/Screens/bottomnavscreens/homescreen.dart';
import 'package:sukoon_app/Screens/bottomnavscreens/journal.dart';
import 'package:sukoon_app/Screens/bottomnavscreens/music.dart';
import 'profile.dart'; 

class Bottomnav extends StatefulWidget {
  @override
  _BottomnavState createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ExerciseScreen(),
    MusicScreen(),
    JournalScreen(),
  ];

  final List<String> _pageTitles = [
    'Home',
    'Meditation',
    'Music',
    'Journal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              _pageTitles[_selectedIndex],
              style: TextStyle(
                fontFamily: 'Alice',
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,bottom: 6),
            child: Container(
              padding: EdgeInsets.all(4), 
              decoration: BoxDecoration(
                color: Color(0xFF75E887),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF75E887),
                  width: 2,
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 25, 
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
              color: _selectedIndex == 0 ? Color(0xFF33D7FF) : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/yogaimg.png"),
              color: _selectedIndex == 1 ? Color(0xFF33D7FF) : Colors.black,
            ),
            label: 'Meditation',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/headphones.png"),
              color: _selectedIndex == 2 ? Color(0xFF33D7FF) : Colors.black,
            ),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/note.png"),
              color: _selectedIndex == 3 ? Color(0xFF33D7FF) : Colors.black,
            ),
            label: 'Journal',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF33D7FF),
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        selectedItemColor: Color(0xFF33D7FF),
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.grey[200],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
