import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/notification_service.dart';
import 'package:medical_center/features/home/data/models/notification_model.dart';

// States
abstract class AdminNotificationState {}

class AdminNotificationInitial extends AdminNotificationState {}

class AdminNotificationLoading extends AdminNotificationState {}

class AdminNotificationSuccess extends AdminNotificationState {
  AdminNotificationSuccess(this.message);
  final String message;
}

class AdminNotificationError extends AdminNotificationState {
  AdminNotificationError(this.message);
  final String message;
}

/// Cubit for managing admin notification operations.
class AdminNotificationCubit extends Cubit<AdminNotificationState> {
  AdminNotificationCubit() : super(AdminNotificationInitial());

  final _logger = LoggerService('AdminNotificationCubit');
  final _firestore = FirebaseFirestore.instance;

  /// Sends a broadcast notification to all users.
  ///
  /// Currently stores the notification in Firestore.
  /// In a production environment, a Cloud Function would pick this up
  /// and send the actual FCM push.
  Future<void> sendBroadcastNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    emit(AdminNotificationLoading());
    _logger.info('Sending broadcast notification: $title');

    try {
      final notification = NotificationModel(
        title: title,
        body: body,
        createdAt: DateTime.now(),
        data: data,
      );

      await _firestore.collection('notifications').add(notification.toMap());

      // Trigger actual FCM push (via topic for broadcast)
      await NotificationService().sendFCMPushNotification(
        title: title,
        body: body,
        topic: 'all_users',
        data: data,
      );

      _logger
          .info('Broadcast notification stored and FCM triggered successfully');
      emit(
        AdminNotificationSuccess(
          'Notification sent successfully to all users',
        ),
      );
    } catch (e, stackTrace) {
      _logger.error('Failed to send broadcast notification', e, stackTrace);
      emit(AdminNotificationError(e.toString()));
    }
  }

  /// Sends a notification to a specific user.
  Future<void> sendToUser({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    emit(AdminNotificationLoading());
    _logger.info('Sending notification to user $userId: $title');

    try {
      final notification = NotificationModel(
        title: title,
        body: body,
        createdAt: DateTime.now(),
        data: data,
        userId: userId,
      );

      await _firestore.collection('notifications').add(notification.toMap());

      // Trigger actual FCM push (via token if we had it, but here we'll use a placeholder or logic)
      // In a real app, you'd fetch the user's fcmToken first.
      await NotificationService().sendFCMPushNotification(
        title: title,
        body: body,
        data: data,
      );

      _logger.info('User notification stored and FCM triggered successfully');
      emit(AdminNotificationSuccess('Notification sent successfully to user'));
    } catch (e, stackTrace) {
      _logger.error('Failed to send user notification', e, stackTrace);
      emit(AdminNotificationError(e.toString()));
    }
  }
}
