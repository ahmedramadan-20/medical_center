import 'package:flutter/material.dart';
import 'package:medical_center/features/auth/presentation/widgets/welcome_text_widget.dart';
import '../widgets/custom_forgot_password_form.dart';
import '../widgets/forgot_password_image.dart';
import '../widgets/forgot_password_subtitle.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 108)),
          SliverToBoxAdapter(child: WelcomeTextWidget(text: 'نسيت كلمة السر ؟')),
          SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(child: ForgotPasswordImage()),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(child: ForgotPasswordSubtitle()),
          SliverToBoxAdapter(child: CustomForgotPasswordForm(),)
        ],
      ),
    );
  }
}
