import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_state.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 100,
          child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SizedBox(
                    width: 70,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<HomeCubit>(context).changeIndex(
                          index,
                        );
                        BlocProvider.of<HomeCubit>(context).selectedIndex =
                            index;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: BlocProvider.of<HomeCubit>(context)
                                        .selectedIndex ==
                                    index
                                ? AppColors.babyBlue.withOpacity(0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border:
                                context.read<HomeCubit>().selectedIndex == index
                                    ? Border.all(
                                        color: AppColors.babyBlue, width: 1)
                                    : null),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(),
                              child: CachedNetworkImage(
                                imageUrl: BlocProvider.of<HomeCubit>(context)
                                    .specialities[index]
                                    .image,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                placeholder: (context, url) => Animate(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: AppColors.grey,
                                        borderRadius: BorderRadius.circular(5)),
                                  ).animate().shimmer(),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                textAlign: TextAlign.center,
                                Localizations.localeOf(context).languageCode ==
                                        AppStrings.englishCode
                                    ? context
                                        .read<HomeCubit>()
                                        .specialities[index]
                                        .enCategoryName
                                    : context
                                        .read<HomeCubit>()
                                        .specialities[index]
                                        .arCategoryName,
                                style: AppTextStyles.cairo300style16.copyWith(
                                  fontSize: 12,
                                  color:
                                      context.read<HomeCubit>().selectedIndex ==
                                              index
                                          ? AppColors.deepBlue
                                          : AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount: context.read<HomeCubit>().specialities.length),
        );
      },
    );
  }
}
