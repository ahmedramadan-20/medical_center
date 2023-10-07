
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/navigator.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import '../../../../core/functions/custom_toast.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../auth_cubit/auth_state.dart';
import 'custom_text_field.dart';

class CustomForgotPasswordForm extends StatelessWidget {
  const CustomForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is ResetPasswordSuccessState){
          showToast('Check your email to reset your password');
          navigateReplacement(context, '/signIn');
        }else if(state is ResetPasswordErrorState){
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
                  labelText: 'البريد الالكتروني',
                  onChanged: (email) {
                    authCubit.emailAddress = email;
                  },
                ),
                const SizedBox(height: 129),
                state is ResetPasswordLoadingState
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : CustomButton(
                        text: 'إرسال رابط إعادة تعيين كلمة المرور',
                        onPressed: () {
                          if (authCubit.forgotPasswordFormKey.currentState!.validate()) {
                            authCubit.restPasswordWithLink();
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

class ForgetPasswordTextWidget extends StatelessWidget {
  const ForgetPasswordTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateReplacement(context, '/forgotPassword');
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'هل نسيت كلمة السر ؟',
          style: AppTextStyles.cairo700style32.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.deepBlue,
          ),
        ),
      ),
    );
  }
}
