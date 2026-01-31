import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: AppTextStyles.cairo400Style20.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ),
      );
}
