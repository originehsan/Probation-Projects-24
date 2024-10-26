import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:todoapp/services/database.dart';

class Home extends StatefulWidget {
  final String userId;

  const Home({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool today = true, tomorrow = false, nextWeek = false;
  Stream<QuerySnapshot>? todoStream;
  TextEditingController todoController = TextEditingController();
  List<String> checkedWorks = [];

  @override
  void initState() {
    super.initState();
    loadWorks();
  }

  Future<void> loadWorks() async {
    String collection = today ? "Today" : tomorrow ? "Tomorrow" : "NextWeek";
    todoStream = DatabaseMethodsAdd().getAllWork(collection, widget.userId);

    checkedWorks.clear();

    if (todoStream != null) {
      final snapshot = await todoStream!.first;
      for (var doc in snapshot.docs) {
        if (doc["IsChecked"] == true) {
          checkedWorks.add(doc["Id"]);
        }
      }
    }

    setState(() {});
  }

  Future<void> deleteWork(String id) async {
    String collection = today ? "Today" : tomorrow ? "Tomorrow" : "NextWeek";
    await DatabaseMethodsDelete().deleteWork(id, collection);
    checkedWorks.remove(id);
    loadWorks();
  }

  Widget buildWorkList() {
    return StreamBuilder<QuerySnapshot>(
      stream: todoStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              bool isChecked = checkedWorks.contains(ds["Id"]);
              return ListTile(
                title: CheckboxListTile(
                  title: Text(
                    ds["Work"],
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 78, 139),
                      fontSize: 20,
                    ),
                  ),
                  value: isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue!) {
                        checkedWorks.add(ds["Id"]);
                        DatabaseMethodsUpdate().updateWorkCheckedState(ds["Id"], true, today ? "Today" : tomorrow ? "Tomorrow" : "NextWeek");
                      } else {
                        checkedWorks.remove(ds["Id"]);
                        DatabaseMethodsUpdate().updateWorkCheckedState(ds["Id"], false, today ? "Today" : tomorrow ? "Tomorrow" : "NextWeek");
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => deleteWork(ds["Id"]),
                ),
              );
            },
          );
        } else {
          return Center(child: Text("No Work found"));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showAddWorkDialog,
        child: Icon(Icons.add, color: Color.fromARGB(255, 4, 78, 139), size: 30),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 15, right: 10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,",
                style: TextStyle(
                    color: Color.fromARGB(255, 4, 78, 139),
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 15),
            buildCategorySelector(),
            SizedBox(height: 20),
            Expanded(child: buildWorkList()),
          ],
        ),
      ),
    );
  }

  Widget buildCategorySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCategoryButton("Today", today, () {
          setState(() {
            today = true;
            tomorrow = false;
            nextWeek = false;
            loadWorks();
          });
        }),
        buildCategoryButton("Tomorrow", tomorrow, () {
          setState(() {
            today = false;
            tomorrow = true;
            nextWeek = false;
            loadWorks();
          });
        }),
        buildCategoryButton("Next Week", nextWeek, () {
          setState(() {
            today = false;
            tomorrow = false;
            nextWeek = true;
            loadWorks();
          });
        }),
      ],
    );
  }

  Widget buildCategoryButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: isSelected ? 5 : 0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Color.fromARGB(193, 5, 79, 92)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            title,
            style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Color.fromARGB(255, 236, 165, 88),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> showAddWorkDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.cancel)),
                  SizedBox(width: 60),
                  Text("Add work to do",
                      style: TextStyle(
                          color: Color.fromARGB(255, 236, 165, 88),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
              SizedBox(height: 20),
              Text("Add Text here..."),
              SizedBox(height: 10),
              buildInputField(),
              SizedBox(height: 20),
              buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(96, 14, 14, 14), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: todoController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Work",
          hintStyle: TextStyle(color: Color.fromARGB(255, 195, 194, 194)),
        ),
      ),
    );
  }

  Widget buildAddButton() {
    return GestureDetector(
      onTap: () {
        if (todoController.text.isNotEmpty) {
          String id = randomAlphaNumeric(10);
          String collection = today ? "Today" : tomorrow ? "Tomorrow" : "NextWeek";

          DatabaseMethodsAdd().addWork(todoController.text, id, widget.userId, collection);
          
          Navigator.pop(context);
          todoController.clear(); // Clear the input after adding
          loadWorks(); // Reload the works
        }
      },
      child: Center(
        child: Container(
          width: 100,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 165, 88),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("Add",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
