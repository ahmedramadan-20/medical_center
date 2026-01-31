class SyncActionModel {
  SyncActionModel({
    required this.id,
    required this.type,
    required this.payload,
    required this.createdAt,
  });

  factory SyncActionModel.fromJson(Map<String, dynamic> json) =>
      SyncActionModel(
        id: json['id'] as String,
        type: json['type'] as String,
        payload: json['payload'] as Map<String, dynamic>,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  final String id;
  final String type;
  final Map<String, dynamic> payload;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'payload': payload,
        'createdAt': createdAt.toIso8601String(),
      };

  static const String updateProfile = 'UPDATE_PROFILE';
  static const String addFavorite = 'ADD_FAVORITE';
  static const String removeFavorite = 'REMOVE_FAVORITE';
  static const String bookAppointment = 'BOOK_APPOINTMENT';
  static const String cancelAppointment = 'CANCEL_APPOINTMENT';
  static const String addReview = 'ADD_REVIEW';
}
