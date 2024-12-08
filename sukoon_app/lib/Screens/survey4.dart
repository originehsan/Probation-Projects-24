import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:convert';
import 'global_variable.dart';
import 'homescreen.dart';

class Survey4 extends StatefulWidget {
  @override
  State<Survey4> createState() => _Survey4State();
}

class _Survey4State extends State<Survey4> {
  bool isLoading = false;

  double roundToHalf(double value) {
    return (value * 2).roundToDouble() / 2;
  }

  Future<void> submitSurvey() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://login-signup-page-3z09.onrender.com/user/submit-survey');

    final surveyData = {
      'email': GlobalVariables.email,
      'emotionalWellBeing': {
        'happiness': GlobalVariables.socialRelationships,
        'recovery': GlobalVariables.selfEsteem,
        'overwhelm': GlobalVariables.emotionalWellBeing
      },
      'stressAndAnxiety': {
        'anxiety': GlobalVariables.overwhelmedByDemands,
        'exhaustion': GlobalVariables.workLifeBalanceSatisfaction,
        'stressHandling': GlobalVariables.personalGoalAchievement
      },
      'socialRelationships': {
        'support': GlobalVariables.workStressLevel,
        'loneliness': GlobalVariables.leisureTime,
        'connections': GlobalVariables.careerGoalAchievement
      },
      'selfEsteem': {
        'confidence': GlobalVariables.healthAndWellness,
        'comparison': GlobalVariables.financialSecurity,
        'selfAcceptance': GlobalVariables.socialSupport
      },
    };

    print("Survey Data to be sent: $surveyData");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(surveyData),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final responseData = json.decode(response.body);

          String message = responseData['message'] ?? '';
          print("Response Message: $message");

          if (message == "Survey data saved successfully") {
            final stats = responseData['stats'] ?? {
              'emotionalWellBeing': '0',
              'stressAndAnxiety': '0',
              'socialRelationships': '0',
              'selfEsteem': '0',
            };

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(stats: stats)),
              (Route<dynamic> route) => false,
            );
          } else {
            // No action, just proceed
          }
        } catch (e) {
          print("Error: Unable to parse response data.");
         
        }
      } else {
        print("Error: Unable to submit survey. Status code");
        
      }
    } catch (e) {
      print("Error: Unable to send request.");
     
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                  'How satisfied are you with your physical health and wellness?',
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
                  value: GlobalVariables.healthAndWellness,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      GlobalVariables.healthAndWellness = roundToHalf(value);
                    });
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How secure do you feel about your financial situation?',
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
                  value: GlobalVariables.financialSecurity,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      GlobalVariables.financialSecurity = roundToHalf(value);
                    });
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'How supported do you feel by friends, family, or community?',
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
                  value: GlobalVariables.socialSupport,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      GlobalVariables.socialSupport = roundToHalf(value);
                    });
                  },
                ),
                SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : submitSurvey,
                    child: isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text('Submit', style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: "Alice")),
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
