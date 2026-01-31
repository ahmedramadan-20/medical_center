import 'package:equatable/equatable.dart';

/// Model representing analytics data for the admin dashboard.
class AnalyticsModel extends Equatable {
  const AnalyticsModel({
    required this.totalAppointments,
    required this.pendingAppointments,
    required this.confirmedAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.totalUsers,
    required this.totalDoctors,
    required this.totalReviews,
    required this.averageRating,
    required this.appointmentsByMonth,
    required this.usersByMonth,
    required this.topDoctors,
  });
  final int totalAppointments;
  final int pendingAppointments;
  final int confirmedAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int totalUsers;
  final int totalDoctors;
  final int totalReviews;
  final double averageRating;
  final Map<String, int> appointmentsByMonth;
  final Map<String, int> usersByMonth;
  final List<DoctorPerformance> topDoctors;

  @override
  List<Object?> get props => [
        totalAppointments,
        pendingAppointments,
        confirmedAppointments,
        completedAppointments,
        cancelledAppointments,
        totalUsers,
        totalDoctors,
        totalReviews,
        averageRating,
        appointmentsByMonth,
        usersByMonth,
        topDoctors,
      ];
}

/// Doctor performance metrics
class DoctorPerformance extends Equatable {
  const DoctorPerformance({
    required this.doctorId,
    required this.doctorName,
    required this.totalAppointments,
    required this.completedAppointments,
    required this.rating,
    required this.reviewCount,
  });
  final String doctorId;
  final String doctorName;
  final int totalAppointments;
  final int completedAppointments;
  final double rating;
  final int reviewCount;

  @override
  List<Object?> get props => [
        doctorId,
        doctorName,
        totalAppointments,
        completedAppointments,
        rating,
        reviewCount,
      ];
}
