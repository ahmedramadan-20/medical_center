import 'package:flutter/material.dart';
import 'package:medical_center/core/functions/navigator.dart';
import '../../../../generated/l10n.dart';
import '../widgets/custom_sign_up_form.dart';
import '../widgets/have_an_account_widget.dart';
import '../widgets/welcome_text_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: WelcomeTextWidget(
                  text: S.of(context).welcome,
                ),
              ),
              // const SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 10,
              //   ),
              // ),
              const SliverToBoxAdapter(
                child: CustomSignUpForm(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: HaveAnAccountWidget(
                  text1: '${S.of(context).Have_an_Account} ',
                  text2: S.of(context).sign_in,
                  onTap: () {
                    navigateReplacement(context, '/signIn');
                  },
                ),
              ),
              // const SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 70,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
