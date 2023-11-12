import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_functions.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_styles.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){changeLanguage(context);}, child: Text(
      Localizations.localeOf(context).languageCode==AppStrings.arabicCode?'English':"العربية",
      style: AppTextStyles.cairo300style16
          .copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
    ));
  }
}