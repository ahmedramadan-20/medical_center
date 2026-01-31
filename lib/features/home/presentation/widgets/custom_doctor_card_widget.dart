import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/functions/custom_toast.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/utils/time_formatter.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_state.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';
import 'package:medical_center/generated/l10n.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    required this.model,
    required this.onTap,
    super.key,
  });

  final DoctorsModel model;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // Format day names based on app language
    final localizedDaysTyped = <String>[];
    final sortedSchedules = List.of(model.schedules);
    sortedSchedules.sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

    for (final schedule in sortedSchedules) {
      localizedDaysTyped.add(_localizedDayHelper(schedule.dayOfWeek, context));
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final favoritesCubit = context.watch<FavoritesCubit>();
        final isFavorite = favoritesCubit.isFavorite(model.id.toString());

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.babyBlue.withValues(alpha: 0.08),
              width: 1.5,
            ),
          ),
          child: Stack(
            children: [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Hero(
                          tag: model.enName,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: model.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Animate(
                                child: Container(
                                  color: Colors.grey[200],
                                ),
                              ).shimmer(),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[100],
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${S.of(context).dr}${Localizations.localeOf(context).languageCode == AppStrings.arabicCode ? model.arName : model.enName}',
                                    style:
                                        AppTextStyles.cairo400Style20.copyWith(
                                      color: AppColors.deepBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.babyBlue
                                        .withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: AppColors.babyBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              Localizations.localeOf(context).languageCode ==
                                      AppStrings.arabicCode
                                  ? model.arSpecialization
                                  : model.enSpecialization,
                              style: AppTextStyles.cairo300style16.copyWith(
                                color: AppColors.babyBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    localizedDaysTyped.join(', '),
                                    style:
                                        AppTextStyles.cairo300style16.copyWith(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            if (model.schedules.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      TimeFormatter.formatTimeRange(
                                        model.schedules.first.startTime,
                                        model.schedules.first.endTime,
                                        context,
                                      ),
                                      style: AppTextStyles.cairo300style16
                                          .copyWith(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Favorite Button
              Positioned(
                top: 4,
                right: 4,
                child: BlocListener<FavoritesCubit, FavoritesState>(
                  listener: (context, favState) {
                    if (favState is FavoriteAdded) {
                      showToast(S.of(context).favorite_added);
                    } else if (favState is FavoriteRemoved) {
                      showToast(S.of(context).favorite_removed);
                    }
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        favoritesCubit.toggleFavorite(model.id.toString());
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : AppColors.deepGrey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _localizedDayHelper(int dayOfWeek, BuildContext context) {
    // dayOfWeek 1 = Monday
    final now = DateTime.now();
    final daysUntil = (dayOfWeek - now.weekday + 7) % 7;
    final date = now.add(Duration(days: daysUntil));

    return DateFormat.EEEE(Localizations.localeOf(context).languageCode)
        .format(date);
  }
}
