import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> stats;

  HomeScreen({required this.stats});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    populateChartData();
  }

  void populateChartData() {
    final stats = widget.stats;

    setState(() {
      chartData = [
        ChartData('Emotional', double.tryParse(stats['emotionalWellBeing']?.toString() ?? '0') ?? 0),
        ChartData('Stress', double.tryParse(stats['stressAndAnxiety']?.toString() ?? '0') ?? 0),
        ChartData('Relationships', double.tryParse(stats['socialRelationships']?.toString() ?? '0') ?? 0),
        ChartData('Self Esteem', double.tryParse(stats['selfEsteem']?.toString() ?? '0') ?? 0),
      ];
    });
  }

  double calculatePercentage(double value) {
    return (value / 4) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator()
            else
              Container(
                width: 350,
                height: 350,
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
          ],
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
