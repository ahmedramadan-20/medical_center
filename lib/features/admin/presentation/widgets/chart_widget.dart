import 'package:flutter/material.dart';

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
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: barHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.6),
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
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        speciality.averageRating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
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
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '•',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${speciality.appointmentCount} appointments',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: widthRatio,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.6),
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
