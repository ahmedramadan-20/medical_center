import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_button.dart';
import 'package:medical_center/core/widgets/custom_change_lang_button.dart';
import 'package:medical_center/core/widgets/fade_animation.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:medical_center/features/on_boarding/presentation/views/functions/on_boarding.dart';
import 'package:medical_center/features/on_boarding/presentation/widgets/custom_onboarding_indicator.dart';
import 'package:medical_center/features/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:medical_center/generated/l10n.dart';

Widget onboardingBody(BuildContext context, OnBoardingCubit cubit) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ChangeLanguageButton(),
                GestureDetector(
                  onTap: () {
                    onBoardingVisited();
                    context.pushReplacement('/signUp');
                  },
                  child: Text(
                    S.of(context).skip,
                    style: AppTextStyles.cairo300style16
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            OnBoardingWidgetBody(
              onPageChanged: (index) {
                cubit.onPageChanged(index);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            CustomSmoothPageIndicator(
              controller: cubit.controller,
              index: cubit.onBoardingData(context).length,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              cubit.onBoardingData(context)[cubit.currentIndex].title,
              style: AppTextStyles.cairoBoldStyle25,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              cubit.onBoardingData(context)[cubit.currentIndex].subTitle,
              style: AppTextStyles.cairo300style16,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (cubit.currentIndex == cubit.onBoardingData(context).length - 1)
              FadeAnimation(
                delay: 0.5,
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onPressed: () {
                          onBoardingVisited();
                          context.pushReplacement('/signUp');
                        },
                        text: S.of(context).sign_up,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          onBoardingVisited();
                          context.pushReplacement('/signIn');
                        },
                        child: Text(
                          S.of(context).sign_in,
                          style: AppTextStyles.cairo300style16.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              FadeAnimation(
                delay: 0.2,
                child: SizedBox(
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
                        text: S.of(context).next,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
    );
