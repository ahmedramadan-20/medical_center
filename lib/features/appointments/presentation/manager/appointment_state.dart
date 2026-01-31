import 'package:medical_center/features/appointments/data/models/appointment_model.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  AppointmentSuccess(this.message);
  final String message;
}

class AppointmentError extends AppointmentState {
  AppointmentError(this.message);
  final String message;
}

class GetAppointmentsSuccess extends AppointmentState {
  GetAppointmentsSuccess(this.appointments);
  final List<AppointmentModel> appointments;
}
