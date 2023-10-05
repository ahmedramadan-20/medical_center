import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';

class OnBoardingWidgetBody extends StatelessWidget {
  final PageController controller;

  const OnBoardingWidgetBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.asset(AppAssets.onBoarding1),
            ],
          );
        },
      ),
    );
  }
}
