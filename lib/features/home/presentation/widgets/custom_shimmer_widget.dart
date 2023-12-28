import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../home_cubit/home_cubit.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.separated(
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(5),
              // boxShadow: [
              //   BoxShadow(
              //     color: AppColors.grey.withOpacity(0.4),
              //     blurRadius: 7,
              //     offset: const Offset(0, 7), // changes position of shadow
              //   ),
              // ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(5)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 200,
                      height: 15,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 170,
                      height: 15,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                )
              ],
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 15,
          ),
          itemCount: BlocProvider.of<HomeCubit>(context).filteredDoctors.length,
        ),
      ),
    ).animate(
      effects: [const ShimmerEffect()],onPlay: (controller) {
        controller.repeat();
      }
    );
  }
}