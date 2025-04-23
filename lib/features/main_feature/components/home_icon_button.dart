import 'package:e_commerce/consts.dart';
import 'package:flutter/material.dart';

class HomeIconButton extends StatelessWidget {
  const HomeIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(size: 35, icon),
      color: kPrimaryColor,
      onPressed: onPressed,
    );
  }
}
