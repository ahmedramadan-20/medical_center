class AppointmentModel {
  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.userId,
    required this.patientName,
    required this.date,
    required this.time,
    required this.status,
    required this.doctorSpecialty,
    required this.patientPhone,
    required this.doctorWorkingDay,
    required this.doctorWorkingHours,
    required this.bookingCreatedAt,
    required this.userData,
    required this.doctorData,
    this.isReviewed = false,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'] ?? '',
        doctorId: json['doctorId'] ?? '',
        doctorName: json['doctorName'] ?? '',
        userId: json['userId'] ?? '',
        patientName: json['patientName'] ?? '',
        date: json['date'] ?? '',
        time: json['time'] ?? '',
        status: json['status'] ?? 'pending',
        doctorSpecialty: json['doctorSpecialty'] ?? '',
        patientPhone: json['patientPhone'] ?? '',
        doctorWorkingDay: json['doctorWorkingDay'] ?? '',
        doctorWorkingHours: json['doctorWorkingHours'] ?? '',
        bookingCreatedAt: json['bookingCreatedAt'] ?? '',
        userData: json['userData'] ?? {},
        doctorData: json['doctorData'] ?? {},
        isReviewed: json['isReviewed'] ?? false,
      );
  final String id;
  final String doctorId;
  final String doctorName;
  final String userId;
  final String patientName;
  final String date;
  final String time;
  final String status; // 'pending', 'confirmed', 'cancelled'
  final String doctorSpecialty;
  final String patientPhone;
  final String doctorWorkingDay;
  final String doctorWorkingHours;
  final String bookingCreatedAt;
  final Map<String, dynamic> userData;
  final Map<String, dynamic> doctorData;
  final bool isReviewed;

  Map<String, dynamic> toMap() => {
        'id': id,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'userId': userId,
        'patientName': patientName,
        'date': date,
        'time': time,
        'status': status,
        'doctorSpecialty': doctorSpecialty,
        'patientPhone': patientPhone,
        'doctorWorkingDay': doctorWorkingDay,
        'doctorWorkingHours': doctorWorkingHours,
        'bookingCreatedAt': bookingCreatedAt,
        'userData': userData,
        'doctorData': doctorData,
        'isReviewed': isReviewed,
      };

  AppointmentModel copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? userId,
    String? patientName,
    String? date,
    String? time,
    String? status,
    String? doctorSpecialty,
    String? patientPhone,
    String? doctorWorkingDay,
    String? doctorWorkingHours,
    String? bookingCreatedAt,
    Map<String, dynamic>? userData,
    Map<String, dynamic>? doctorData,
    bool? isReviewed,
  }) =>
      AppointmentModel(
        id: id ?? this.id,
        doctorId: doctorId ?? this.doctorId,
        doctorName: doctorName ?? this.doctorName,
        userId: userId ?? this.userId,
        patientName: patientName ?? this.patientName,
        date: date ?? this.date,
        time: time ?? this.time,
        status: status ?? this.status,
        doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
        patientPhone: patientPhone ?? this.patientPhone,
        doctorWorkingDay: doctorWorkingDay ?? this.doctorWorkingDay,
        doctorWorkingHours: doctorWorkingHours ?? this.doctorWorkingHours,
        bookingCreatedAt: bookingCreatedAt ?? this.bookingCreatedAt,
        userData: userData ?? this.userData,
        doctorData: doctorData ?? this.doctorData,
        isReviewed: isReviewed ?? this.isReviewed,
      );
}
