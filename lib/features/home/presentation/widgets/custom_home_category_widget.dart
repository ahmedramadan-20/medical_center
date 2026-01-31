import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToItem(BuildContext itemContext) {
    // Scroll just enough to make the tapped/selected item visible.
    Scrollable.ensureVisible(
      itemContext,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is GetSpecialitiesSuccessState ||
            current is GetDoctorsSuccessState ||
            current is ChangeCategoryState ||
            current is DoctorsFilteredState,
        builder: (context, state) {
          final cubit = context.watch<HomeCubit>();

          return SizedBox(
            height: 105,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 5),
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final isSelected = cubit.selectedIndex == index;
                final specialty = cubit.specialities[index];

                return Builder(
                  builder: (itemContext) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.changeIndex(index);
                          _scrollToItem(itemContext);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      AppColors.babyBlue,
                                      AppColors.babyBlue.withValues(alpha: 0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isSelected ? null : AppColors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.babyBlue
                                          .withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : AppColors.babyBlue.withValues(alpha: 0.1),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: CachedNetworkImage(
                            imageUrl: specialty.image,
                            fit: BoxFit.contain,
                            color:
                                isSelected ? Colors.white : AppColors.babyBlue,
                            placeholder: (context, url) => Animate(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ).shimmer(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.medical_services_outlined,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.babyBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 75,
                        child: Text(
                          Localizations.localeOf(context).languageCode ==
                                  AppStrings.englishCode
                              ? specialty.enCategoryName
                              : specialty.arCategoryName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.cairo300style16.copyWith(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? AppColors.deepBlue
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              itemCount: cubit.specialities.length,
            ),
          );
        },
      );
}
