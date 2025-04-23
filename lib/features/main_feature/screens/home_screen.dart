import 'package:e_commerce/consts.dart';
import 'package:e_commerce/features/checkout_feature/screens/checkout_screen.dart';
import 'package:e_commerce/features/favourite_feature/screens/favourites_screen.dart';
import 'package:e_commerce/features/main_feature/screens/home_tab_screen.dart';
import 'package:e_commerce/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _screens = [
    HomeTabScreen(),
    CheckoutScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          _screens[_bottomNavIndex], // بدل ما نستخدم SingleChildScrollView هنا
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(CupertinoIcons.qrcode, color: Colors.white),
        onPressed: () {},
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        shadow: BoxShadow(
          color: Colors.grey.withValues(alpha: 0.9),
          blurRadius: 10,
        ),
        iconSize: 30,
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey[600],
        backgroundColor: Colors.white, // ← مش transparent
        icons: const [
          Icons.home_outlined,
          CupertinoIcons.cart,
          CupertinoIcons.heart,
          CupertinoIcons.profile_circled,
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() => _bottomNavIndex = index);
        },
      ),
    );
  }
}
