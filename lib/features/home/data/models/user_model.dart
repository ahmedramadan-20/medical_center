class UsersModel {
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String phone;
  final String bloodType;
  final String uId;
  final bool isEmailVerified;

  UsersModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.bloodType,
    required this.uId,
    required this.isEmailVerified,
  });
}
