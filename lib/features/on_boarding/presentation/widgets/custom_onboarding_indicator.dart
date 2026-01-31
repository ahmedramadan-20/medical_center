import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({
    required this.controller,
    required this.index,
    super.key,
  });
  final PageController controller;
  final int index;

  @override
  Widget build(BuildContext context) => Align(
        child: SmoothPageIndicator(
          controller: controller,
          count: index,
          effect: const ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 10,
            spacing: 5,
          ),
        ),
      );
}
