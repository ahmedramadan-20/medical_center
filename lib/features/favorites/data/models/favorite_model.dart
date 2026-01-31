import 'package:equatable/equatable.dart';

/// Model representing a user's favorite doctor.
class FavoriteModel extends Equatable {
  const FavoriteModel({
    required this.userId,
    required this.doctorId,
    required this.addedAt,
  });

  /// Creates a FavoriteModel from JSON data.
  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        userId: json['userId'] as String,
        doctorId: json['doctorId'] as String,
        addedAt: DateTime.parse(json['addedAt'] as String),
      );

  /// Creates a FavoriteModel from Firestore DocumentSnapshot.
  factory FavoriteModel.fromFirestore(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel.fromJson(data);
  }
  final String userId;
  final String doctorId;
  final DateTime addedAt;

  @override
  List<Object?> get props => [userId, doctorId, addedAt];

  /// Converts the FavoriteModel to a Map for Firestore storage.
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'doctorId': doctorId,
        'addedAt': addedAt.toIso8601String(),
      };
}
