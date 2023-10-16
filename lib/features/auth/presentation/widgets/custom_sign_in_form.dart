import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/navigator.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import '../../../../core/functions/custom_toast.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/l10n.dart';
import '../auth_cubit/auth_state.dart';
import 'custom_text_field.dart';

class CustomSignInForm extends StatelessWidget {
  const CustomSignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          // showToast('Welcome Back!');
          FirebaseAuth.instance.currentUser!.emailVerified
              ? navigateReplacement(context, '/home')
              : showToast(S.of(context).verify);
        } else if (state is SignInErrorState) {
          showToast(state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signInFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: S.of(context).email_address,
                onChanged: (email) {
                  authCubit.emailAddress = email;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                suffixIcon: IconButton(
                  icon: Icon(
                    authCubit.obscurePasswordTextValue == true
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    authCubit.obscurePasswordText();
                  },
                ),
                labelText:  S.of(context).password,
                obscureText: authCubit.obscurePasswordTextValue,
                onChanged: (password) {
                  authCubit.password = password;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16,
              ),
              const ForgetPasswordTextWidget(),
              const SizedBox(height: 102),
              state is SignInLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      text:  S.of(context).sign_in,
                      onPressed: () async {
                        if (authCubit.signInFormKey.currentState!.validate()) {
                          await authCubit.signInWithEmailAndPassword();
                        }
                      }),
            ],
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
          S.of(context).Forgot_Password,
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
