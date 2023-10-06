import 'package:flutter/material.dart';
import 'package:medical_center/core/widgets/custom_button.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/have_an_account_widget.dart';
import '../widgets/terms_and_conditions.dart';
import '../widgets/welcome_text_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 152,
              ),
            ),
            const SliverToBoxAdapter(
              child: WelcomeTextWidget(
                text: 'Welcome !',
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(labelText: 'First Name'),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(labelText: 'Last Name'),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(labelText: 'Email Address'),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(labelText: 'Password'),
            ),
            const SliverToBoxAdapter(
              child: TermsAndConditionsWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 88,
              ),
            ),
            SliverToBoxAdapter(
              child: CustomButton(
                text: 'Sign Up',
                onPressed: () {},
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            const SliverToBoxAdapter(
              child: HaveAnAccountWidget(
                text1: 'Already have an account ? ',
                text2: 'Sign In',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
