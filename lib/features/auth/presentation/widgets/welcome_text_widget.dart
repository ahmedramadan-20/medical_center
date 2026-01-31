import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Align(
        child: Text(
          text,
          style: AppTextStyles.cairo700style32.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: AppColors.deepBlue,
          ),
        ),
      );
}
