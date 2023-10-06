import 'package:flutter/material.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../view_model/cubit/on_boarding_cubit.dart';
import 'custom_onboarding_indicator.dart';
import 'on_boarding_body.dart';

Widget onboardingBody(BuildContext context, OnBoardingCubit cubit) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                customNavigate(context, '/signUp');
              },
              child: Text(
                'Skip',
                style: AppTextStyles.poppins300style16
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OnBoardingWidgetBody(
              controller: cubit.controller,
              onPageChanged: (index) {
                cubit.onPageChanged(index);
              }),
          const SizedBox(
            height: 24,
          ),
          CustomSmoothPageIndicator(
            controller: cubit.controller,
            index: cubit.onBoardingData.length,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            cubit.onBoardingData[cubit.currentIndex].title,
            style: AppTextStyles.poppins500style24.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            cubit.onBoardingData[cubit.currentIndex].subTitle,
            style: AppTextStyles.poppins300style16,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          cubit.currentIndex == cubit.onBoardingData.length - 1
              ? SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onPressed: () {
                          customNavigate(context, '/signUp');
                        },
                        text: 'Create Account',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          customNavigate(context, '/signIn');
                        },
                        child: Text(
                          'Login Now',
                          style: AppTextStyles.poppins300style16.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onPressed: () {
                          cubit.controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear,
                          );
                        },
                        text: 'Next',
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 17,
          ),
        ],
      ),
    ),
  );
}
