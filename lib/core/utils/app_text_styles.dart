import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle poppins500style24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: 'Poppins',
  );
  static const TextStyle poppins300style16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.black,
    fontFamily: 'Poppins',
  );
  static const TextStyle poppins500style18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.deepBlue,
    fontFamily: 'Poppins',
  );
  static const TextStyle poppins400style12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.deepBlue,
    fontFamily: 'Poppins',
  );
}
