import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_assets.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).hello,
                      style: AppTextStyles.cairo300style16
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      BlocProvider.of<HomeCubit>(context)
                          .originalUser!
                          .firstName,
                      style: AppTextStyles.cairo300style16
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Text(
                  S.of(context).subtitle,
                  style: AppTextStyles.cairo300style16.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        image: AssetImage(AppAssets.appLogo))),
              )
            ],
          ),
        ]);
      },
    );
  }
}
