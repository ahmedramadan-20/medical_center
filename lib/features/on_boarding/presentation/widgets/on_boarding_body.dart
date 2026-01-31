import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';

class OnBoardingWidgetBody extends StatelessWidget {
  const OnBoardingWidgetBody({
    required this.onPageChanged,
    super.key,
  });
  final Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);
          return SizedBox(
            height: 300,
            width: double.infinity,
            child: PageView.builder(
              onPageChanged: onPageChanged,
              physics: const BouncingScrollPhysics(),
              controller: cubit.controller,
              itemCount: cubit.onBoardingData(context).length,
              itemBuilder: (context, index) => SizedBox(
                height: 290,
                width: 343,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                //   // image: DecorationImage(
                //   //     image: Lottie.asset(
                //   //         cubit.onBoardingData(context)[index].imagePath),
                //   //     fit: BoxFit.fitHeight,),
                // ),
                child: Lottie.asset(
                  cubit.onBoardingData(context)[index].imagePath,
                ),
              ),
            ),
          );
        },
      );
}
