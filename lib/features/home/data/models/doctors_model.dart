import 'package:medical_center/core/utils/app_strings.dart';

class DoctorsModel {
  final String arname;
  final String enname;
  final String arspecialization;
  final String enspecialization;
  final String image;
  final bool isAvailable;
  final Map<String, dynamic> workinghours;

  DoctorsModel(
      {required this.arname,
      required this.enname,
      required this.arspecialization,
      required this.enspecialization,
      required this.image,
      required this.workinghours,
      required this.isAvailable,});

  factory DoctorsModel.fromJson(jsonData) {
    return DoctorsModel(
      arname: jsonData[FirebaseStrings.arname],
      enname: jsonData[FirebaseStrings.enname],
      arspecialization: jsonData[FirebaseStrings.arspecialization],
      enspecialization: jsonData[FirebaseStrings.enspecialization],
      image: jsonData[FirebaseStrings.image],
      workinghours: jsonData[FirebaseStrings.workinghours],
      isAvailable: jsonData[FirebaseStrings.isAvailable],
    );
  }
}
