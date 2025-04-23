import 'package:flutter/material.dart';

class BoardItem extends StatelessWidget {
  const BoardItem({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image(image: AssetImage(image))],
        ),
      ),
    );
  }
}
