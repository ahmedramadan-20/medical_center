import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/admin/data/models/dashboard_stats_model.dart';
import 'package:medical_center/generated/l10n.dart';

/// Simple bar chart widget for appointment trends
class AppointmentTrendChart extends StatelessWidget {
  const AppointmentTrendChart({
    required this.trends,
    super.key,
  });

  final List<TrendDataModel> trends;

  @override
  Widget build(BuildContext context) {
    if (trends.isEmpty) {
      return Center(
        child: Text(S.of(context).no_data_available),
      );
    }

    final maxValue = trends.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minValue = trends.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: trends.map((trend) {
            final heightRatio =
                range > 0 ? (trend.value - minValue) / range : 0.5;
            final barHeight = 100.0 + (heightRatio * 80);

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Text(
                      trend.value.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: barHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withValues(alpha: 0.6),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      trend.label,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Speciality statistics widget
class SpecialityStatsWidget extends StatelessWidget {
  const SpecialityStatsWidget({
    required this.specialities,
    super.key,
  });

  final List<SpecialityStatsModel> specialities;

  @override
  Widget build(BuildContext context) {
    if (specialities.isEmpty) {
      return Center(
        child: Text(S.of(context).no_speciality_data),
      );
    }

    final maxAppointments = specialities
        .map((e) => e.appointmentCount)
        .reduce((a, b) => a > b ? a : b);

    return Column(
      children: specialities.map((speciality) {
        final widthRatio = maxAppointments > 0
            ? speciality.appointmentCount / maxAppointments
            : 0.0;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: AppColors.lightGrey.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      speciality.speciality,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.yellow, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        speciality.averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${speciality.doctorCount} doctors',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '•',
                    style: TextStyle(color: AppColors.grey),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${speciality.appointmentCount} appointments',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: widthRatio,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.blue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
