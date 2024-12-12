import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sukoon_app/Screens/bottomnavscreens/bottomnav.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'global_variable.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Survey4 extends StatefulWidget {
  @override
  State<Survey4> createState() => _Survey4State();
}

class _Survey4State extends State<Survey4> {
  bool isLoading = false;
  String? email;  // Variable to store email

  @override
  void initState() {
    super.initState();
    _loadEmail();  // Load email from secure storage when the screen is initialized
    _loadStatsData();  // Load the previously saved stats data from local storage
  }

  // Method to load the stored email from secure storage
  Future<void> _loadEmail() async {
    final storedEmail = await secureStorage.read(key: 'user_email');
    setState(() {
      email = storedEmail;
    });
  }

  // Method to load the stored stats data from secure storage
  Future<void> _loadStatsData() async {
    String? storedStats = await secureStorage.read(key: 'survey_stats');
    if (storedStats != null) {
      final stats = json.decode(storedStats);
      setState(() {
        // Load the stored stats into GlobalVariables or wherever you need it
        GlobalVariables.stats = stats;
      });
    }
  }

  double roundToHalf(double value) {
    return (value * 2).roundToDouble() / 2;
  }

  Future<void> submitSurvey() async {
    if (email == null) {
      // If email is not loaded yet, prevent submitting survey
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://login-signup-page-3z09.onrender.com/user/submit-survey');

    final surveyData = {
      'email': email,  // Use the loaded email instead of GlobalVariables.email
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

            // Save the stats data to local storage to persist it
            await secureStorage.write(
              key: 'survey_stats',
              value: json.encode(stats),
            );

            // Update GlobalVariables with the new stats
            GlobalVariables.stats = stats;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Bottomnav(),
              ),
              (Route<dynamic> route) => false,
            );
          } else {
            // Handle other cases if needed
          }
        } catch (e) {
          print("Error: Unable to parse response data.");
        }
      } else {
        print("Error: Unable to submit survey. Status code: ${response.statusCode}");
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
