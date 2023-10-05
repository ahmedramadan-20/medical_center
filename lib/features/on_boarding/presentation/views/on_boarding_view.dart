import 'package:flutter/material.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/custom_onboarding_indicator.dart';
import '../widgets/on_boarding_body.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const Text(
            'Skip',
          ),
          OnBoardingWidgetBody(
            controller: controller,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomSmoothPageIndicator(controller: controller),
          Text(
            'Easily book or reserve appointments with your preferred doctor at our medical center.',
            style: AppTextStyles.poppins500style24.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
