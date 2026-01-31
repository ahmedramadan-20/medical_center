import 'package:flutter/material.dart';

import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: AppTextStyles.cairoBoldStyle25
                .copyWith(color: AppColors.deepBlue),
          ),
        ),
      );
}
