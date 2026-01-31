import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/network/network_info.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/notification_service.dart';
import 'package:medical_center/core/services/sync/sync_action_model.dart';
import 'package:medical_center/core/services/sync/sync_service.dart';
import 'package:medical_center/features/appointments/data/models/appointment_model.dart';
import 'package:medical_center/features/appointments/presentation/manager/appointment_state.dart';

/// Manages appointment booking and retrieval.
///
/// This cubit handles:
/// - Booking new appointments for patients
/// - Retrieving user's appointments with real-time updates
/// - Cancelling appointments
///
/// **Real-time Updates:**
/// Uses Firestore snapshots for live appointment data.
/// Stream subscriptions are properly managed to prevent memory leaks.
///
/// **Usage:**
/// ```dart
/// final cubit = context.read<AppointmentCubit>();
/// await cubit.bookAppointment(appointmentModel);
/// await cubit.getUserAppointments(userId);
/// ```
class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this._networkInfo, this._syncService)
      : super(AppointmentInitial());

  final NetworkInfo _networkInfo;
  final SyncService _syncService;
  final _logger = LoggerService('AppointmentCubit');
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

  /// Stream subscription for real-time appointment updates.
  /// Cancelled in [close()] to prevent memory leaks.
  StreamSubscription<QuerySnapshot>? _appointmentsSubscription;

  /// Books a new appointment for a patient.
  ///
  /// Creates an appointment document in Firestore with all details
  /// including doctor info, patient info, date, and time.
  ///
  /// **Parameters:**
  /// - [appointment]: Complete appointment model with all details
  ///
  /// Emits [AppointmentLoading] during processing, then either
  /// [AppointmentSuccess] with message or [AppointmentError].
  Future<void> bookAppointment(AppointmentModel appointment) async {
    // 1. Offline Check
    if (!await _networkInfo.isConnected) {
      await _syncService.addToQueue(
        type: SyncActionModel.bookAppointment,
        payload: appointment.toMap(),
      );
      // Optimistic Success for booking
      emit(
        AppointmentSuccess(
          'Request saved locally. Will be booked when online.',
        ),
      );
      return;
    }

    emit(AppointmentLoading());
    _logger.info(
      'Booking appointment for ${appointment.patientName} with Dr. ${appointment.doctorName}',
    );

    try {
      await appointmentsCollection.add(appointment.toMap());
      _logger.info('Appointment booked successfully');

      // Notify Admin about new appointment
      final docData = appointment.doctorData;
      await NotificationService().sendBroadcastNotification(
        title: 'New Appointment Booked',
        titleAr: 'حجز موعد جديد',
        body:
            'Patient ${appointment.patientName} booked with Dr. ${docData['enName'] ?? appointment.doctorName}',
        bodyAr:
            'قام المريض ${appointment.patientName} بحجز موعد مع د. ${docData['arName'] ?? appointment.doctorName}',
        data: {'type': 'appointment', 'id': appointment.id},
      );

      // Schedule local reminder for the user
      _scheduleReminder(appointment);

      emit(AppointmentSuccess('Appointment booked successfully'));
    } catch (e, stackTrace) {
      _logger.error('Failed to book appointment', e, stackTrace);
      emit(AppointmentError(e.toString()));
    }
  }

  void _scheduleReminder(AppointmentModel appointment) {
    try {
      final dateStr = appointment.date; // yyyy-MM-dd
      final timeStr = appointment.time; // h:mm a

      final dateTimeStr = '$dateStr $timeStr';
      final format = DateFormat('yyyy-MM-dd h:mm a');
      final scheduledDateTime = format.parse(dateTimeStr);

      NotificationService().scheduleAppointmentReminder(
        id: appointment.hashCode,
        title: 'Appointment Reminder',
        body:
            'Your appointment with Dr. ${appointment.doctorName} is in 30 minutes.',
        scheduledDate: scheduledDateTime,
      );
    } catch (e) {
      _logger.warning('Failed to schedule reminder: $e');
    }
  }

  /// Retrieves all appointments for a specific user with real-time updates.
  ///
  /// Sets up a Firestore snapshot listener for the user's appointments.
  /// Automatically updates when appointments change in Firestore.
  ///
  /// **Parameters:**
  /// - [userId]: The user's ID (email) to filter appointments
  ///
  /// **Important:** Cancels any existing subscription before creating new one.
  ///
  /// Emits [AppointmentLoading] initially, then [GetAppointmentsSuccess]
  /// with appointment list on each update, or [AppointmentError] on failure.
  Future<void> getUserAppointments(String userId) async {
    emit(AppointmentLoading());
    _logger.info('Loading appointments for user: $userId');

    try {
      // Cancel existing subscription to prevent memory leaks
      await _appointmentsSubscription?.cancel();

      _appointmentsSubscription = appointmentsCollection
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen(
        (snapshot) {
          final appointments = snapshot.docs.map((doc) {
            final data = doc.data()! as Map<String, dynamic>;
            return AppointmentModel.fromJson(data).copyWith(id: doc.id);
          }).toList();
          _logger
              .debug('Loaded ${appointments.length} appointments for $userId');
          emit(GetAppointmentsSuccess(appointments));
        },
        onError: (error, stackTrace) {
          _logger.error('Error in appointments stream', error, stackTrace);
          emit(AppointmentError(error.toString()));
        },
      );
    } catch (e, stackTrace) {
      _logger.error('Failed to setup appointments stream', e, stackTrace);
      emit(AppointmentError(e.toString()));
    }
  }

  /// Cancels an existing appointment.
  ///
  /// Updates the appointment status to 'cancelled' in Firestore.
  /// The real-time listener will automatically update the UI.
  ///
  /// **Parameters:**
  /// - [appointmentId]: The ID of the appointment to cancel
  ///
  /// **Note:** Does not emit loading/success states as the stream
  /// listener will handle the UI update automatically.
  Future<void> cancelAppointment(String appointmentId) async {
    if (!await _networkInfo.isConnected) {
      await _syncService.addToQueue(
        type: SyncActionModel.cancelAppointment,
        payload: {'appointmentId': appointmentId},
      );
      // No easy way to show optimistic UI for stream cancellations without local filtering wrapper
      // But we can show a message. The list won't update until online.
      emit(AppointmentSuccess('Cancellation saved locally.'));
      return;
    }
    _logger.info('Cancelling appointment: $appointmentId');

    try {
      await appointmentsCollection
          .doc(appointmentId)
          .update({'status': 'cancelled'});
      _logger.info('Appointment cancelled successfully: $appointmentId');

      // Notify relevant parties
      await NotificationService().sendBroadcastNotification(
        title: 'Appointment Cancelled',
        titleAr: 'تم إلغاء الموعد',
        body: 'An appointment has been cancelled (ID: $appointmentId)',
        bodyAr: 'تم إلغاء موعد (رقم: $appointmentId)',
        data: {'type': 'cancellation', 'id': appointmentId},
      );
      // Stream will handle the update automatically
    } catch (e, stackTrace) {
      _logger.error('Failed to cancel appointment', e, stackTrace);
      emit(AppointmentError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing AppointmentCubit and cancelling subscriptions');
    _appointmentsSubscription?.cancel();
    return super.close();
  }
}
