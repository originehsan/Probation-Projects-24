import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukoon_app/signup.dart';
import 'loginScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List onBoardingData = [
    {
      "image": 'assets/images/onboard1.svg',
      "title": "Welcome to\nSukoon",
      "subtitle": "A Blessing to your Minds"
    },
    {
      "image": 'assets/images/onboard2.svg',
      "title": "Stay Calm",
      "subtitle":
          "Play music, read journals,\n track your goals and\nachieve them to let you\nmeet a better version of\nyourself. "
    },
    {
      "image": 'assets/images/onboard3.svg',
      "title": "happy",
      "subtitle": "It’s never be late for a new \n Start."
    },
  ];

  PageController pageController = PageController();
  int currentPage = 0;

  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xffCBFFED)));

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffCBFFED),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: onBoardingData.length,
            onPageChanged: onChanged,
            itemBuilder: (context, index) {
              return Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: (index == 0) ? screenHeight : screenHeight * 0.65,
                    width: screenWidth,
                    child: SvgPicture.asset(
                      onBoardingData[index]['image'],
                      width: screenWidth,
                      height: (index == 0) ? screenHeight : screenHeight * 0.65,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: screenWidth * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentPage == 0)
                      Text(
                        onBoardingData[currentPage]['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6A3649),
                          fontFamily: 'Alice',
                        ),
                      ),
                    Text(
                      onBoardingData[currentPage]['subtitle'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6A3649),
                        fontFamily: 'Alice',
                        height: 1.3,
                      ),
                    ),
                    if (currentPage == 2) ...[
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(15),
                          child: TextButton(
                            onPressed: navigateToLogin,
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Alice',
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff47D6A5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    onBoardingData.length,
                    (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 10,
                        width: (index == currentPage) ? 15 : 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == currentPage)
                              ? const Color.fromARGB(255, 22, 94, 219)
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
