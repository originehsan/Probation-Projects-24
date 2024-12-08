import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'global_variable.dart';
import 'survey2.dart';

class Survey1 extends StatefulWidget {
  @override
  _Survey1State createState() => _Survey1State();
}

class _Survey1State extends State<Survey1> {
  double _socialRelationships = GlobalVariables.socialRelationships;
  double _selfEsteem = GlobalVariables.selfEsteem;
  double _emotionalWellBeing = GlobalVariables.emotionalWellBeing;

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
                  'How easy is it for you to maintain meaningful connections with friends or family?',
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
                  value: _socialRelationships,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _socialRelationships = roundToHalf(value);
                    });
                    GlobalVariables.socialRelationships = _socialRelationships;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How confident are you in your abilities and strengths?',
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
                  value: _selfEsteem,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _selfEsteem = roundToHalf(value);
                    });
                    GlobalVariables.selfEsteem = _selfEsteem;
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
                  value: _emotionalWellBeing,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _emotionalWellBeing = roundToHalf(value);
                    });
                    GlobalVariables.emotionalWellBeing = _emotionalWellBeing;
                  },
                ),
                SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Survey2()),
                      );
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "Alice"),
                    ),
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
