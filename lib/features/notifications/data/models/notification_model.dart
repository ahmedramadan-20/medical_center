import 'package:equatable/equatable.dart';

/// Model representing a notification in the system.
class NotificationModel extends Equatable {
  const NotificationModel({
    required this.title,
    required this.body,
    required this.createdAt,
    this.id,
    this.titleAr,
    this.bodyAr,
    this.data,
    this.userId, // Null if broadcast
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'],
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        titleAr: json['titleAr'],
        bodyAr: json['bodyAr'],
        createdAt: DateTime.parse(json['createdAt']),
        data: json['data'],
        userId: json['userId'],
        isRead: json['isRead'] ?? false,
      );

  final String? id;
  final String title;
  final String body;
  final String? titleAr;
  final String? bodyAr;
  final DateTime createdAt;
  final Map<String, dynamic>? data;
  final String? userId;
  final bool isRead;

  Map<String, dynamic> toMap() => {
        'title': title,
        'body': body,
        'titleAr': titleAr,
        'bodyAr': bodyAr,
        'createdAt': createdAt.toIso8601String(),
        'data': data,
        'userId': userId,
        'isRead': isRead,
      };

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? titleAr,
    String? bodyAr,
    DateTime? createdAt,
    Map<String, dynamic>? data,
    String? userId,
    bool? isRead,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        titleAr: titleAr ?? this.titleAr,
        bodyAr: bodyAr ?? this.bodyAr,
        createdAt: createdAt ?? this.createdAt,
        data: data ?? this.data,
        userId: userId ?? this.userId,
        isRead: isRead ?? this.isRead,
      );

  @override
  List<Object?> get props =>
      [id, title, body, titleAr, bodyAr, createdAt, data, userId, isRead];
}
