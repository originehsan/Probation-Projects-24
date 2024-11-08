import 'package:flutter/material.dart';
import 'category.dart';  
import 'home.dart';  

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/bg11.jpg",
                fit: BoxFit.cover,
              ),
            ),
            
           
            Center(
              child: Image.asset('assets/images/logo2.png'),
            ),
            
           
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      // When tapped, navigate to CategoriesPage
                      final selectedCategory = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesPage(),  
                        ),
                      );

                      if (selectedCategory != null) {
                        
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(selectedCategory: selectedCategory, categoryName: '',),  
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 90),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Start Quiz",
                          style: TextStyle(
                            color: const Color.fromARGB(226, 0, 39, 105),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
