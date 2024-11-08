import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'score.dart';
import 'sevice.dart';

class Home extends StatefulWidget {
  final String selectedCategory;
  final String categoryName;

  const Home({Key? key, required this.selectedCategory, required this.categoryName}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? question, answer;
  List<String> options = [];
  bool isLoading = true;
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuiz(widget.selectedCategory);
  }

  Future<void> fetchQuiz(String category) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/trivia?category=$category'),
      headers: {
        'Content-Type': 'application/json',
        'X-Api-Key': APIKEY,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> quiz = jsonData[0];
        question = quiz["question"];
        answer = quiz["answer"];
        await fetchRandomWordsForOptions();
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchRandomWordsForOptions() async {
    List<String> incorrectOptions = [];

    final response = await http.get(
      Uri.parse('https://random-word-api.herokuapp.com/word?number=3'),
    );

    if (response.statusCode == 200) {
      List<dynamic> wordList = jsonDecode(response.body);
      if (wordList.isNotEmpty) {
        incorrectOptions = List<String>.from(wordList);
      }
    }

    incorrectOptions.add(answer!);
    incorrectOptions.shuffle();

    setState(() {
      options = incorrectOptions;
    });
  }

  void _checkAnswer(String selectedOption) {
    String feedback = selectedOption == answer
        ? "Correct Answer"
        : "Wrong Answer";

    IconData feedbackIcon = selectedOption == answer
        ? FontAwesomeIcons.smile
        : FontAwesomeIcons.sadTear;

    if (selectedOption == answer) {
      score++;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              feedbackIcon,
              color: selectedOption == answer ? Colors.green : Colors.red,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(feedback),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                fetchQuiz(widget.selectedCategory);
              });
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  void _endQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(score: score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC107),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Start Quiz",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade700, Colors.orange.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      widget.categoryName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    question ?? 'Loading question',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  ...List.generate(options.length, (index) {
                    String optionLabel = String.fromCharCode(65 + index);
                    return GestureDetector(
                      onTap: () {
                        _checkAnswer(options[index]);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black87,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '$optionLabel)',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  options[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: _endQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC107),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "End Quiz",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 136, 41, 153),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
