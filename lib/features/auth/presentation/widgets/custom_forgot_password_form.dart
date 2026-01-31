import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/functions/custom_toast.dart';

import 'package:medical_center/core/widgets/custom_button.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:medical_center/generated/l10n.dart';

class CustomForgotPasswordForm extends StatelessWidget {
  const CustomForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            showToast(context, S.of(context).check_your_email);
            context.pushReplacement('/signIn');
          } else if (state is ResetPasswordErrorState) {
            showToast(context, state.errMessage);
          }
        },
        builder: (context, state) {
          final authCubit = BlocProvider.of<AuthCubit>(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: authCubit.forgotPasswordFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: S.of(context).email_address,
                    onChanged: (email) {
                      authCubit.emailAddress = email;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 129),
                  if (state is ResetPasswordLoadingState)
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    )
                  else
                    CustomButton(
                      text: S.of(context).send_reset_password_link,
                      onPressed: () async {
                        if (authCubit.forgotPasswordFormKey.currentState!
                            .validate()) {
                          await authCubit.restPasswordWithLink();
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
}
