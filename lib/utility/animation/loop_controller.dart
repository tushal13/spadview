import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ReverseLoopAnimationWidget extends StatelessWidget {
  final double beginValue;
  final double endValue;
  final int duration;
  final Widget child;

  ReverseLoopAnimationWidget({
    required this.beginValue,
    required this.endValue,
    required this.duration,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {


    return MirrorAnimationBuilder(
      tween: Tween(begin: beginValue, end: endValue),
      duration: Duration(milliseconds: duration),
      curve: Curves.bounceIn,
      builder: (context, animatedValue, child) {
        return Transform.translate(
          offset: Offset(1, animatedValue),
          child: child,
        );
      },
      child: child,
    );
  }
}
