import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';

class CategoriesHeaderText extends StatelessWidget {
  const CategoriesHeaderText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          text,
          style: AppTextStyles.cairo400Style20
        ),
      ),
    );
  }
}
