import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';

import '../utils/app_text_styles.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          text,
          style: AppTextStyles.cairo400Style20.copyWith(color: AppColors.deepGrey)
        ),
      ),
    );
  }
}
