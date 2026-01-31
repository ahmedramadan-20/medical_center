import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/functions/custom_toast.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_button.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:medical_center/generated/l10n.dart';

class CustomSignInForm extends StatelessWidget {
  const CustomSignInForm({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            FirebaseAuth.instance.currentUser!.emailVerified
                ? context.pushReplacement('/homeNavBar')
                : showToast(context, S.of(context).verify);
          } else if (state is SignInErrorState) {
            showToast(context, state.errMessage);
          }
        },
        builder: (context, state) {
          final authCubit = BlocProvider.of<AuthCubit>(context);
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
                      authCubit.obscurePasswordTextValue ?? false
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: authCubit.obscurePasswordText,
                  ),
                  labelText: S.of(context).password,
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
                if (state is SignInLoadingState)
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  )
                else
                  CustomButton(
                    text: S.of(context).sign_in,
                    onPressed: () async {
                      if (authCubit.signInFormKey.currentState!.validate()) {
                        await authCubit.signInWithEmailAndPassword();
                      }
                    },
                  ),
              ],
            ),
          );
        },
      );
}

class ForgetPasswordTextWidget extends StatelessWidget {
  const ForgetPasswordTextWidget({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          context.pushReplacement('/forgotPassword');
        },
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            S.of(context).Forgot_Password,
            style: AppTextStyles.cairo700style32.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
}
