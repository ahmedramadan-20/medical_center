import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              navigateReplacement(context, '/signIn');
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // navigateReplacement(context, '/signIn');
            },
            icon: const Icon(
              Icons.menu,
              color: AppColors.primaryColor,
            ),
          );
        }),
        title: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).hello,
                style: AppTextStyles.cairo300style16
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                S.of(context).subtitle,
                style: AppTextStyles.cairo300style16
                    .copyWith(fontSize: 12, color: AppColors.deepBlue),
              ),
            ],
          ),
        ),
      ),
      drawer: const Drawer(),
      body: Center(
      ),
    );
  }
}
