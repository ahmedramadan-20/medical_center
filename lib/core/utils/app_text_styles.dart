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
  static const TextStyle poppins600style12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.deepBlue,
    fontFamily: 'Poppins',
  );
  static const TextStyle poppins400style12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.deepBlue,
    fontFamily: 'Poppins',
  );

  static const TextStyle cairo700style32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Cairo',
  );

  static const TextStyle cairo300style16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.black,
    fontFamily: 'Cairo',
  );

  static const TextStyle cairoBoldStyle25 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: 'Cairo',
  );
}
