import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

import '../../../../core/widgets/custom_header_text.dart';
import '../../../../generated/l10n.dart';
import '../widgets/custom_appbar_title_widget.dart';
import '../widgets/profile_avatar_and_name_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverToBoxAdapter(
            child: CustomAppBarTitle(text: S.of(context).profile),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          const SliverToBoxAdapter(
            child: ProfileAvatarAndName(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
          SliverToBoxAdapter(
              child: CustomHeaderText(text: S.of(context).account)),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          const SliverToBoxAdapter(
            child: CustomProfileListTile(),
          ),
        ]),
      ),
    );
  }
}

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        tileColor: AppColors.white,
        onTap: () {},
        trailing: Icon(
          Localizations.localeOf(context).languageCode ==
                  AppStrings.englishCode
              ? Icons.arrow_forward_ios_rounded
              : Icons.arrow_back_ios_new_rounded,
          color: AppColors.deepBlue,
        ),
        leading: const Icon(
          Icons.person,
          color: AppColors.deepBlue,
        ),
        title: Text(
          S.of(context).edit_profile,
          style: AppTextStyles.cairo400Style20
              .copyWith(color: AppColors.deepBlue),
        ),
      )
    ]);
  }
}
