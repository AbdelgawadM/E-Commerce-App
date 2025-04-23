import 'package:e_commerce/consts.dart';
import 'package:e_commerce/features/auth_feature/screens/auth_handled_screen.dart';
import 'package:e_commerce/features/onboarding_feature/screens/on_boarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');
    await Future.delayed(const Duration(seconds: 2));
    if (isFirstTime == null || isFirstTime) {
      prefs.setBool('isFirstTime', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnBoardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AuthHandlerScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image as background
          Image.asset(
            'assets/images/image2.jpg',
            fit: BoxFit.cover,
            width:
                double
                    .infinity, // Ensures the image spans the full width of the screen
            height:
                double
                    .infinity, // Ensures the image spans the full height of the screen
          ),
          // Overlapping content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(color: kPrimaryColor, size: 150, CupertinoIcons.cart_fill),
                Text(
                  'AST Shop',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
