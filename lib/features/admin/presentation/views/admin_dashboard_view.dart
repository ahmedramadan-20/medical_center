import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_dashboard_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_dashboard_state.dart';
import 'package:medical_center/generated/l10n.dart';

/// Admin Dashboard view for managing the medical center application.
///
/// Displays statistics overview, quick actions, and navigation to all
/// admin management screens.
class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
          builder: (context, state) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context),
              if (state is AdminDashboardLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is AdminDashboardLoaded)
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildWelcomeCard(context),
                      const SizedBox(height: 24),
                      _buildSectionTitle(context, S.of(context).overview),
                      const SizedBox(height: 16),
                      _buildStatisticsGrid(context, state.stats),
                      const SizedBox(height: 24),
                      _buildSectionTitle(
                        context,
                        S.of(context).appointment_status,
                      ),
                      const SizedBox(height: 16),
                      _buildAppointmentStatusCard(context, state.stats),
                      const SizedBox(height: 24),
                      _buildSectionTitle(context, S.of(context).quick_actions),
                      const SizedBox(height: 16),
                      _buildQuickActionsGrid(context),
                      const SizedBox(height: 40),
                    ]),
                  ),
                )
              else if (state is AdminDashboardError)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.of(context).error_loading_dashboard,
                          style: AppTextStyles.cairo400Style20,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AdminDashboardCubit>()
                                .loadDashboardData();
                          },
                          child: Text(S.of(context).retry),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const SliverFillRemaining(child: SizedBox.shrink()),
            ],
          ),
        ),
      );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: 140,
        pinned: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: const BackButton(color: Colors.white),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            S.of(context).admin_dashboard,
            style: AppTextStyles.cairo400Style20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildWelcomeCard(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).welcome_back_admin,
                    style: AppTextStyles.cairo400Style20.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).system_operating_normally,
                        style: AppTextStyles.cairo300style16.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildSectionTitle(BuildContext context, String title) => Text(
        title,
        style: AppTextStyles.cairo400Style20.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );

  Widget _buildStatisticsGrid(BuildContext context, DashboardStats stats) =>
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.4,
        children: [
          _buildStatCard(
            context: context,
            title: S.of(context).total_users,
            value: stats.totalUsers.toString(),
            subtitle: '${stats.adminCount} ${S.of(context).admins}',
            icon: Icons.people_rounded,
            color: Colors.blue,
          ),
          _buildStatCard(
            context: context,
            title: S.of(context).total_doctors,
            value: stats.totalDoctors.toString(),
            subtitle:
                '${stats.totalSpecialities} ${S.of(context).specialities}',
            icon: Icons.medical_services_rounded,
            color: Colors.teal,
          ),
          _buildStatCard(
            context: context,
            title: S.of(context).appointments,
            value: stats.totalAppointments.toString(),
            subtitle:
                '${stats.pendingAppointments} ${S.of(context).pending.toLowerCase()}',
            icon: Icons.calendar_month_rounded,
            color: Colors.orange,
          ),
          _buildStatCard(
            context: context,
            title: S.of(context).avg_rating,
            value: stats.averageRating.toStringAsFixed(1),
            subtitle: '${stats.totalReviews} ${S.of(context).reviews}',
            icon: Icons.star_rounded,
            color: Colors.amber,
          ),
        ],
      );

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Text(
                  value,
                  style: AppTextStyles.cairo700style32.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.cairo300style16.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.cairo300style16.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildAppointmentStatusCard(
    BuildContext context,
    DashboardStats stats,
  ) =>
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildStatusRow(
              context: context,
              label: S.of(context).pending,
              count: stats.pendingAppointments,
              color: Colors.orange,
              total: stats.totalAppointments,
            ),
            const SizedBox(height: 12),
            _buildStatusRow(
              context: context,
              label: S.of(context).confirmed,
              count: stats.confirmedAppointments,
              color: Colors.blue,
              total: stats.totalAppointments,
            ),
            const SizedBox(height: 12),
            _buildStatusRow(
              context: context,
              label: S.of(context).completed,
              count: stats.completedAppointments,
              color: Colors.green,
              total: stats.totalAppointments,
            ),
            const SizedBox(height: 12),
            _buildStatusRow(
              context: context,
              label: S.of(context).cancelled,
              count: stats.cancelledAppointments,
              color: Colors.red,
              total: stats.totalAppointments,
            ),
          ],
        ),
      );

  Widget _buildStatusRow({
    required BuildContext context,
    required String label,
    required int count,
    required Color color,
    required int total,
  }) {
    final percentage = total > 0 ? (count / total) : 0.0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AppTextStyles.cairo300style16.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              count.toString(),
              style: AppTextStyles.cairo400Style20.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.3,
        children: [
          _buildQuickActionTile(
            context: context,
            title: S.of(context).manage_doctors,
            icon: Icons.medical_services_rounded,
            color: Colors.teal,
            onTap: () => context.push('/manageDoctors'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).manage_appointments,
            icon: Icons.calendar_month_rounded,
            color: Colors.orange,
            onTap: () => context.push('/manageAppointments'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).manage_users,
            icon: Icons.people_rounded,
            color: Colors.blue,
            onTap: () => context.push('/manageUsers'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).manage_specialities,
            icon: Icons.category_rounded,
            color: Colors.purple,
            onTap: () => context.push('/manageSpecialities'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).manage_blood_records,
            icon: Icons.bloodtype_rounded,
            color: Colors.red,
            onTap: () => context.push('/manageBloodRecords'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).manage_reviews,
            icon: Icons.reviews_rounded,
            color: Colors.amber,
            onTap: () => context.push('/manageReviews'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).notifications,
            icon: Icons.notifications_rounded,
            color: Colors.indigo,
            onTap: () => context.push('/sendNotification'),
          ),
          _buildQuickActionTile(
            context: context,
            title: S.of(context).analytics,
            icon: Icons.analytics_rounded,
            color: Colors.deepPurple,
            onTap: () => context.push('/analytics'),
          ),
        ],
      );

  Widget _buildQuickActionTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) =>
      Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cairo300style16.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
