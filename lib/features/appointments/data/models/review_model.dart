class ReviewModel {
  ReviewModel({
    required this.appointmentId,
    required this.doctorId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.id,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'],
        appointmentId: json['appointmentId'] ?? '',
        doctorId: json['doctorId'] ?? '',
        userId: json['userId'] ?? '',
        userName: json['userName'] ?? '',
        rating: (json['rating'] ?? 0.0).toDouble(),
        comment: json['comment'] ?? '',
        createdAt: json['createdAt'] ?? '',
      );
  final String? id;
  final String appointmentId;
  final String doctorId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final String createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'appointmentId': appointmentId,
        'doctorId': doctorId,
        'userId': userId,
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt,
      };

  ReviewModel copyWith({
    String? id,
    String? appointmentId,
    String? doctorId,
    String? userId,
    String? userName,
    double? rating,
    String? comment,
    String? createdAt,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        appointmentId: appointmentId ?? this.appointmentId,
        doctorId: doctorId ?? this.doctorId,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
      );
}
