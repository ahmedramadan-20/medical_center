import 'package:flutter/material.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    required this.text1,
    required this.text2,
    super.key,
    this.onTap,
  });

  final String text1;
  final String text2;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Align(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text1,
                  style: AppTextStyles.cairo700style32.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                TextSpan(
                  text: text2,
                  style: AppTextStyles.cairo700style32.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
