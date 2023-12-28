class BloodTypeModel {
  final String firstName;
  final String lastName;
  final String bloodType;
  final String phone;
  final String gender;
  final String email;

  BloodTypeModel({
    required this.firstName,
    required this.lastName,
    required this.bloodType,
    required this.phone,
    required this.gender,
    required this.email,
  });

  factory BloodTypeModel.fromJson(Map<String, dynamic> json) {
    return BloodTypeModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      bloodType: json['bloodType'],
      phone: json['phone'],
      gender: json['gender'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'bloodType': bloodType,
      'phone': phone,
      'gender': gender,
      'email': email,
    };
  }
}
