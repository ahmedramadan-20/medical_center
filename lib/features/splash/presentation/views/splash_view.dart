import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/core/utils/app_assets.dart';
import 'package:medical_center/core/utils/app_colors.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/services/service_locator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    bool isOnBoardingVisited =
        getIt<CacheHelper>().getData(key: 'isOnBoardingVisited') ?? false;
    if (isOnBoardingVisited == true) {
      FirebaseAuth.instance.currentUser == null
          ? delayedNavigation(context, '/signIn')
          : FirebaseAuth.instance.currentUser!.emailVerified == true
              ? delayedNavigation(context, '/homeNavBar')
              : delayedNavigation(context, '/signIn');
    } else {
      delayedNavigation(context, '/onBoarding');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Center(
        child: Lottie.asset(
          AppAssets.splashLogo,
          repeat: false,
        ),
        // FadeAnimation(
        //
        //   delay: 0.2,
        //   child: Image.asset(
        //     AppAssets.splashIcon,
        //     width: 200,
        //     height: 200,
        //   ),
        // ),
      ),
    );
  }
}

void delayedNavigation(context, path) {
  Future.delayed(const Duration(seconds: 4), () {
    navigateReplacement(context, path);
  });
}
