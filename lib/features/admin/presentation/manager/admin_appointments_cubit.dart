import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/appointments/data/models/appointment_model.dart';

abstract class AdminAppointmentsState {}

class AdminAppointmentsInitial extends AdminAppointmentsState {}

class AdminAppointmentsLoading extends AdminAppointmentsState {}

class AdminAppointmentsLoaded extends AdminAppointmentsState {
  AdminAppointmentsLoaded(this.appointments);
  final List<AppointmentModel> appointments;
}

class AdminAppointmentsOperationSuccess extends AdminAppointmentsLoaded {
  AdminAppointmentsOperationSuccess(this.message, super.appointments);
  final String message;
}

class AdminAppointmentsError extends AdminAppointmentsState {
  AdminAppointmentsError(this.message);
  final String message;
}

/// Manages admin operations for appointment management.
///
/// This cubit handles:
/// - Loading all appointments with real-time updates
/// - Updating appointment status (pending, confirmed, completed, cancelled)
/// - Deleting appointments from the system
///
/// Uses Firestore snapshots for live data synchronization.
class AdminAppointmentsCubit extends Cubit<AdminAppointmentsState> {
  AdminAppointmentsCubit() : super(AdminAppointmentsInitial());

  final _logger = LoggerService('AdminAppointmentsCubit');
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

  StreamSubscription<QuerySnapshot>? _appointmentsSubscription;
  List<AppointmentModel> _allAppointments = [];

  /// Loads all appointments with real-time updates.
  Future<void> getAllAppointments() async {
    emit(AdminAppointmentsLoading());
    _logger.info('Loading all appointments');
    try {
      await _appointmentsSubscription?.cancel();
      _appointmentsSubscription =
          appointmentsCollection.snapshots().listen((snapshot) {
        _allAppointments = snapshot.docs.map((doc) {
          final data = doc.data()! as Map<String, dynamic>;
          return AppointmentModel.fromJson(data).copyWith(id: doc.id);
        }).toList();
        _logger.info('Loaded ${_allAppointments.length} appointments');
        emit(AdminAppointmentsLoaded(_allAppointments));
      });
    } catch (e) {
      _logger.error('Error loading appointments', e);
      emit(AdminAppointmentsError(e.toString()));
    }
  }

  /// Updates the status of an appointment.
  Future<void> updateAppointmentStatus(
    AppointmentModel appointment,
    String newStatus,
  ) async {
    _logger.info('Updating appointment ${appointment.id} to $newStatus');
    try {
      await appointmentsCollection
          .doc(appointment.id)
          .update({'status': newStatus});
      _logger.info('Appointment status updated successfully');
      emit(
        AdminAppointmentsOperationSuccess(
          'Status updated to $newStatus',
          _allAppointments,
        ),
      );
    } catch (e) {
      _logger.error('Error updating appointment status', e);
      emit(AdminAppointmentsError(e.toString()));
    }
  }

  /// Deletes an appointment from the system.
  Future<void> deleteAppointment(AppointmentModel appointment) async {
    _logger.info('Deleting appointment: ${appointment.id}');
    try {
      await appointmentsCollection.doc(appointment.id).delete();
      _logger.info('Appointment deleted successfully');
      emit(
        AdminAppointmentsOperationSuccess(
          'Appointment deleted successfully',
          _allAppointments,
        ),
      );
    } catch (e) {
      _logger.error('Error deleting appointment', e);
      emit(AdminAppointmentsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminAppointmentsCubit');
    _appointmentsSubscription?.cancel();
    return super.close();
  }
}
