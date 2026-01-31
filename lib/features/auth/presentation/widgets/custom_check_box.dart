import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool? value = false;

  @override
  Widget build(BuildContext context) => Checkbox(
        activeColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        value: value,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
            BlocProvider.of<AuthCubit>(context)
                .updateTermsAndConditionsCheckBox(newValue: newValue ?? false);
          });
        },
      );
}
