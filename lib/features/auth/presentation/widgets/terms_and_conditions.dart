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
              TextSpan(
                  text: 'هل توافق على  ',
                  style: AppTextStyles.cairo300style16
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 12)),
              TextSpan(
                  text: 'الشروط والاحكام',
                  style: AppTextStyles.cairo300style16.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
        ),

      ],
    );
  }
}
