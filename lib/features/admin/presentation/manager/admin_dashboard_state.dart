import 'package:equatable/equatable.dart';

/// Model representing aggregated dashboard statistics.
class DashboardStats extends Equatable {
  const DashboardStats({
    required this.totalUsers,
    required this.totalDoctors,
    required this.totalAppointments,
    required this.totalReviews,
    required this.totalBloodRecords,
    required this.totalSpecialities,
    required this.pendingAppointments,
    required this.confirmedAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.adminCount,
    required this.averageRating,
  });

  factory DashboardStats.empty() => const DashboardStats(
        totalUsers: 0,
        totalDoctors: 0,
        totalAppointments: 0,
        totalReviews: 0,
        totalBloodRecords: 0,
        totalSpecialities: 0,
        pendingAppointments: 0,
        confirmedAppointments: 0,
        completedAppointments: 0,
        cancelledAppointments: 0,
        adminCount: 0,
        averageRating: 0,
      );

  final int totalUsers;
  final int totalDoctors;
  final int totalAppointments;
  final int totalReviews;
  final int totalBloodRecords;
  final int totalSpecialities;
  final int pendingAppointments;
  final int confirmedAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int adminCount;
  final double averageRating;

  @override
  List<Object?> get props => [
        totalUsers,
        totalDoctors,
        totalAppointments,
        totalReviews,
        totalBloodRecords,
        totalSpecialities,
        pendingAppointments,
        confirmedAppointments,
        completedAppointments,
        cancelledAppointments,
        adminCount,
        averageRating,
      ];
}

/// Base state for AdminDashboardCubit.
abstract class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading data.
class AdminDashboardInitial extends AdminDashboardState {
  const AdminDashboardInitial();
}

/// Loading state while fetching dashboard data.
class AdminDashboardLoading extends AdminDashboardState {
  const AdminDashboardLoading();
}

/// Success state with loaded dashboard statistics.
class AdminDashboardLoaded extends AdminDashboardState {
  const AdminDashboardLoaded({required this.stats});

  final DashboardStats stats;

  @override
  List<Object?> get props => [stats];
}

/// Error state when data loading fails.
class AdminDashboardError extends AdminDashboardState {
  const AdminDashboardError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
