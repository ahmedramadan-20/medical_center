import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:medical_center/features/on_boarding/presentation/widgets/onboarding_screen.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);
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
