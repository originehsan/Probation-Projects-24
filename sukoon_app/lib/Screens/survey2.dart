import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'global_variable.dart';
import 'survey3.dart';

class Survey2 extends StatefulWidget {
  @override
  State<Survey2> createState() => _Survey2State();
}

class _Survey2State extends State<Survey2> {
  double _overwhelmedByDemands = GlobalVariables.overwhelmedByDemands;
  double _workLifeBalanceSatisfaction = GlobalVariables.workLifeBalanceSatisfaction;
  double _personalGoalAchievement = GlobalVariables.personalGoalAchievement;

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
                  'How often do you feel overwhelmed by the demands of life?',
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
                  value: _overwhelmedByDemands,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _overwhelmedByDemands = roundToHalf(value);
                    });
                    GlobalVariables.overwhelmedByDemands = _overwhelmedByDemands;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How satisfied are you with your work-life balance?',
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
                  value: _workLifeBalanceSatisfaction,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _workLifeBalanceSatisfaction = roundToHalf(value);
                    });
                    GlobalVariables.workLifeBalanceSatisfaction = _workLifeBalanceSatisfaction;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How often do you set and achieve personal goals?',
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
                  value: _personalGoalAchievement,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _personalGoalAchievement = roundToHalf(value);
                    });
                    GlobalVariables.personalGoalAchievement = _personalGoalAchievement;
                  },
                ),
                SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Survey3()),
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
