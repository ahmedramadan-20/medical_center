import 'package:flutter/material.dart';

import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.labelText,
    required this.keyboardType,
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.obscureText,
    this.controller,
    this.validator,
  });

  final String labelText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 24),
        child: TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).required;
                } else {
                  return null;
                }
              },
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.deepBlue,
            labelText: labelText,
            labelStyle: AppTextStyles.cairo300style16
                .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            border: getBorderStyle(),
            enabledBorder: getBorderStyle(),
            focusedBorder: getBorderStyle(),
          ),
        ),
      );
}

OutlineInputBorder getBorderStyle() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.deepBlue,
      ),
    );
