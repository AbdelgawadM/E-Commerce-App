import 'package:e_commerce/consts.dart';
import 'package:flutter/material.dart';

class StatementRow extends StatelessWidget {
  const StatementRow({
    super.key,
    required this.statement,
    required this.buttonText,
    required this.screen,
  });
  final String statement, buttonText;
  final void Function() screen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(statement, style: TextStyle(fontSize: 17)),
        TextButton(
          onPressed: screen,
          child: Text(
            buttonText,
            style: TextStyle(color: kPrimaryColor, fontSize: 17),
          ),
        ),
      ],
    );
  }
}
