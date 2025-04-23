import 'package:e_commerce/consts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.screen,
  });
  final String buttonText;
  final void Function() screen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
        ),
        onPressed: screen,
        child: Text(buttonText),
      ),
    );
  }
}
