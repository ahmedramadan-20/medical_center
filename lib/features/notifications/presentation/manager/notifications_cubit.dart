import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/notifications/data/repositories/notifications_repository.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {

  NotificationsCubit(this._repository) : super(NotificationsInitial());
  final NotificationsRepository _repository;
  final _logger = LoggerService('NotificationsCubit');
  StreamSubscription? _subscription;

  /// Listens to real-time notifications for the given user.
  void getNotifications(String userId) {
    emit(NotificationsLoading());
    _logger.info('Subscribing to notifications for user: $userId');

    _subscription?.cancel();
    _subscription = _repository.getNotificationsStream(userId).listen(
      (notifications) {
        final unreadCount = notifications.where((n) => !n.isRead).length;
        _logger.debug(
            'Notifications updated: ${notifications.length} total, $unreadCount unread',);
        emit(NotificationsSuccess(notifications, unreadCount));
      },
      onError: (e) {
        _logger.error('Error in notifications stream', e);
        emit(NotificationsError(e.toString()));
      },
    );
  }

  /// Marks a specific notification as read.
  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
    } catch (e) {
      _logger.error('Failed to mark notification as read', e);
    }
  }

  /// Marks all current user's notifications as read.
  Future<void> markAllAsRead(String userId) async {
    try {
      await _repository.markAllAsRead(userId);
    } catch (e) {
      _logger.error('Failed to mark all as read', e);
    }
  }

  /// Deletes a specific notification.
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.deleteNotification(notificationId);
    } catch (e) {
      _logger.error('Failed to delete notification', e);
    }
  }

  /// Clears all notifications for the user.
  Future<void> clearAll(String userId) async {
    try {
      await _repository.clearAll(userId);
    } catch (e) {
      _logger.error('Failed to clear all notifications', e);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
