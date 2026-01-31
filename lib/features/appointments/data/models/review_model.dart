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
    this.isApproved = false,
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
        isApproved: json['isApproved'] ?? false,
      );
  final String? id;
  final String appointmentId;
  final String doctorId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final String createdAt;
  final bool isApproved;

  Map<String, dynamic> toMap() => {
        'id': id,
        'appointmentId': appointmentId,
        'doctorId': doctorId,
        'userId': userId,
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt,
        'isApproved': isApproved,
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
    bool? isApproved,
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
        isApproved: isApproved ?? this.isApproved,
      );
}
