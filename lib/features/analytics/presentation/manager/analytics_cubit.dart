import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/analytics/data/models/analytics_model.dart';
import 'package:medical_center/features/analytics/presentation/manager/analytics_state.dart';

/// Cubit for managing analytics and reports.
class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit() : super(AnalyticsInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Load all analytics data
  Future<void> loadAnalytics() async {
    try {
      emit(AnalyticsLoading());

      // Fetch all data in parallel
      final results = await Future.wait([
        _getAppointmentStats(),
        _getUserStats(),
        _getDoctorStats(),
        _getReviewStats(),
        _getAppointmentsByMonth(),
        _getUsersByMonth(),
        _getTopDoctors(),
      ]);

      final appointmentStats = results[0] as Map<String, int>;
      final userCount = results[1] as int;
      final doctorCount = results[2] as int;
      final reviewStats = results[3] as Map<String, dynamic>;
      final appointmentsByMonth = results[4] as Map<String, int>;
      final usersByMonth = results[5] as Map<String, int>;
      final topDoctors = results[6] as List<DoctorPerformance>;

      final analytics = AnalyticsModel(
        totalAppointments: appointmentStats['total']!,
        pendingAppointments: appointmentStats['pending']!,
        confirmedAppointments: appointmentStats['confirmed']!,
        completedAppointments: appointmentStats['completed']!,
        cancelledAppointments: appointmentStats['cancelled']!,
        totalUsers: userCount,
        totalDoctors: doctorCount,
        totalReviews: reviewStats['count'] as int,
        averageRating: reviewStats['average'] as double,
        appointmentsByMonth: appointmentsByMonth,
        usersByMonth: usersByMonth,
        topDoctors: topDoctors,
      );

      emit(AnalyticsLoaded(analytics));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }

  /// Get appointment statistics
  Future<Map<String, int>> _getAppointmentStats() async {
    final snapshot = await _firestore.collection('appointments').get();
    final docs = snapshot.docs;

    return {
      'total': docs.length,
      'pending': docs.where((d) => d.data()['status'] == 'pending').length,
      'confirmed': docs.where((d) => d.data()['status'] == 'confirmed').length,
      'completed': docs.where((d) => d.data()['status'] == 'completed').length,
      'cancelled': docs.where((d) => d.data()['status'] == 'cancelled').length,
    };
  }

  /// Get user count
  Future<int> _getUserStats() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.length;
  }

  /// Get doctor count
  Future<int> _getDoctorStats() async {
    final snapshot = await _firestore.collection('doctors').get();
    return snapshot.docs.length;
  }

  /// Get review statistics
  Future<Map<String, dynamic>> _getReviewStats() async {
    final snapshot = await _firestore.collection('reviews').get();
    final reviews = snapshot.docs;

    if (reviews.isEmpty) {
      return {'count': 0, 'average': 0.0};
    }

    final totalRating = reviews.fold<double>(
      0,
      (sum, doc) => sum + (doc.data()['rating'] as num).toDouble(),
    );

    return {
      'count': reviews.length,
      'average': totalRating / reviews.length,
    };
  }

  /// Get appointments by month (last 6 months)
  Future<Map<String, int>> _getAppointmentsByMonth() async {
    final now = DateTime.now();
    final sixMonthsAgo = DateTime(now.year, now.month - 6);

    final snapshot = await _firestore
        .collection('appointments')
        .where('appointmentDate', isGreaterThan: sixMonthsAgo.toIso8601String())
        .get();

    final appointmentsByMonth = <String, int>{};

    for (final doc in snapshot.docs) {
      final dateStr = doc.data()['appointmentDate'] as String?;
      if (dateStr != null) {
        final date = DateTime.parse(dateStr);
        final monthKey =
            '${date.year}-${date.month.toString().padLeft(2, '0')}';
        appointmentsByMonth[monthKey] =
            (appointmentsByMonth[monthKey] ?? 0) + 1;
      }
    }

    return appointmentsByMonth;
  }

  /// Get users by month (registration trend)
  Future<Map<String, int>> _getUsersByMonth() async {
    // This would require a createdAt field in users collection
    // For now, return empty map
    return {};
  }

  /// Get top performing doctors
  Future<List<DoctorPerformance>> _getTopDoctors() async {
    final doctorsSnapshot = await _firestore.collection('doctors').get();
    final appointmentsSnapshot =
        await _firestore.collection('appointments').get();

    final performanceList = <DoctorPerformance>[];

    for (final doctorDoc in doctorsSnapshot.docs) {
      final doctorData = doctorDoc.data();
      final doctorId = doctorData['id'].toString();
      final doctorName = doctorData['enName'] as String? ?? 'Unknown';

      final doctorAppointments = appointmentsSnapshot.docs
          .where((a) => a.data()['doctorId'].toString() == doctorId)
          .toList();

      final completedAppointments = doctorAppointments
          .where((a) => a.data()['status'] == 'completed')
          .length;

      final rating = (doctorData['averageRating'] as num?)?.toDouble() ?? 0.0;
      final reviewCount = (doctorData['numberOfReviews'] as num?)?.toInt() ?? 0;

      performanceList.add(
        DoctorPerformance(
          doctorId: doctorId,
          doctorName: doctorName,
          totalAppointments: doctorAppointments.length,
          completedAppointments: completedAppointments,
          rating: rating,
          reviewCount: reviewCount,
        ),
      );
    }

    // Sort by total appointments
    performanceList
        .sort((a, b) => b.totalAppointments.compareTo(a.totalAppointments));

    return performanceList.take(5).toList();
  }
}
