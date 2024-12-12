import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sukoon_app/Screens/authscreens/onboardmain.dart';
import 'package:sukoon_app/Screens/global_variable.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Method to load the username and email from secure storage
  Future<void> _loadUserData() async {
    // Attempt to read the username and email from secureStorage
    final storedUsername = await secureStorage.read(key: 'username');
    final storedEmail = await secureStorage.read(key: 'user_email'); // Using 'user_email'

    // Debugging: Print the retrieved data
    print("Stored Username: $storedUsername");
    print("Stored Email: $storedEmail");

    setState(() {
      // If data exists in secureStorage, use it; otherwise, fallback to GlobalVariables
      username = storedUsername ?? GlobalVariables.username;
      email = storedEmail ?? GlobalVariables.email;

      // Debugging: Print the final values that will be shown on the profile
      print("Final Username: $username");
      print("Final Email: $email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.black),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 25),
              Center(
                child: Column(
                  children: [
                    // Display Profile Icon
                    Container(
                      width: 175,
                      height: 175,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF75E887),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    SizedBox(height: 15),
                    // Display Username
                    Text(
                      username ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Alice",
                      ),
                    ),
                    SizedBox(height: 5),
                    // Display Email
                    Text(
                      email ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text: 'Day',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 3),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: 'Goal',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 2),
                  ),
                  title: ChartTitle(
                    text: 'Weekly Analysis',
                    textStyle: TextStyle(
                      fontFamily: "Alice",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: false),
                  series: <LineSeries<Userdata, String>>[
                    LineSeries<Userdata, String>(
                      dataSource: <Userdata>[
                        Userdata('Mon', 35),
                        Userdata('Tue', 28),
                        Userdata('Wed', 34),
                        Userdata('Thu', 32),
                        Userdata('Fri', 40),
                      ],
                      xValueMapper: (Userdata sales, _) => sales.year,
                      yValueMapper: (Userdata sales, _) => sales.sales,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        width: 6,
                        height: 6,
                        color: Colors.green,
                      ),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 250,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _showSignOutDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "Alice",
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100], // Light red background color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black, width: 1), // Border with black color
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Text('Sign Out',
                  style: TextStyle(fontSize: 28, color: Colors.black, fontFamily: "Alice"))),
          content: Text(
            'Sure want to sign out ?',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(child: Text('Cancel', style: TextStyle(fontSize: 17, color: Colors.black)))),
            TextButton(
              onPressed: () async {
                await secureStorage.delete(key: 'auth_token');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboardmain(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Container(child: Text('Signout', style: TextStyle(fontSize: 17, color: Colors.redAccent)))),
          ],
        );
      },
    );
  }
}

class Userdata {
  Userdata(this.year, this.sales);

  final String year;
  final double sales;
}
