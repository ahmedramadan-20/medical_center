import 'package:equatable/equatable.dart';

/// Represents a user in the medical center system.
class UserModel extends Equatable {
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.gender,
    required this.bloodType,
    required this.isAdmin,
    this.fcmToken,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'] ?? '',
        image: json['image'] ?? '',
        phone: json['phone'] ?? '',
        gender: json['gender'] ?? '',
        bloodType: json['bloodType'] ?? '',
        isAdmin: json['isAdmin'] ?? false,
        fcmToken: json['fcmToken'],
      );
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String phone;
  final String gender;
  final String bloodType;
  final bool isAdmin;
  final String? fcmToken;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        image,
        phone,
        gender,
        bloodType,
        isAdmin,
        fcmToken,
      ];

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'image': image,
        'phone': phone,
        'gender': gender,
        'bloodType': bloodType,
        'isAdmin': isAdmin,
        'fcmToken': fcmToken,
      };
}
