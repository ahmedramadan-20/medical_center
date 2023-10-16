import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/navigator.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import '../../../../core/functions/custom_toast.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/l10n.dart';
import '../auth_cubit/auth_state.dart';
import 'custom_text_field.dart';

class CustomForgotPasswordForm extends StatelessWidget {
  const CustomForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          showToast('Check your email to reset your password');
          navigateReplacement(context, '/signIn');
        } else if (state is ResetPasswordErrorState) {
          showToast(state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                state is ResetPasswordLoadingState
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : CustomButton(
                        text: S.of(context).send_reset_password_link,
                        onPressed: () async {
                          if (authCubit.forgotPasswordFormKey.currentState!
                              .validate()) {
                            await authCubit.restPasswordWithLink();
                          }
                        }),
              ],
            ),
          ),
        );
      },
    );
  }
}

