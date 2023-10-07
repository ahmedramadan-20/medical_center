
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';

import '../../../../core/utils/app_colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: AppColors.deepBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(
          color: AppColors.deepBlue,
        ),
        value: value,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
            BlocProvider.of<AuthCubit>(context).updateTermsAndConditionsCheckBox(newValue: newValue);
          });
        });
  }
}
