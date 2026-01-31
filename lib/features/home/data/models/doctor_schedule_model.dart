import 'package:equatable/equatable.dart';

/// Represents a doctor's schedule for a specific day.
class DoctorScheduleModel extends Equatable {
  const DoctorScheduleModel({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.maxPatients = 20,
  });

  factory DoctorScheduleModel.fromJson(Map<String, dynamic> json) =>
      DoctorScheduleModel(
        dayOfWeek: json['dayOfWeek'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        maxPatients: json['maxPatients'] ?? 20,
      );
  final int dayOfWeek; // 1 = Monday, 7 = Sunday
  final String startTime; // "HH:mm" 24-hour format
  final String endTime; // "HH:mm" 24-hour format
  final int maxPatients;

  @override
  List<Object?> get props => [dayOfWeek, startTime, endTime, maxPatients];

  Map<String, dynamic> toMap() => {
        'dayOfWeek': dayOfWeek,
        'startTime': startTime,
        'endTime': endTime,
        'maxPatients': maxPatients,
      };

  // Helper to get day name
  String get dayName {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }

  bool isOpen(DateTime currentTime) {
    if (currentTime.weekday != dayOfWeek) return false;

    try {
      final currentMinutes = currentTime.hour * 60 + currentTime.minute;

      final startH = int.parse(startTime.split(':')[0]);
      final startM = int.parse(startTime.split(':')[1]);
      final startMinutes = startH * 60 + startM;

      final endH = int.parse(endTime.split(':')[0]);
      final endM = int.parse(endTime.split(':')[1]);
      final endMinutes = endH * 60 + endM;

      return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
    } catch (e) {
      return false;
    }
  }
}
