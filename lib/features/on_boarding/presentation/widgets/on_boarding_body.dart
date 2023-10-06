import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';

class OnBoardingWidgetBody extends StatelessWidget {
  final PageController controller;
  final  Function(int)? onPageChanged;

  const OnBoardingWidgetBody(
      {super.key, required this.controller,required this.onPageChanged,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = OnBoardingCubit.get(context);
        return SizedBox(
          height: 300,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: onPageChanged,
            physics: const BouncingScrollPhysics(),
            controller: cubit.controller,
            itemCount: cubit.onBoardingData.length,
            itemBuilder: (context, index) {
              return Container(
                height: 290,
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(cubit.onBoardingData[index].imagePath),
                      fit: BoxFit.fitHeight),),
              );
            },
          ),
        );
      },
    );
  }
}
