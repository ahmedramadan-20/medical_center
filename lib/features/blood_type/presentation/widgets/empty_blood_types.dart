import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

class EmptyBloodTypes extends StatelessWidget {
  const EmptyBloodTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Animate(
          child: Lottie.asset(
            AppAssets.noData,
            width: 200,
            height: 200,
            repeat: false,
          ),
        ).animate().moveX(),
        const SizedBox(height: 20),
        Animate(
          child: Center(
            child: Text(
              S.current.no_blood_types_found,
              style: AppTextStyles.cairo400Style20,
            ),
          ),
        ).animate().moveY(),
      ],
    );
  }
}
