import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/widgets/custom_change_lang_button.dart';
import '../../../../core/widgets/custom_header_text.dart';
import '../../../../generated/l10n.dart';

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ListTile(
        tileColor: AppColors.white,
        onTap: () {},
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.deepBlue,
        ),
        leading: const Icon(
          Icons.person,
          color: AppColors.deepBlue,
        ),
        title: Text(
          S.of(context).edit_profile,
          style:
              AppTextStyles.cairo400Style20.copyWith(color: AppColors.deepBlue),
        ),
      ),
      const SizedBox(
        height: 32,
      ),
      CustomHeaderText(text: S.of(context).general),
      const SizedBox(
        height: 24,
      ),
      ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        collapsedIconColor: AppColors.deepBlue,
        iconColor: AppColors.deepBlue,
        leading: const Icon(
          Icons.location_on_rounded,
          color: AppColors.deepBlue,
        ),
        collapsedBackgroundColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          S.of(context).address,
          style:
              AppTextStyles.cairo400Style20.copyWith(color: AppColors.deepBlue),
        ),
        children: <Widget>[
          ListTile(
              title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).clinics}: ${S.of(context).mit_azzoun}",
                style: AppTextStyles.cairo300style16,
              ),
              Text(
                "${S.of(context).joint}: ${S.of(context).street}",
                style: AppTextStyles.cairo300style16,
              ),
            ],
          )),
        ],
      ),
      const SizedBox(
        height: 24,
      ),
      ExpansionTile(
        collapsedIconColor: AppColors.deepBlue,
        iconColor: AppColors.deepBlue,
        leading: const Icon(
          Icons.phone,
          color: AppColors.deepBlue,
        ),
        collapsedBackgroundColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          S.of(context).booking,
          style:
              AppTextStyles.cairo400Style20.copyWith(color: AppColors.deepBlue),
        ),
        children: <Widget>[
          ListTile(
              title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).phone}: 01202027567",
                style: AppTextStyles.cairo300style16,
              ),
              Text(
                "${S.of(context).landline}: 0502053187",
                style: AppTextStyles.cairo300style16,
              ),
            ],
          )),
        ],
      ),
      const SizedBox(
        height: 24,
      ),
      ListTile(
        tileColor: AppColors.white,
        trailing: const ChangeLanguageButton(),
        leading: const Icon(
          Icons.language,
          color: AppColors.deepBlue,
        ),
        title: Text(
          S.of(context).language,
          style:
              AppTextStyles.cairo400Style20.copyWith(color: AppColors.deepBlue),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      ListTile(
        tileColor: AppColors.white,
        onTap: () {
          FirebaseAuth.instance.signOut();
          navigateReplacement(context, '/signIn');
        },
        trailing: const Icon(
          Icons.logout,
          color: AppColors.deepBlue,
        ),
        leading: const Icon(
          Icons.person,
          color: AppColors.deepBlue,
        ),
        title: Text(
          S.of(context).sign_out,
          style:
              AppTextStyles.cairo400Style20.copyWith(color: AppColors.deepBlue),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
    ]);
  }
}
