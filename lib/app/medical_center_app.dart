import 'package:flutter/material.dart';
import 'package:medical_center/core/routes/app_router.dart';
import 'package:medical_center/core/utils/app_colors.dart';

class MedicalCenter extends StatelessWidget {
  const MedicalCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.offWhite
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
