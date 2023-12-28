import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/custom_toast.dart';
import 'package:medical_center/core/functions/navigator.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/auth/presentation/widgets/terms_and_conditions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/l10n.dart';
import '../auth_cubit/auth_state.dart';
import 'custom_text_field.dart';

class CustomSignUpForm extends StatelessWidget {
  const CustomSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          showToast(S.of(context).success);
          navigateReplacement(context, '/signIn');
        } else if (state is SignUpErrorState) {
          showToast(state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signupFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: S.of(context).first_name,
                onChanged: (firstName) {
                  authCubit.firstName = firstName;
                },
                keyboardType: TextInputType.text,
              ),
              CustomTextFormField(
                labelText: S.of(context).last_name,
                onChanged: (lastName) {
                  authCubit.lastName = lastName;
                },
                keyboardType: TextInputType.text,
              ),
              CustomTextFormField(
                labelText: S.of(context).email_address,
                onChanged: (email) {
                  authCubit.emailAddress = email;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                labelText: S.of(context).phone_number,
                onChanged: (phone) {
                  authCubit.phoneNumber = phone;
                },
                keyboardType: TextInputType.phone,
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
                labelText: S.of(context).password,
                obscureText: authCubit.obscurePasswordTextValue,
                onChanged: (password) {
                  authCubit.password = password;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              _buildGenderRadioButtons(authCubit),
              _buildBloodTypeDropdown(authCubit),
              const TermsAndConditionsWidget(),
              const SizedBox(height: 22),
              state is SignUpLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      color:
                          authCubit.termsAndConditionsCheckBoxValue == false ||
                                  authCubit.gender == null ||
                                  authCubit.bloodType == null
                              ? AppColors.lightGrey
                              : null,
                      text: S.of(context).sign_up,
                      onPressed: () async {
                        if (authCubit.termsAndConditionsCheckBoxValue == true &&
                            authCubit.gender != null) {
                          if (authCubit.signupFormKey.currentState!
                              .validate()) {
                            await authCubit.signUpWithEmailAndPassword();
                          }
                        }
                      }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderRadioButtons(AuthCubit authCubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${S.current.gender} :",
            style: AppTextStyles.cairo300style16,
          ),
          Row(
            children: [
              Radio(
                activeColor: AppColors.primaryColor,
                value: 'male',
                groupValue: authCubit.gender,
                onChanged: (value) {
                  authCubit.selectGender(value: value.toString());
                },
              ),
              Text(
                S.current.male,
                style: AppTextStyles.cairo300style16,
              ),
              Radio(
                activeColor: AppColors.primaryColor,
                value: 'female',
                groupValue: authCubit.gender,
                onChanged: (value) {
                  authCubit.selectGender(value: value.toString());
                },
              ),
              Text(
                S.current.female,
                style: AppTextStyles.cairo300style16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeDropdown(AuthCubit authCubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            S.current.blood_type,
            style: AppTextStyles.cairo300style16,
          ),
          const SizedBox(width: 15),
          DropdownButton<String>(
            // dropdownColor: AppColors.babyBlue,
            style: AppTextStyles.cairo300style16,
            borderRadius: BorderRadius.circular(10),
            value: authCubit.bloodType,
            onChanged: (String? value) {
              authCubit.selectBloodType(value: value.toString());
            },
            items: authCubit.bloodTypes
                .map<DropdownMenuItem<String>>((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
