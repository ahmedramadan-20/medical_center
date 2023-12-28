

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../blood_types_cubit/blood_cubit.dart';
import '../blood_types_cubit/blood_state.dart';

class BloodTypesCategory extends StatelessWidget {
  const BloodTypesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BloodCubit, BloodState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    context.read<BloodCubit>().changeIndex(index,context);
                  },
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: BlocProvider.of<BloodCubit>(context)
                              .bloodTypeIndex ==
                              index
                              ? AppColors.babyBlue
                              : Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                      color:
                      BlocProvider.of<BloodCubit>(context).bloodTypeIndex ==
                          index
                          ? AppColors.babyBlue.withOpacity(0.2)
                          : Colors.transparent,
                    ),
                    child: Text(
                      BlocProvider.of<BloodCubit>(context)
                          .bloodTypesList[index],
                      style: AppTextStyles.cairo400Style20,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemCount:
                BlocProvider.of<BloodCubit>(context).bloodTypesList.length,
              )),
        );
      },
    );
  }
}
