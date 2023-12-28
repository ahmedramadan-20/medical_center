class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String phone;
  final String gender;
  final String bloodType;
  final bool isAdmin;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.gender,
    required this.bloodType,
    required this.isAdmin,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      phone: json['phone'],
      gender: json['gender'],
      bloodType: json['bloodType'],
      isAdmin: json['isAdmin'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'phone': phone,
      'gender': gender,
      'bloodType': bloodType,
      'isAdmin': isAdmin,
    };

  }
}
