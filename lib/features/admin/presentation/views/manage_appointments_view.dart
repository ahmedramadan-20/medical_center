import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_appointments_cubit.dart';
import 'package:medical_center/features/appointments/data/models/appointment_model.dart';
import 'package:medical_center/generated/l10n.dart';

class ManageAppointmentsScreen extends StatefulWidget {
  const ManageAppointmentsScreen({super.key});

  @override
  State<ManageAppointmentsScreen> createState() =>
      _ManageAppointmentsScreenState();
}

class _ManageAppointmentsScreenState extends State<ManageAppointmentsScreen> {
  String _selectedFilter = 'all'; // Use lowercase English keys

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdminAppointmentsCubit()..getAllAppointments(),
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          body: BlocBuilder<AdminAppointmentsCubit, AdminAppointmentsState>(
            builder: (context, state) {
              var filteredAppointments = <AppointmentModel>[];
              if (state is AdminAppointmentsLoaded) {
                if (_selectedFilter == 'all') {
                  filteredAppointments = state.appointments;
                } else {
                  filteredAppointments = state.appointments
                      .where((a) => a.status.toLowerCase() == _selectedFilter)
                      .toList();
                }
              }

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(context),
                  SliverToBoxAdapter(
                    child: _buildFilterBar(),
                  ),
                  if (state is AdminAppointmentsLoading)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state is AdminAppointmentsLoaded)
                    filteredAppointments.isEmpty
                        ? SliverFillRemaining(
                            child: CustomEmptyWidget(
                              title: S.of(context).no_appointments_found,
                              subtitle:
                                  S.of(context).no_appointments_matching_filter,
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final appointment =
                                      filteredAppointments[index];
                                  return _buildAppointmentCard(
                                    context,
                                    appointment,
                                  );
                                },
                                childCount: filteredAppointments.length,
                              ),
                            ),
                          )
                  else if (state is AdminAppointmentsError)
                    SliverFillRemaining(
                      child: Center(child: Text('Error: ${state.message}')),
                    )
                  else
                    const SliverFillRemaining(
                      child: SizedBox.shrink(),
                    ),
                ],
              );
            },
          ),
        ),
      );

  Widget _buildFilterBar() {
    // Use lowercase English keys for filtering, but display localized text
    final filterKeys = [
      'all',
      'pending',
      'confirmed',
      'completed',
      'cancelled',
    ];
    final filterLabels = [
      S.of(context).all,
      S.of(context).pending,
      S.of(context).confirmed,
      S.of(context).completed,
      S.of(context).cancelled,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(filterKeys.length, (index) {
            final filterKey = filterKeys[index];
            final filterLabel = filterLabels[index];
            final isSelected = _selectedFilter == filterKey;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: Text(
                  filterLabel,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.deepBlue,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filterKey;
                  });
                },
                selectedColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: 120,
        pinned: true,
        elevation: 0,
        backgroundColor: AppColors.deepBlue,
        leading: const BackButton(color: Colors.white),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            S.of(context).manage_appointments,
            style: AppTextStyles.cairo400Style20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.deepBlue, AppColors.primaryColor],
              ),
            ),
          ),
        ),
      );

  Widget _buildAppointmentCard(
    BuildContext context,
    AppointmentModel appointment,
  ) {
    Color statusColor;
    switch (appointment.status.toLowerCase()) {
      case 'confirmed':
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      case 'completed':
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.event_note_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.patientName,
                        style: AppTextStyles.cairo400Style20.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBlue,
                        ),
                      ),
                      Text(
                        S.of(context).with_dr_specialty(
                              _getDoctorName(appointment),
                              _getDoctorSpecialty(appointment),
                            ),
                        style: AppTextStyles.cairo300style16.copyWith(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(
                  _getLocalizedStatus(appointment.status),
                  statusColor,
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appointment.date,
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appointment.time,
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_rounded,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appointment.patientPhone,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (appointment.status.toLowerCase() != 'completed' &&
                appointment.status.toLowerCase() != 'cancelled')
              Row(
                children: [
                  if (appointment.status.toLowerCase() == 'pending')
                    _buildActionButton(
                      label: S.of(context).confirm,
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                      onPressed: () => context
                          .read<AdminAppointmentsCubit>()
                          .updateAppointmentStatus(appointment, 'confirmed'),
                    ),
                  if (appointment.status.toLowerCase() == 'confirmed')
                    _buildActionButton(
                      label: S.of(context).complete,
                      icon: Icons.task_alt_rounded,
                      color: Colors.blue,
                      onPressed: () => context
                          .read<AdminAppointmentsCubit>()
                          .updateAppointmentStatus(appointment, 'completed'),
                    ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    label: S.of(context).cancel,
                    icon: Icons.cancel_outlined,
                    color: Colors.redAccent,
                    onPressed: () => context
                        .read<AdminAppointmentsCubit>()
                        .updateAppointmentStatus(appointment, 'cancelled'),
                  ),
                ],
              ),
            const Divider(height: 32),
            Row(
              children: [
                Icon(
                  Icons.history_toggle_off_rounded,
                  size: 14,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 8),
                Text(
                  S.of(context).reserved_on(
                        DateFormat('MMM dd, yyyy HH:mm').format(
                            DateTime.parse(appointment.bookingCreatedAt),),
                      ),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status.toUpperCase(),
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 10,),
        ),
      );

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) =>
      Expanded(
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 16),
          label: Text(label, style: const TextStyle(fontSize: 11)),
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            side: BorderSide(color: color.withValues(alpha: 0.5)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      );

  /// Returns the localized status text based on the appointment status.
  String _getLocalizedStatus(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return S.of(context).confirmed;
      case 'pending':
        return S.of(context).pending;
      case 'completed':
        return S.of(context).completed;
      case 'cancelled':
        return S.of(context).cancelled;
      default:
        return status;
    }
  }

  /// Returns the doctor name based on current locale.
  String _getDoctorName(AppointmentModel appointment) {
    // Check if doctorData exists and has localized names
    final doctorData = appointment.doctorData;

    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final arName = doctorData['arName'];
    final enName = doctorData['enName'];

    if (isArabic && arName != null) {
      return arName;
    }
    if (enName != null) {
      return enName;
    }

    // Fallback to doctorName if localized names not available
    return appointment.doctorName;
  }

  /// Returns the doctor specialty based on current locale.
  String _getDoctorSpecialty(AppointmentModel appointment) {
    // Check if doctorData exists and has localized specializations
    final doctorData = appointment.doctorData;

    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final arSpecialization = doctorData['arSpecialization'];
    final enSpecialization = doctorData['enSpecialization'];

    if (isArabic && arSpecialization != null) {
      return arSpecialization;
    }
    if (enSpecialization != null) {
      return enSpecialization;
    }

    // Fallback to doctorSpecialty if localized specializations not available
    return appointment.doctorSpecialty;
  }
}
