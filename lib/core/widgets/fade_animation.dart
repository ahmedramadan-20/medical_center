import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          delay: Duration(
            milliseconds: (500 * delay).round(),
          ),
        ),
        MoveEffect(
          delay: Duration(
            milliseconds: (500 * delay).round(),
          ),
        ),
        ShimmerEffect(
          delay: Duration(
            milliseconds: (1500 * delay).round(),
          ),
        ),
      ],
      child: child,
    );
  }
}
