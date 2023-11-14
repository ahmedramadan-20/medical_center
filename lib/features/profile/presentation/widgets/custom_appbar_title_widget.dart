import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(text, style: AppTextStyles.cairoBoldStyle25.copyWith(color: AppColors.deepBlue)),
      ),
    );
  }
}