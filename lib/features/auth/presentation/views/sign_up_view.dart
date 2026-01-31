import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_sign_up_form.dart';
import 'package:medical_center/features/auth/presentation/widgets/have_an_account_widget.dart';
import 'package:medical_center/features/auth/presentation/widgets/welcome_text_widget.dart';
import 'package:medical_center/generated/l10n.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      context.pushReplacement('/signIn');
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
