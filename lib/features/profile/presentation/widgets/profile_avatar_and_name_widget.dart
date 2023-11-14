import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_text_styles.dart';

class ProfileAvatarAndName extends StatelessWidget {
  const ProfileAvatarAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: AppColors.primaryColor),
            child: CachedNetworkImage(
              imageUrl: userImage,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Animate(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.grey,
                      ),
                    ).animate().shimmer(),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahmed Ramadan',
                style: AppTextStyles.cairo400Style20
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4,),
              Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: AppTextStyles.cairo400Style20
                    .copyWith(fontSize: 18,color: AppColors.deepGrey ),
              ),

            ],
          )
        ],
      ),
    );
  }
}