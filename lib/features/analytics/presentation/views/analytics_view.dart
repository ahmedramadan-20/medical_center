import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/analytics/presentation/manager/analytics_cubit.dart';
import 'package:medical_center/features/analytics/presentation/manager/analytics_state.dart';
import 'package:medical_center/generated/l10n.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AnalyticsCubit()..loadAnalytics(),
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            title: Text(
              S.of(context).analytics_reports,
              style: AppTextStyles.cairo400Style20,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              if (state is AnalyticsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AnalyticsError) {
                return Center(child: Text(state.message));
              }

              if (state is AnalyticsLoaded) {
                final analytics = state.analytics;

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<AnalyticsCubit>().loadAnalytics(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(context, S.of(context).overview),
                        const SizedBox(height: 16),
                        _buildOverviewCards(context, analytics),
                        const SizedBox(height: 32),
                        _buildSectionTitle(
                          context,
                          S.of(context).appointment_status,
                        ),
                        const SizedBox(height: 16),
                        _buildAppointmentStatusChart(context, analytics),
                        const SizedBox(height: 32),
                        _buildSectionTitle(context, S.of(context).top_doctors),
                        const SizedBox(height: 16),
                        _buildTopDoctorsList(context, analytics),
                      ],
                    ),
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );

  Widget _buildSectionTitle(BuildContext context, String title) => Text(
        title,
        style: AppTextStyles.cairo400Style20.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.deepBlue,
        ),
      );

  Widget _buildOverviewCards(BuildContext context, analytics) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  S.of(context).total_appointments,
                  analytics.totalAppointments.toString(),
                  Icons.event_note,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  S.of(context).total_users,
                  analytics.totalUsers.toString(),
                  Icons.people,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  S.of(context).total_doctors,
                  analytics.totalDoctors.toString(),
                  Icons.medical_services,
                  AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  S.of(context).average_rating,
                  analytics.averageRating.toStringAsFixed(1),
                  Icons.star,
                  Colors.amber,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) =>
      Container(
        padding: const EdgeInsets.all(16),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyles.cairo400Style20.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTextStyles.cairo300style16.copyWith(
                    fontSize: 11,
                    color: AppColors.deepGrey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildAppointmentStatusChart(BuildContext context, analytics) =>
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildStatusRow(
              context,
              S.of(context).pending,
              analytics.pendingAppointments,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildStatusRow(
              context,
              S.of(context).confirmed,
              analytics.confirmedAppointments,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildStatusRow(
              context,
              S.of(context).completed,
              analytics.completedAppointments,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildStatusRow(
              context,
              S.of(context).cancelled,
              analytics.cancelledAppointments,
              Colors.red,
            ),
          ],
        ),
      );

  Widget _buildStatusRow(
    BuildContext context,
    String label,
    int count,
    Color color,
  ) =>
      Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.cairo300style16.copyWith(fontSize: 14),
            ),
          ),
          Text(
            count.toString(),
            style: AppTextStyles.cairo400Style20.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      );

  Widget _buildTopDoctorsList(BuildContext context, analytics) {
    if (analytics.topDoctors.isEmpty) {
      return const CustomEmptyWidget(
        title: 'No Data',
        subtitle: 'No doctor performance data available',
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: analytics.topDoctors.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: AppColors.lightGrey.withValues(alpha: 0.5),
        ),
        itemBuilder: (context, index) {
          final doctor = analytics.topDoctors[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              doctor.doctorName,
              style: AppTextStyles.cairo400Style20.copyWith(fontSize: 16),
            ),
            subtitle: Text(
              '${doctor.totalAppointments} ${S.of(context).appointments} • ${doctor.rating.toStringAsFixed(1)} ⭐',
              style: AppTextStyles.cairo300style16.copyWith(fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
