import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_assets.dart';
import 'package:medical_center/core/utils/app_colors.dart';

import '../../../../core/functions/navigator.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    delayedNavigation(context);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Center(
        child: Image.asset(AppAssets.splash_two,width: 150,height: 150,),
      ),
    );
  }
}

void delayedNavigation(context) {
  Future.delayed(const Duration(seconds: 4),(){
    navigateReplacement(context,'/onBoarding');

  });
}
