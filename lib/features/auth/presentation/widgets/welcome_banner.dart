import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_assets.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 280,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        // color: AppColors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20,),

          Lottie.asset(
            AppAssets.banner1,
            height: 250,
            width: 250,
            alignment: Alignment.bottomCenter,

          ),
          // Text(
          //   S.of(context).Sign_in_title,
          //   style:
          //       AppTextStyles.cairo700style32.copyWith(color: AppColors.white),
          // ),



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
}
