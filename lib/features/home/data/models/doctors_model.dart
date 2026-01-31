import 'package:equatable/equatable.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/features/home/data/models/doctor_schedule_model.dart';

/// Represents a doctor in the medical center system.
///
/// This model contains all information about a doctor including their
/// personal details, specialization, schedule, and ratings.
class DoctorsModel extends Equatable {
  const DoctorsModel({
    required this.id,
    required this.specializationId,
    required this.arName,
    required this.enName,
    required this.arSpecialization,
    required this.enSpecialization,
    required this.image,
    required this.schedules,
    required this.isAvailable,
    required this.numberOfPatients,
    this.docId,
    this.averageRating = 0.0,
    this.numberOfReviews = 0,
    this.ticketPrice = 150.0,
    this.experienceYears = 10,
  });

  /// Creates a [DoctorsModel] from JSON data.
  factory DoctorsModel.fromJson(Map<String, dynamic> jsonData) {
    final list = jsonData['schedules'] as List<dynamic>?;
    final schedulesList = list != null
        ? list.map((i) => DoctorScheduleModel.fromJson(i)).toList()
        : <DoctorScheduleModel>[];

    return DoctorsModel(
      id: jsonData[FirebaseStrings.id],
      specializationId: jsonData[FirebaseStrings.specializationId],
      arName: jsonData[FirebaseStrings.arName],
      enName: jsonData[FirebaseStrings.enName],
      arSpecialization: jsonData[FirebaseStrings.arSpecialization],
      enSpecialization: jsonData[FirebaseStrings.enSpecialization],
      image: jsonData[FirebaseStrings.image],
      // workingHours: jsonData[FirebaseStrings.workingHours],
      schedules: schedulesList,
      isAvailable: jsonData[FirebaseStrings.isAvailable],
      numberOfPatients: jsonData[FirebaseStrings.numberOfPatients],
      averageRating: (jsonData['averageRating'] ?? 0.0).toDouble(),
      numberOfReviews: jsonData['numberOfReviews'] ?? 0,
      ticketPrice: (jsonData['ticketPrice'] ?? 150.0).toDouble(),
      experienceYears: jsonData['experienceYears'] ?? 10,
    );
  }

  /// Creates a [DoctorsModel] from a Firestore DocumentSnapshot.
  factory DoctorsModel.fromFirestore(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoctorsModel.fromJson(data).copyWith(docId: doc.id);
  }
  final int id;
  final String? docId; // Firestore Document ID
  final int specializationId;
  final String arName;
  final String enName;
  final String arSpecialization;
  final String enSpecialization;
  final String image;
  final bool isAvailable;
  // final Map<String, dynamic> workingHours; // Deprecated
  final List<DoctorScheduleModel> schedules; // New robust schedule
  final int numberOfPatients;
  final double averageRating;
  final int numberOfReviews;
  final double ticketPrice;
  final int experienceYears;

  @override
  List<Object?> get props => [
        id,
        docId,
        specializationId,
        arName,
        enName,
        arSpecialization,
        enSpecialization,
        image,
        schedules,
        isAvailable,
        numberOfPatients,
        averageRating,
        numberOfReviews,
        ticketPrice,
        experienceYears,
      ];

  /// Converts the [DoctorsModel] to a Map for Firestore storage.
  Map<String, dynamic> toMap() => {
        FirebaseStrings.id: id,
        FirebaseStrings.specializationId: specializationId,
        FirebaseStrings.arName: arName,
        FirebaseStrings.enName: enName,
        FirebaseStrings.arSpecialization: arSpecialization,
        FirebaseStrings.enSpecialization: enSpecialization,
        FirebaseStrings.image: image,
        'schedules': schedules.map((e) => e.toMap()).toList(),
        FirebaseStrings.isAvailable: isAvailable,
        FirebaseStrings.numberOfPatients: numberOfPatients,
        'averageRating': averageRating,
        'numberOfReviews': numberOfReviews,
        'ticketPrice': ticketPrice,
        'experienceYears': experienceYears,
      };

  DoctorsModel copyWith({
    int? id,
    String? docId,
    int? specializationId,
    String? arName,
    String? enName,
    String? arSpecialization,
    String? enSpecialization,
    String? image,
    // Map<String, dynamic>? workingHours,
    List<DoctorScheduleModel>? schedules,
    bool? isAvailable,
    int? numberOfPatients,
    double? averageRating,
    int? numberOfReviews,
    double? ticketPrice,
    int? experienceYears,
  }) =>
      DoctorsModel(
        id: id ?? this.id,
        docId: docId ?? this.docId,
        specializationId: specializationId ?? this.specializationId,
        arName: arName ?? this.arName,
        enName: enName ?? this.enName,
        arSpecialization: arSpecialization ?? this.arSpecialization,
        enSpecialization: enSpecialization ?? this.enSpecialization,
        image: image ?? this.image,
        // workingHours: workingHours ?? this.workingHours,
        schedules: schedules ?? this.schedules,
        isAvailable: isAvailable ?? this.isAvailable,
        numberOfPatients: numberOfPatients ?? this.numberOfPatients,
        averageRating: averageRating ?? this.averageRating,
        numberOfReviews: numberOfReviews ?? this.numberOfReviews,
        ticketPrice: ticketPrice ?? this.ticketPrice,
        experienceYears: experienceYears ?? this.experienceYears,
      );

  // Helper Logic
  DoctorScheduleModel? getNextAvailableSlot() {
    if (schedules.isEmpty) return null;

    final now = DateTime.now();
    final currentDayOfWeek = now.weekday; // 1 = Mon, 7 = Sun
    final currentMinutes = now.hour * 60 + now.minute;

    // Sort schedules by day
    schedules.sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

    // 1. Check if there is a slot TODAY that hasn't finished yet
    try {
      final matchToday = schedules.firstWhere(
        (s) => s.dayOfWeek == currentDayOfWeek,
      );

      // Check time
      // Parse endTime
      final endH = int.parse(matchToday.endTime.split(':')[0]);
      final endM = int.parse(matchToday.endTime.split(':')[1]);
      final endMinutes = endH * 60 + endM;

      if (currentMinutes < endMinutes) {
        return matchToday; // Available today
      }
    } catch (e) {
      // No schedule for today, continue to find next day
    }

    // 2. Find first day > currentDayOfWeek
    for (final schedule in schedules) {
      if (schedule.dayOfWeek > currentDayOfWeek) {
        return schedule;
      }
    }

    // 3. Wrap around to the first available day next week
    return schedules.first;
  }
}
