import 'package:flutter/material.dart';
import 'package:sukoon_app/Screens/suvery1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  
import '../global_variable.dart';
import 'dart:convert';  
import 'package:http/http.dart' as http;

final FlutterSecureStorage secureStorage = FlutterSecureStorage();  

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<ChartData> chartData = [];
  String quote = "Loading quote...";  

  @override
  void initState() {
    super.initState();
    populateChartData();  
    fetchQuote();  
  }

  Future<void> loadStatsFromStorage() async {
    final statsString = await secureStorage.read(key: 'survey_stats');
    if (statsString != null) {
      final Map<String, dynamic> stats = json.decode(statsString);
      setState(() {
        chartData = [
          ChartData('Emotional', double.tryParse(stats['emotionalWellBeing']?.toString() ?? '0') ?? 0),
          ChartData('Stress', double.tryParse(stats['stressAndAnxiety']?.toString() ?? '0') ?? 0),
          ChartData('Relationships', double.tryParse(stats['socialRelationships']?.toString() ?? '0') ?? 0),
          ChartData('Self Esteem', double.tryParse(stats['selfEsteem']?.toString() ?? '0') ?? 0),
        ];
      });
    }
  }

  void populateChartData() {
    loadStatsFromStorage();
  }

  double calculatePercentage(double value) {
    return (value / 4) * 100;
  }

  Future<void> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          quote = data[0]['q'] ?? "No quote available";
        });
      } else {
        setState(() {
          quote = "Failed to load quote. Status code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        quote = "Error fetching quote: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 55.0),
                    child: Container(
                      width: double.infinity,
                      height: 188,
                      decoration: BoxDecoration(
                        color: Color(0xFFE7BCFF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0, top: 12),
                            child: Text(
                              'Analysis',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 31,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Alice",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0, top: 8.0, right: 90),
                            child: Text(
                              'Your mental health seems to be depressed',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Alice",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Survey1()),
                                );
                              },
                              child: Text(
                                "Test Again",
                                style: TextStyle(
                                  fontFamily: "Alice",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
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
                  Positioned(
                    right: 2,
                    top: 35,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.amber,
                      child: Container(
                        width: 120,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/onboardmain.png",
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 170,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFF9A9A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Detailed Analysis',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Alice"
                  ),
                ),
              ),
              SizedBox(height: 0),
              if (isLoading)
                CircularProgressIndicator()
              else
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  alignment: Alignment.center,
                  width: 350,
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        axisLine: AxisLine(width: 2, color: Colors.black),
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        axisLine: AxisLine(width: 2, color: Colors.black),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        majorGridLines: MajorGridLines(width: 0),
                        maximum: 100,
                      ),
                      series: <CartesianSeries>[
                        BarSeries<ChartData, String>( 
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => calculatePercentage(data.value),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          width: 0.6,
                          spacing: 0.3,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            labelPosition: ChartDataLabelPosition.inside,
                            labelAlignment: ChartDataLabelAlignment.middle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 30),
              Container(
                width: 170,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFF9A9A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Mindful Musings',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Alice"
                  ),
                ),
              ),
              SizedBox(height: 0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                alignment: Alignment.center,
                width: 350,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Align content to top
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,left: 8,right: 8), // Added padding from top
                        child: Text(
                          'Get relaxing readings on your fingertips',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Alice",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 18),
                      Center(
                        child: Text(
                          '"$quote"',
                          style: TextStyle(
                            fontSize: 17,
                            color: const Color.fromARGB(255, 12, 127, 162),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Image.asset(
                  'assets/images/quotebg.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
