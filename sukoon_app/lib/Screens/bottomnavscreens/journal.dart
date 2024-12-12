import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  TextEditingController _journalController = TextEditingController();
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()); 
  }

  void _submitJournalEntry() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Journal entry submitted!")));
    _journalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 247, 255, 247), 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Text(
                'Date: $_currentDate',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Arial',
                ),
              ),
              SizedBox(height: 25),

              Text(
                'Write Your Journal Entry:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontFamily: 'Alice',
                ),
              ),
              SizedBox(height: 15),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _journalController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Write your thoughts here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: EdgeInsets.all(15),
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              SizedBox(height: 25),

              Center(
                child: ElevatedButton(
                  onPressed: _submitJournalEntry,
                  child: Text(
                    'Submit Entry',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: const Color(0xFF23B9FF), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5, 
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
