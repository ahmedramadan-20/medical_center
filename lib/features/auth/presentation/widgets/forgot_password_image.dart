import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:medical_center/core/utils/app_assets.dart';

class ForgotPasswordImage extends StatelessWidget {
  const ForgotPasswordImage({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 235,
        width: 235,
        child: Lottie.asset(AppAssets.password1),
      );
}
