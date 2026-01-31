import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/appointments/data/models/review_model.dart';
import 'package:medical_center/features/appointments/presentation/manager/appointment_cubit.dart';
import 'package:medical_center/features/appointments/presentation/manager/appointment_state.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/reviews/presentation/manager/review_cubit.dart';
import 'package:medical_center/features/reviews/presentation/manager/review_state.dart';
import 'package:medical_center/generated/l10n.dart';

class MyAppointmentsView extends StatelessWidget {
  const MyAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppointmentCubit()
              ..getUserAppointments(
                FirebaseAuth.instance.currentUser?.email ?? '',
              ),
          ),
          BlocProvider(create: (context) => ReviewCubit()),
        ],
        child: BlocListener<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is AddReviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).review_submitted_successfully),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ReviewError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.offWhite,
            appBar: AppBar(
              title: Text(
                S.of(context).my_appointments,
                style: AppTextStyles.cairo400Style20,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetAppointmentsSuccess) {
                  if (state.appointments.isEmpty) {
                    return CustomEmptyWidget(
                      title: S.of(context).no_appointments,
                      subtitle: S.of(context).no_appointments_subtitle,
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = state.appointments[index];
                      final canCancel =
                          appointment.status.toLowerCase() == 'pending' ||
                              appointment.status.toLowerCase() == 'confirmed';
                      final canReview =
                          appointment.status.toLowerCase() == 'completed' &&
                              !appointment.isReviewed;

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
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
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
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                '${S.of(context).dr}${_getDoctorName(context, appointment)} (${_getDoctorSpecialty(context, appointment)})',
                                style: AppTextStyles.cairo300style16
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S
                                        .of(context)
                                        .patient(appointment.patientName),
                                  ),
                                  Text(
                                    S.of(context).date_at_time(
                                          appointment.date,
                                          appointment.time,
                                        ),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _getLocalizedStatus(
                                    context,
                                    appointment.status,
                                  ),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (canCancel) ...[
                              const Divider(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () =>
                                      _showCancelDialog(context, appointment),
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  label: Text(
                                    S.of(context).cancel_appointment_button,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                            if (canReview) ...[
                              const Divider(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      _showReviewDialog(context, appointment),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.babyBlue,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon:
                                      const Icon(Icons.star_rounded, size: 18),
                                  label: Text(S.of(context).rate_and_review),
                                ),
                              ),
                            ],
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ), // Adjusted padding
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_toggle_off_rounded,
                                    size: 14,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    S.of(context).booked_on(
                                          DateFormat('MMM dd, yyyy HH:mm')
                                              .format(
                                            DateTime.parse(
                                              appointment.bookingCreatedAt,
                                            ),
                                          ),
                                        ),
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is AppointmentError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

  void _showCancelDialog(BuildContext context, dynamic appointment) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).cancel_appointment),
        content: Text(S.of(context).cancel_appointment_confirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).no_keep_it),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<AppointmentCubit>()
                  .cancelAppointment(appointment.id);
              Navigator.pop(dialogContext);
            },
            child: Text(
              S.of(context).yes_cancel,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(BuildContext parentContext, dynamic appointment) {
    final commentController = TextEditingController();
    double selectedRating = 5;
    final reviewCubit = parentContext.read<ReviewCubit>();
    final homeCubit = parentContext.read<HomeCubit>();

    showDialog(
      context: parentContext,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: reviewCubit),
          BlocProvider.value(value: homeCubit),
        ],
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(
              S.of(context).rate_your_experience,
              style: AppTextStyles.cairo400Style20
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).how_was_your_visit(
                        _getDoctorName(context, appointment),
                      ),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () {
                        setState(() => selectedRating = index + 1.0);
                      },
                      icon: Icon(
                        index < selectedRating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: Colors.amber,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: S.of(context).share_your_thoughts,
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey[300] ?? Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey[300] ?? Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(S.of(context).cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final user = context.read<HomeCubit>().originalUser;
                  final review = ReviewModel(
                    appointmentId: appointment.id,
                    doctorId: appointment.doctorId,
                    userId: user?.email ?? 'anonymous',
                    userName:
                        '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                    rating: selectedRating,
                    comment: commentController.text,
                    createdAt: DateTime.now().toIso8601String(),
                  );
                  context.read<ReviewCubit>().submitReview(review);
                  Navigator.pop(dialogContext);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  S.of(context).submit_review,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the localized doctor name.
  String _getDoctorName(BuildContext context, dynamic appointment) {
    final doctorData = appointment.doctorData as Map<String, dynamic>;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    if (isArabic && doctorData['arName'] != null) {
      return doctorData['arName'];
    }
    return doctorData['enName'] ?? appointment.doctorName;
  }

  /// Returns the localized doctor specialty.
  String _getDoctorSpecialty(BuildContext context, dynamic appointment) {
    final doctorData = appointment.doctorData as Map<String, dynamic>;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    if (isArabic && doctorData['arSpecialization'] != null) {
      return doctorData['arSpecialization'];
    }
    return doctorData['enSpecialization'] ?? appointment.doctorSpecialty;
  }

  /// Returns the localized status text based on the appointment status.
  String _getLocalizedStatus(BuildContext context, String status) {
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
        return status.toUpperCase();
    }
  }
}
