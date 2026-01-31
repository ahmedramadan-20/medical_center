import 'package:flutter_test/flutter_test.dart';
import 'package:medical_center/features/admin/data/models/dashboard_stats_model.dart';

void main() {
  group('Dashboard Stats Model Tests', () {
    test('DashboardStatsModel should be created from JSON', () {
      final json = {
        'totalUsers': 100,
        'totalDoctors': 20,
        'totalAppointments': 50,
        'totalSpecialities': 10,
        'totalReviews': 30,
        'activeBloodRequests': 5,
        'pendingAppointments': 10,
        'confirmedAppointments': 30,
        'cancelledAppointments': 10,
        'todayAppointments': 5,
        'adminUsers': 2,
        'regularUsers': 98,
        'averageRating': 4.5,
        'recentActivities': [],
        'appointmentTrends': [],
        'topSpecialities': [],
      };

      final model = DashboardStatsModel.fromJson(json);

      expect(model.totalUsers, 100);
      expect(model.totalDoctors, 20);
      expect(model.totalAppointments, 50);
      expect(model.averageRating, 4.5);
      expect(model.pendingAppointments, 10);
    });

    test('DashboardStatsModel should convert to JSON', () {
      const model = DashboardStatsModel(
        totalUsers: 100,
        totalDoctors: 20,
        totalAppointments: 50,
        totalSpecialities: 10,
        totalReviews: 30,
        activeBloodRequests: 5,
        pendingAppointments: 10,
        confirmedAppointments: 30,
        cancelledAppointments: 10,
        todayAppointments: 5,
        adminUsers: 2,
        regularUsers: 98,
        averageRating: 4.5,
        recentActivities: [],
        appointmentTrends: [],
        topSpecialities: [],
      );

      final json = model.toJson();

      expect(json['totalUsers'], 100);
      expect(json['totalDoctors'], 20);
      expect(json['averageRating'], 4.5);
    });

    test('ActivityModel should be created from JSON', () {
      final json = {
        'id': '1',
        'type': 'appointment',
        'title': 'New Appointment',
        'description': 'Patient booked appointment',
        'timestamp': '2024-01-01T10:00:00',
        'icon': 'calendar',
        'userId': 'user1',
        'userName': 'John Doe',
      };

      final model = ActivityModel.fromJson(json);

      expect(model.id, '1');
      expect(model.type, 'appointment');
      expect(model.title, 'New Appointment');
      expect(model.userName, 'John Doe');
    });

    test('TrendDataModel should be created from JSON', () {
      final json = {
        'date': '2024-01-01',
        'value': 10,
        'label': 'Jan 01',
      };

      final model = TrendDataModel.fromJson(json);

      expect(model.date, '2024-01-01');
      expect(model.value, 10);
      expect(model.label, 'Jan 01');
    });

    test('SpecialityStatsModel should be created from JSON', () {
      final json = {
        'speciality': 'Cardiology',
        'doctorCount': 5,
        'appointmentCount': 20,
        'averageRating': 4.5,
      };

      final model = SpecialityStatsModel.fromJson(json);

      expect(model.speciality, 'Cardiology');
      expect(model.doctorCount, 5);
      expect(model.appointmentCount, 20);
      expect(model.averageRating, 4.5);
    });

    test('DashboardStatsModel should handle empty data', () {
      final json = <String, dynamic>{};

      final model = DashboardStatsModel.fromJson(json);

      expect(model.totalUsers, 0);
      expect(model.totalDoctors, 0);
      expect(model.averageRating, 0.0);
      expect(model.recentActivities, isEmpty);
    });
  });
}
