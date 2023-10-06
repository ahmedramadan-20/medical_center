import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  final PageController controller;
  final int index;

  const CustomSmoothPageIndicator({super.key, required this.controller,required this.index});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
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
}
