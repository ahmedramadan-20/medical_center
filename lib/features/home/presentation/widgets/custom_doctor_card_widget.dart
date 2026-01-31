import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/functions/custom_toast.dart';

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
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .shadow
                    .withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                ),
                              ).shimmer(),
                              errorWidget: (context, url, error) => Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                child: Icon(
                                  Icons.person,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    localizedDaysTyped.join(', '),
                                    style:
                                        AppTextStyles.cairo300style16.copyWith(
                                      fontSize: 11,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.5),
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
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.5),
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
                      showToast(context, S.of(context).favorite_added);
                    } else if (favState is FavoriteRemoved) {
                      showToast(context, S.of(context).favorite_removed);
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
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .shadow
                                  .withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
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
