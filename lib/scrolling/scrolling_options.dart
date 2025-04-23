import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollingOptions extends StatelessWidget {
  const ScrollingOptions({
    super.key,
    required this.child,
  });

  final dynamic child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          scrollbars: false, // Show scrollbar on desktop
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          }, // Enable touchpad & mouse scroll
        ),
        child: child);
  }
}
