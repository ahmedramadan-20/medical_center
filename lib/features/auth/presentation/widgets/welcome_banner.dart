import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:medical_center/core/utils/app_assets.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 20,
            ),

            Lottie.asset(
              AppAssets.banner1,
              height: 250,
              width: 250,
              alignment: Alignment.bottomCenter,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     SvgPicture.asset(
            //       AppAssets.mosque,
            //     ),
            //     SvgPicture.asset(
            //       AppAssets.pyramids,
            //     ),
            //   ],
            // )
          ],
        ),
      );
}
