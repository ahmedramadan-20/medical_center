/// Enhanced dashboard statistics model with detailed analytics
class DashboardStatsModel {
  const DashboardStatsModel({
    required this.totalUsers,
    required this.totalDoctors,
    required this.totalAppointments,
    required this.totalSpecialities,
    required this.totalReviews,
    required this.activeBloodRequests,
    required this.pendingAppointments,
    required this.confirmedAppointments,
    required this.cancelledAppointments,
    required this.todayAppointments,
    required this.adminUsers,
    required this.regularUsers,
    required this.averageRating,
    required this.recentActivities,
    required this.appointmentTrends,
    required this.topSpecialities,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      DashboardStatsModel(
        totalUsers: json['totalUsers'] ?? 0,
        totalDoctors: json['totalDoctors'] ?? 0,
        totalAppointments: json['totalAppointments'] ?? 0,
        totalSpecialities: json['totalSpecialities'] ?? 0,
        totalReviews: json['totalReviews'] ?? 0,
        activeBloodRequests: json['activeBloodRequests'] ?? 0,
        pendingAppointments: json['pendingAppointments'] ?? 0,
        confirmedAppointments: json['confirmedAppointments'] ?? 0,
        cancelledAppointments: json['cancelledAppointments'] ?? 0,
        todayAppointments: json['todayAppointments'] ?? 0,
        adminUsers: json['adminUsers'] ?? 0,
        regularUsers: json['regularUsers'] ?? 0,
        averageRating: (json['averageRating'] ?? 0.0).toDouble(),
        recentActivities: (json['recentActivities'] as List<dynamic>?)
                ?.map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        appointmentTrends: (json['appointmentTrends'] as List<dynamic>?)
                ?.map((e) => TrendDataModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        topSpecialities: (json['topSpecialities'] as List<dynamic>?)
                ?.map((e) =>
                    SpecialityStatsModel.fromJson(e as Map<String, dynamic>),)
                .toList() ??
            [],
      );

  final int totalUsers;
  final int totalDoctors;
  final int totalAppointments;
  final int totalSpecialities;
  final int totalReviews;
  final int activeBloodRequests;
  final int pendingAppointments;
  final int confirmedAppointments;
  final int cancelledAppointments;
  final int todayAppointments;
  final int adminUsers;
  final int regularUsers;
  final double averageRating;
  final List<ActivityModel> recentActivities;
  final List<TrendDataModel> appointmentTrends;
  final List<SpecialityStatsModel> topSpecialities;

  Map<String, dynamic> toJson() => {
        'totalUsers': totalUsers,
        'totalDoctors': totalDoctors,
        'totalAppointments': totalAppointments,
        'totalSpecialities': totalSpecialities,
        'totalReviews': totalReviews,
        'activeBloodRequests': activeBloodRequests,
        'pendingAppointments': pendingAppointments,
        'confirmedAppointments': confirmedAppointments,
        'cancelledAppointments': cancelledAppointments,
        'todayAppointments': todayAppointments,
        'adminUsers': adminUsers,
        'regularUsers': regularUsers,
        'averageRating': averageRating,
        'recentActivities': recentActivities.map((e) => e.toJson()).toList(),
        'appointmentTrends': appointmentTrends.map((e) => e.toJson()).toList(),
        'topSpecialities': topSpecialities.map((e) => e.toJson()).toList(),
      };
}

/// Model for activity feed items
class ActivityModel {
  const ActivityModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.userId,
    this.userName,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id'] ?? '',
        type: json['type'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        timestamp: json['timestamp'] ?? '',
        icon: json['icon'] ?? '',
        userId: json['userId'] ?? '',
        userName: json['userName'],
      );

  final String id;
  final String type; // 'appointment', 'user', 'doctor', 'review', 'blood'
  final String title;
  final String description;
  final String timestamp;
  final String icon;
  final String userId;
  final String? userName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'description': description,
        'timestamp': timestamp,
        'icon': icon,
        'userId': userId,
        'userName': userName,
      };
}

/// Model for trend data (charts)
class TrendDataModel {
  const TrendDataModel({
    required this.date,
    required this.value,
    required this.label,
  });

  factory TrendDataModel.fromJson(Map<String, dynamic> json) => TrendDataModel(
        date: json['date'] ?? '',
        value: json['value'] ?? 0,
        label: json['label'] ?? '',
      );

  final String date;
  final int value;
  final String label;

  Map<String, dynamic> toJson() => {
        'date': date,
        'value': value,
        'label': label,
      };
}

/// Model for speciality statistics
class SpecialityStatsModel {
  const SpecialityStatsModel({
    required this.speciality,
    required this.doctorCount,
    required this.appointmentCount,
    required this.averageRating,
  });

  factory SpecialityStatsModel.fromJson(Map<String, dynamic> json) =>
      SpecialityStatsModel(
        speciality: json['speciality'] ?? '',
        doctorCount: json['doctorCount'] ?? 0,
        appointmentCount: json['appointmentCount'] ?? 0,
        averageRating: (json['averageRating'] ?? 0.0).toDouble(),
      );

  final String speciality;
  final int doctorCount;
  final int appointmentCount;
  final double averageRating;

  Map<String, dynamic> toJson() => {
        'speciality': speciality,
        'doctorCount': doctorCount,
        'appointmentCount': appointmentCount,
        'averageRating': averageRating,
      };
}
