import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_doctors_cubit.dart';
import 'package:medical_center/features/admin/presentation/widgets/dashboard_search_bar.dart';
import 'package:medical_center/generated/l10n.dart';

class ManageDoctorsScreen extends StatelessWidget {
  const ManageDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdminDoctorsCubit()..getAllDoctors(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: BlocBuilder<AdminDoctorsCubit, AdminDoctorsState>(
            builder: (context, state) => CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: DashboardSearchBar(
                      hintText: S.of(context).search_by_name_or_specialty,
                      onSearch: (query) {
                        context.read<AdminDoctorsCubit>().searchDoctors(query);
                      },
                    ),
                  ),
                ),
                if (state is AdminDoctorsLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state is AdminDoctorsLoaded)
                  state.doctors.isEmpty
                      ? SliverFillRemaining(
                          child: CustomEmptyWidget(
                            title: S.of(context).no_doctors_found,
                            subtitle: S.of(context).no_doctors_registered,
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.all(20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final doctor = state.doctors[index];
                                return _buildDoctorCard(context, doctor);
                              },
                              childCount: state.doctors.length,
                            ),
                          ),
                        )
                else if (state is AdminDoctorsError)
                  SliverFillRemaining(
                    child: Center(child: Text('Error: ${state.message}')),
                  )
                else
                  const SliverFillRemaining(
                    child: SizedBox.shrink(),
                  ),
              ],
            ),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.push('/addDoctor');
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                S.of(context).add_doctor,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: 120,
        pinned: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            S.of(context).manage_doctors,
            style: AppTextStyles.cairo400Style20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildDoctorCard(BuildContext context, doctor) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.push('/editDoctor', extra: doctor);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: doctor.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.primary,
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
                          Text(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? doctor.arName
                                : doctor.enName,
                            style: AppTextStyles.cairo400Style20.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? doctor.arSpecialization
                                : doctor.enSpecialization,
                            style: AppTextStyles.cairo300style16.copyWith(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.orange[400],
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.grey[400],
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${doctor.schedules.length} shifts',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit_note_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            context.push('/editDoctor', extra: doctor);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_sweep_rounded,
                            color: Colors.redAccent,
                          ),
                          onPressed: () =>
                              _showDeleteConfirmation(context, doctor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _showDeleteConfirmation(BuildContext context, doctor) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(S.of(context).delete_doctor),
        content: Text(
          S.of(context).delete_doctor_confirmation(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? doctor.arName
                    : doctor.enName,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              context.read<AdminDoctorsCubit>().deleteDoctor(doctor);
              Navigator.pop(dialogContext);
            },
            child: Text(
              S.of(context).delete,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
