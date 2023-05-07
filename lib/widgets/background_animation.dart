import 'package:flutter/material.dart';

class BackgroundAnimation extends StatefulWidget {
  final String imageUrl;

  const BackgroundAnimation({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return AnimatedPositioned(
          duration: const Duration(microseconds: 200),
          top: -60,
          left: (controller.value * 30) - 400,
          child: child!,
        );
      },
      child: Image.asset(widget.imageUrl),
    );
  }
}
