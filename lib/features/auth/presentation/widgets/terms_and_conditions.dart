import 'package:flutter/material.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_check_box.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

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
                  text: S.of(context).do_you_agree,
                  style: AppTextStyles.cairo300style16
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 12)),
              TextSpan(
                  text:  S.of(context).Terms_and_Conditions,
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
