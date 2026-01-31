import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/utils/time_formatter.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/reviews/presentation/manager/review_cubit.dart';
import 'package:medical_center/features/reviews/presentation/manager/review_state.dart';
import 'package:medical_center/generated/l10n.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({
    required this.model,
    super.key,
  });

  final DoctorsModel model;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) =>
            getIt<ReviewCubit>()..getDoctorReviews(model.docId ?? ''),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(context),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          _buildProfileInfo(context),
                          const SizedBox(height: 24),
                          _buildStatBar(context),
                          const SizedBox(height: 32),
                          _buildSectionHeader(context, S.of(context).specialty),
                          const SizedBox(height: 12),
                          _buildSpecialtySection(context),
                          const SizedBox(height: 32),
                          _buildSectionHeader(
                            context,
                            S.of(context).workingDays,
                          ),
                          const SizedBox(height: 16),
                          _buildTimelineSchedule(context),
                          const SizedBox(height: 32),
                          _buildSectionHeader(
                            context,
                            S.of(context).patientReviews,
                            trailing: _buildAverageRatingChip(context),
                          ),
                          const SizedBox(height: 16),
                          _buildReviewsList(context),
                          const SizedBox(height: 140), // Space for footer
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildFloatingBookingBar(context),
            ],
          ),
        ),
      );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: 400,
        pinned: true,
        stretch: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: _buildGlassIconButton(
            context,
            onTap: () => Navigator.pop(context),
            icon: Icons.arrow_back_ios_new,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: _buildGlassIconButton(
              context,
              onTap: () {},
              icon: Icons.share_outlined,
            ),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ],
          background: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: model.docId ?? '',
                child: CachedNetworkImage(
                  imageUrl: model.image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              // Top Gradient for better visibility of control buttons
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.25],
                  ),
                ),
              ),
              // Bottom Gradient for better readability of content over image
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                    stops: const [0.6, 0.8, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildGlassIconButton(
    BuildContext context, {
    required VoidCallback onTap,
    required IconData icon,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 20,
              ),
            ),
          ),
        ),
      );

  Widget _buildProfileInfo(BuildContext context) {
    final name =
        Localizations.localeOf(context).languageCode == AppStrings.englishCode
            ? model.enName
            : model.arName;
    final specialty =
        Localizations.localeOf(context).languageCode == AppStrings.englishCode
            ? model.enSpecialization
            : model.arSpecialization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).dr}$name',
                    style: AppTextStyles.cairo400Style20.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_rounded,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    S.of(context).verified,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBar(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem(
              context,
              S.of(context).experience,
              '${model.experienceYears}+',
              Icons.work_history_rounded,
              Colors.blue,
            ),
            _buildStatDivider(context),
            _buildStatItem(
              context,
              S.of(context).rating,
              model.averageRating.toStringAsFixed(1),
              Icons.star_rounded,
              Colors.amber,
            ),
            _buildStatDivider(context),
            _buildStatItem(
              context,
              S.of(context).reviews,
              '${model.numberOfReviews}',
              Icons.chat_bubble_rounded,
              Colors.purple,
            ),
          ],
        ),
      );

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) =>
      Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ],
      );

  Widget _buildStatDivider(BuildContext context) => Container(
        height: 40,
        width: 1,
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
      );

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    Widget? trailing,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.cairo400Style20.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (trailing != null) trailing,
        ],
      );

  Widget _buildSpecialtySection(BuildContext context) {
    final specialty =
        Localizations.localeOf(context).languageCode == AppStrings.englishCode
            ? model.enSpecialization
            : model.arSpecialization;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.medical_services_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specialty,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  S.of(context).specialistPractitioner,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSchedule(BuildContext context) {
    final sortedSchedules = List.of(model.schedules);
    sortedSchedules.sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

    return Column(
      children: sortedSchedules.asMap().entries.map((entry) {
        final index = entry.key;
        final schedule = entry.value;
        final dayName = _localizedDayHelper(schedule.dayOfWeek, context);
        final hours = TimeFormatter.formatTimeRange(
          schedule.startTime,
          schedule.endTime,
          context,
        );
        final isToday = schedule.dayOfWeek == DateTime.now().weekday;
        final isLast = index == sortedSchedules.length - 1;

        return IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: isToday
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isToday
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.5),
                        width: 2,
                      ),
                      boxShadow: isToday
                          ? [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: isToday
                        ? const Icon(Icons.check, color: Colors.white, size: 10)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isToday
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.05)
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isToday
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1)
                            : Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayName,
                              style: TextStyle(
                                fontWeight:
                                    isToday ? FontWeight.bold : FontWeight.w600,
                                fontSize: 15,
                                color: isToday
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hours,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.5),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        if (isToday)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              S.of(context).today,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAverageRatingChip(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              model.averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );

  Widget _buildReviewsList(BuildContext context) =>
      BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ReviewSuccess) {
            if (state.reviews.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text(S.of(context).noReviewsYet)),
              );
            }
            return Column(
              children: state.reviews
                  .take(3)
                  .map((review) => _buildReviewTile(context, review))
                  .toList(),
            );
          } else if (state is ReviewError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      );

  Widget _buildReviewTile(BuildContext context, dynamic review) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
                  radius: 20,
                  child: Text(
                    review.userName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < review.rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      );

  Widget _buildFloatingBookingBar(BuildContext context) {
    final workingToday =
        model.schedules.any((s) => s.dayOfWeek == DateTime.now().weekday);

    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: workingToday
                  ? () => context.push('/bookAppointment', extra: model)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                disabledBackgroundColor: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.1),
                disabledForegroundColor: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.3),
                elevation: 0,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                workingToday ? S.of(context).bookNow : S.of(context).notWorking,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _localizedDayHelper(int dayOfWeek, BuildContext context) {
    final now = DateTime.now();
    final daysUntil = (dayOfWeek - now.weekday + 7) % 7;
    final date = now.add(Duration(days: daysUntil));
    return DateFormat.EEEE(Localizations.localeOf(context).languageCode)
        .format(date);
  }
}
