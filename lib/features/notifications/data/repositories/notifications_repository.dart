import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/home/data/models/notification_model.dart';

class NotificationsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _logger = LoggerService('NotificationsRepository');

  /// Fetches a stream of notifications for a specific user.
  /// Includes both broadcast (userId == null) and personal (userId == userId) notifications.
  Stream<List<NotificationModel>> getNotificationsStream(String userId) {
    _logger.info('Fetching notifications stream for user: $userId');

    // Firestore doesn't support 'not in' or 'null' filtering easily in a single combined stream
    // without complex indexes or separate queries.
    // However, we can fetch all and filter client side OR use separate streams.
    // Given the small expected volume of notifications per user, we will fetch:
    // 1. Notifications with userId == currentUser
    // 2. Notifications with userId == null (broadcast)
    // And merge them.

    return _firestore
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
          .map((doc) => NotificationModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }),)
          .where((n) => n.userId == null || n.userId == userId)
          .toList(),);
  }

  /// Marks a specific notification as read.
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
      _logger.info('Notification marked as read: $notificationId');
    } catch (e) {
      _logger.error('Failed to mark notification as read', e);
      rethrow;
    }
  }

  /// Marks all notifications for a specific user as read.
  Future<void> markAllAsRead(String userId) async {
    try {
      final query = await _firestore
          .collection('notifications')
          .where('isRead', isEqualTo: false)
          .get();

      final batch = _firestore.batch();
      for (final doc in query.docs) {
        final data = doc.data();
        if (data['userId'] == null || data['userId'] == userId) {
          batch.update(doc.reference, {'isRead': true});
        }
      }
      await batch.commit();
      _logger.info('All notifications marked as read for user: $userId');
    } catch (e) {
      _logger.error('Failed to mark all notifications as read', e);
      rethrow;
    }
  }

  /// Deletes a specific notification.
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).delete();
      _logger.info('Notification deleted: $notificationId');
    } catch (e) {
      _logger.error('Failed to delete notification', e);
      rethrow;
    }
  }

  /// Deletes all notifications for a specific user.
  Future<void> clearAll(String userId) async {
    try {
      final query = await _firestore.collection('notifications').get();

      final batch = _firestore.batch();
      for (final doc in query.docs) {
        final data = doc.data();
        if (data['userId'] == null || data['userId'] == userId) {
          batch.delete(doc.reference);
        }
      }
      await batch.commit();
      _logger.info('All notifications cleared for user: $userId');
    } catch (e) {
      _logger.error('Failed to clear all notifications', e);
      rethrow;
    }
  }
}
