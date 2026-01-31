import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_dashboard_state.dart';

/// Manages the admin dashboard state and data aggregation.
///
/// This cubit handles:
/// - Loading aggregated statistics from all Firestore collections
/// - Real-time updates for dashboard metrics
/// - Appointment status breakdown calculation
///
/// Uses Firestore for live data synchronization.
class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit() : super(const AdminDashboardInitial());

  final _logger = LoggerService('AdminDashboardCubit');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? _usersSubscription;
  StreamSubscription<QuerySnapshot>? _doctorsSubscription;
  StreamSubscription<QuerySnapshot>? _appointmentsSubscription;
  StreamSubscription<QuerySnapshot>? _reviewsSubscription;
  StreamSubscription<QuerySnapshot>? _bloodSubscription;
  StreamSubscription<QuerySnapshot>? _specialitiesSubscription;

  // Cached counts for aggregation
  int _totalUsers = 0;
  int _adminCount = 0;
  int _totalDoctors = 0;
  int _totalAppointments = 0;
  int _pendingAppointments = 0;
  int _confirmedAppointments = 0;
  int _completedAppointments = 0;
  int _cancelledAppointments = 0;
  int _totalReviews = 0;
  int _totalBloodRecords = 0;
  int _totalSpecialities = 0;
  double _averageRating = 0;

  /// Loads all dashboard data with real-time updates.
  Future<void> loadDashboardData() async {
    emit(const AdminDashboardLoading());
    _logger.info('Loading admin dashboard data');

    try {
      // Subscribe to users collection
      _usersSubscription =
          _firestore.collection('users').snapshots().listen((snapshot) {
        _totalUsers = snapshot.docs.length;
        _adminCount =
            snapshot.docs.where((doc) => doc.data()['isAdmin'] == true).length;
        _emitUpdatedStats();
      });

      // Subscribe to doctors collection
      _doctorsSubscription =
          _firestore.collection('doctors').snapshots().listen((snapshot) {
        _totalDoctors = snapshot.docs.length;
        // Calculate average rating from doctors
        if (snapshot.docs.isNotEmpty) {
          double totalRating = 0;
          var ratedDoctors = 0;
          for (final doc in snapshot.docs) {
            final rating = doc.data()['averageRating'];
            if (rating != null && rating > 0) {
              totalRating += (rating as num).toDouble();
              ratedDoctors++;
            }
          }
          _averageRating = ratedDoctors > 0 ? totalRating / ratedDoctors : 0.0;
        }
        _emitUpdatedStats();
      });

      // Subscribe to appointments collection
      _appointmentsSubscription =
          _firestore.collection('appointments').snapshots().listen((snapshot) {
        _totalAppointments = snapshot.docs.length;
        _pendingAppointments = 0;
        _confirmedAppointments = 0;
        _completedAppointments = 0;
        _cancelledAppointments = 0;

        for (final doc in snapshot.docs) {
          final status = doc.data()['status'] as String?;
          switch (status?.toLowerCase()) {
            case 'pending':
              _pendingAppointments++;
            case 'confirmed':
              _confirmedAppointments++;
            case 'completed':
              _completedAppointments++;
            case 'cancelled':
              _cancelledAppointments++;
          }
        }
        _emitUpdatedStats();
      });

      // Subscribe to reviews collection
      _reviewsSubscription =
          _firestore.collection('reviews').snapshots().listen((snapshot) {
        _totalReviews = snapshot.docs.length;
        _emitUpdatedStats();
      });

      // Subscribe to blood types collection
      _bloodSubscription =
          _firestore.collection('bloodTypes').snapshots().listen((snapshot) {
        _totalBloodRecords = snapshot.docs.length;
        _emitUpdatedStats();
      });

      // Subscribe to specialities collection
      _specialitiesSubscription =
          _firestore.collection('specialities').snapshots().listen((snapshot) {
        _totalSpecialities = snapshot.docs.length;
        _emitUpdatedStats();
      });

      _logger.info('Dashboard data subscriptions established');
    } catch (e) {
      _logger.error('Error loading dashboard data', e);
      emit(AdminDashboardError(message: e.toString()));
    }
  }

  void _emitUpdatedStats() {
    final stats = DashboardStats(
      totalUsers: _totalUsers,
      totalDoctors: _totalDoctors,
      totalAppointments: _totalAppointments,
      totalReviews: _totalReviews,
      totalBloodRecords: _totalBloodRecords,
      totalSpecialities: _totalSpecialities,
      pendingAppointments: _pendingAppointments,
      confirmedAppointments: _confirmedAppointments,
      completedAppointments: _completedAppointments,
      cancelledAppointments: _cancelledAppointments,
      adminCount: _adminCount,
      averageRating: _averageRating,
    );
    emit(AdminDashboardLoaded(stats: stats));
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminDashboardCubit');
    _usersSubscription?.cancel();
    _doctorsSubscription?.cancel();
    _appointmentsSubscription?.cancel();
    _reviewsSubscription?.cancel();
    _bloodSubscription?.cancel();
    _specialitiesSubscription?.cancel();
    return super.close();
  }
}
