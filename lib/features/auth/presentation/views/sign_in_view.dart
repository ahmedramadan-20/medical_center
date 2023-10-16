import 'package:flutter/material.dart';
import 'package:medical_center/core/functions/navigator.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_sign_in_form.dart';
import 'package:medical_center/features/auth/presentation/widgets/have_an_account_widget.dart';
import 'package:medical_center/features/auth/presentation/widgets/welcome_text_widget.dart';

import '../../../../generated/l10n.dart';
import '../widgets/welcome_banner.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: WelcomeBanner(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
            ),
          ),
          SliverToBoxAdapter(
            child: WelcomeTextWidget(text: S.of(context).welcome_back),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomSignInForm(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: HaveAnAccountWidget(
                text1: '${S.of(context).dont_have_an_account} ',
                text2: S.of(context).create_account,
                onTap: () {
                  navigateReplacement(context, '/signUp');
                }),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
