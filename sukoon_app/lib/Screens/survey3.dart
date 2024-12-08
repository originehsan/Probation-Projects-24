import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'global_variable.dart';
import 'survey4.dart';

class Survey3 extends StatefulWidget {
  @override
  State<Survey3> createState() => _Survey3State();
}

class _Survey3State extends State<Survey3> {
  double _workStressLevel = GlobalVariables.workStressLevel;
  double _leisureTime = GlobalVariables.leisureTime;
  double _careerGoalAchievement = GlobalVariables.careerGoalAchievement;

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
                SizedBox(height: 100),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Let’s have a Quick Analysis',
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
                  'How stressed do you feel about your work responsibilities?',
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
                  value: _workStressLevel,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _workStressLevel = roundToHalf(value);
                    });
                    GlobalVariables.workStressLevel = _workStressLevel;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How often do you make time for hobbies and relaxation?',
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
                  value: _leisureTime,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _leisureTime = roundToHalf(value);
                    });
                    GlobalVariables.leisureTime = _leisureTime;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How often do you feel like you\'re achieving your career goals?',
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
                  value: _careerGoalAchievement,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _careerGoalAchievement = roundToHalf(value);
                    });
                    GlobalVariables.careerGoalAchievement = _careerGoalAchievement;
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
