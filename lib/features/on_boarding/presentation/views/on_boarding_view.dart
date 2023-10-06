import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/cubit/on_boarding_cubit.dart';
import '../widgets/onboarding_screen.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OnBoardingCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: onboardingBody(
              context,
              cubit,
            ),
          ),
        );
      },
    );
  }
}
