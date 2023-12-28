import 'package:medical_center/core/utils/app_strings.dart';

class DoctorsModel {
  final int id;
  final int specializationId;
  final String arName;
  final String enName;
  final String arSpecialization;
  final String enSpecialization;
  final String image;
  final bool isAvailable;
  final Map<String, dynamic> workingHours;
  final int numberOfPatients;

  DoctorsModel({
    required this.id,
    required this.specializationId,
    required this.arName,
    required this.enName,
    required this.arSpecialization,
    required this.enSpecialization,
    required this.image,
    required this.workingHours,
    required this.isAvailable,
    required this.numberOfPatients,
  });

  factory DoctorsModel.fromJson(jsonData) {
    return DoctorsModel(
      id: jsonData[FirebaseStrings.id],
      specializationId: jsonData[FirebaseStrings.specializationId],
      arName: jsonData[FirebaseStrings.arName],
      enName: jsonData[FirebaseStrings.enName],
      arSpecialization: jsonData[FirebaseStrings.arSpecialization],
      enSpecialization: jsonData[FirebaseStrings.enSpecialization],
      image: jsonData[FirebaseStrings.image],
      workingHours: jsonData[FirebaseStrings.workingHours],
      isAvailable: jsonData[FirebaseStrings.isAvailable],
      numberOfPatients: jsonData[FirebaseStrings.numberOfPatients],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseStrings.id: id,
      FirebaseStrings.specializationId: specializationId,
      FirebaseStrings.arName: arName,
      FirebaseStrings.enName: enName,
      FirebaseStrings.arSpecialization: arSpecialization,
      FirebaseStrings.enSpecialization: enSpecialization,
      FirebaseStrings.image: image,
      FirebaseStrings.workingHours: workingHours,
      FirebaseStrings.isAvailable: isAvailable,
      FirebaseStrings.numberOfPatients: numberOfPatients,
    };
  }
  DoctorsModel copyWith({
    int? id,
    int? specializationId,
    String? arName,
    String? enName,
    String? arSpecialization,
    String? enSpecialization,
    String? image,
    Map<String, dynamic>? workingHours,
    bool? isAvailable,
    int? numberOfPatients,

  }){
    return DoctorsModel(
      id: id ?? this.id,
      specializationId: specializationId ?? this.specializationId,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      arSpecialization: arSpecialization ?? this.arSpecialization,
      enSpecialization: enSpecialization ?? this.enSpecialization,
      image: image ?? this.image,
      workingHours: workingHours ?? this.workingHours,
      isAvailable: isAvailable ?? this.isAvailable,
      numberOfPatients: numberOfPatients ?? this.numberOfPatients,
    );
  }
}
