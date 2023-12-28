import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.onChanged,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.obscureText, required this.keyboardType});

  final String labelText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8, top: 24),
      child: TextFormField(
        onTapOutside:
        (event) { FocusManager.instance.primaryFocus?.unfocus(); },
        validator: (value) {
          if (value!.isEmpty) {
            return S.of(context).required;
          } else {
            return null;
          }
        },
        keyboardType: keyboardType,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.deepBlue,
          labelText: labelText,
          labelStyle: AppTextStyles.cairo300style16.copyWith(fontWeight: FontWeight.w500,fontSize: 18),
          border: getBorderStyle(),
          enabledBorder: getBorderStyle(),
          focusedBorder: getBorderStyle(),
        ),
      ),
    );
  }
}

OutlineInputBorder getBorderStyle() {
  return OutlineInputBorder(

    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: AppColors.deepBlue,
    ),
  );
}
