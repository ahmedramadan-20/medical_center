import 'package:flutter/material.dart';

import 'package:medical_center/core/utils/app_functions.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () {
          changeLanguage(context);
        },
        child: Text(
          Localizations.localeOf(context).languageCode == AppStrings.arabicCode
              ? 'English'
              : 'العربية',
          style: AppTextStyles.cairo300style16.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
}
