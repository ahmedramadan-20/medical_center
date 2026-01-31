import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'package:medical_center/core/utils/app_assets.dart';
import 'package:medical_center/core/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    final isOnBoardingVisited =
        getIt<CacheHelper>().getData(key: 'isOnBoardingVisited') ?? false;

    final String nextRoute;
    if (isOnBoardingVisited == true) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        nextRoute = '/signIn';
      } else if (user.emailVerified == true) {
        nextRoute = '/homeNavBar';
      } else {
        nextRoute = '/signIn';
      }
    } else {
      nextRoute = '/onBoarding';
    }

    // Schedule navigation; cancel in dispose to avoid pending timers.
    _navigationTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      context.go(nextRoute);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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

