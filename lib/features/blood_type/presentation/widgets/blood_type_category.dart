import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_cubit.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_state.dart';

class BloodTypesCategory extends StatelessWidget {
  const BloodTypesCategory({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BloodCubit, BloodState>(
        builder: (context, state) {
          final cubit = context.read<BloodCubit>();
          return SizedBox(
            height: 60,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final isSelected = cubit.bloodTypeIndex == index;
                return GestureDetector(
                  onTap: () {
                    cubit.changeIndex(index, context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                AppColors.babyBlue,
                                AppColors.babyBlue.withValues(alpha: 0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isSelected ? null : AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:
                                    AppColors.babyBlue.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : AppColors.babyBlue.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      cubit.bloodTypesList[index],
                      style: AppTextStyles.cairo400Style20.copyWith(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemCount: cubit.bloodTypesList.length,
            ),
          );
        },
      );
}
