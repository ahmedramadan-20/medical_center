import 'package:flutter/material.dart';
import 'package:medical_center/core/functions/navigator.dart';
import '../widgets/custom_sign_up_form.dart';
import '../widgets/have_an_account_widget.dart';
import '../widgets/welcome_text_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              child: CustomSignUpForm(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: HaveAnAccountWidget(
                text1: 'Already have an account ? ',
                text2: 'Sign In',
                onTap: (){
                  customNavigate(context, '/signIn');
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 70,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
