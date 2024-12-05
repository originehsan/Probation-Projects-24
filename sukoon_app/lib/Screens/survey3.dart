import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'survey2.dart';
import 'survey4.dart';

class Survey3 extends StatefulWidget {
  const Survey3({super.key});

  @override
  State<Survey3> createState() => _Survey1State();
}

class _Survey1State extends State<Survey3> {
  double _workLifeBalance = 0.0;
  double _overwhelmedFeeling = 0.0;
  double _goalAchievement = 0.0;

  double roundToHalf(double value) {
    return (value * 2).roundToDouble() / 2; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/surveybg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Let’s have  a Quick Analysis',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Alice",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'How often do you feel burnt out or exhausted?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Alice",
                  ),
                ),
                SizedBox(height: 20),
                SfSlider(
                  min: 0.0,
                  max: 4.0,
                  value: _workLifeBalance,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _workLifeBalance = roundToHalf(value);
                    });
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How often do you feel worried or anxious about the future?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Alice"
                  ),
                ),
                SizedBox(height: 20),
                SfSlider(
                  min: 0.0,
                  max: 4.0,
                  value: _overwhelmedFeeling,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _overwhelmedFeeling = roundToHalf(value);
                    });
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How easy do you find it to express your feelings to others?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Alice",
                  ),
                ),
                SizedBox(height: 20),
                SfSlider(
                  min: 0.0,
                  max: 4.0,
                  value: _goalAchievement,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _goalAchievement = roundToHalf(value);
                    });
                  },
                ),
                SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Survey4()),
                      );
                    },
                    child: Text('Continue', style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: "Alice")),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      backgroundColor: Color(0xFF23B9FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

