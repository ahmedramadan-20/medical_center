
import 'package:flutter/material.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_check_box.dart';

import '../../../../core/utils/app_text_styles.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCheckBox(),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                  text: 'I have agree to our ',
                  style: AppTextStyles.poppins400style12),
              TextSpan(
                  text: 'Terms and Conditions',
                  style: AppTextStyles.poppins400style12.copyWith(
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
