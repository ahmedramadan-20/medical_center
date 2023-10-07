import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';

import '../../../../core/utils/app_text_styles.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        text,
        style: AppTextStyles.cairo700style32.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 28,
          color: AppColors.deepBlue
        ),
      ),
    );
  }
}
