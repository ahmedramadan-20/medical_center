
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

class ForgotPasswordSubtitle extends StatelessWidget {
  const ForgotPasswordSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.0),
      child: Text(
        S.of(context).enter_your_email,
        style: AppTextStyles.cairo300style16.copyWith(
          color: AppColors.deepBlue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
