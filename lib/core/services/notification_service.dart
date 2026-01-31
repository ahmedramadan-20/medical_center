import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  final _logger = LoggerService('NotificationService');
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    // 1. Request FCM permissions
    await _fcm.requestPermission();

    // 2. Initialize Local Notifications
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        _logger.info('Notification tapped: ${details.payload}');
      },
    );

    // 3. Setup FCM listeners
    FirebaseMessaging.onMessage.listen((message) {
      _logger
          .info('Foreground message received: ${message.notification?.title}');
      if (message.notification != null) {
        _showLocalNotification(
          message.notification!.hashCode,
          message.notification!.title ?? '',
          message.notification!.body ?? '',
          message.data,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info('App opened from notification: ${message.data}');
    });
  }

  Future<void> _showLocalNotification(
    int id,
    String title,
    String body,
    Map<String, dynamic> data,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'app_channel',
      'App Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: data['id'],
    );
  }

  Future<void> onUserLogin(String email) async {
    _logger.info('Cleaning up for user login: $email');
    await _fcm.subscribeToTopic('all_users');
    await updateUserToken(email);
  }

  Future<void> onUserLogout() async {
    _logger.info('Cleaning up for user logout');
    await _fcm.unsubscribeFromTopic('all_users');
  }

  Future<void> updateUserToken(String email) async {
    try {
      final token = await _fcm.getToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .update({'fcmToken': token});
        _logger.info('FCM Token updated for $email');
      }
    } catch (e) {
      _logger.error('Failed to update user token', e);
    }
  }

  Future<void> sendBroadcastNotification({
    required String title,
    required String body,
    String? titleAr,
    String? bodyAr,
    Map<String, dynamic>? data,
  }) async {
    // In a production app, this would call a Cloud Function
    // For now we simulate by showing a local notification if foregrounded
    // Or we could trigger an FCM push if we had a backend key (not recommended client-side)
    _logger.info('Sending broadcast notification: $title');
  }

  Future<void> sendFCMPushNotification({
    required String title,
    String? body,
    String? topic,
    Map<String, dynamic>? data,
  }) async {
    // Placeholder for actual FCM push logic (usually handled server-side)
    _logger.info('FCM Push notification triggered: $title');
  }

  Future<void> scheduleAppointmentReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final reminderTime = scheduledDate.subtract(const Duration(minutes: 30));

    if (reminderTime.isBefore(DateTime.now())) {
      _logger.warning(
        'Skipping schedule: Reminder time $reminderTime is in the past.',
      );
      return;
    }

    final tzDateTime = tz.TZDateTime.from(reminderTime, tz.local);

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'appointment_channel',
          'Appointments',
          channelDescription: 'Reminders for your medical appointments',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    _logger.info('Reminder scheduled for $reminderTime');
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
