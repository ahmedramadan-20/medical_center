import 'package:flutter/material.dart';
import 'package:medical_center/features/auth/presentation/widgets/welcome_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../widgets/custom_forgot_password_form.dart';
import '../widgets/forgot_password_image.dart';
import '../widgets/forgot_password_subtitle.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 90)),
          SliverToBoxAdapter(child: WelcomeTextWidget(text: S.of(context).Forgot_Password)),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          const SliverToBoxAdapter(child: ForgotPasswordImage()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const SliverToBoxAdapter(child: ForgotPasswordSubtitle()),
          const SliverToBoxAdapter(child: CustomForgotPasswordForm(),)
        ],
      ),
    );
  }
}
