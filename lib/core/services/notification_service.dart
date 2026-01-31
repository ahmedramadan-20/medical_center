import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/home/data/models/notification_model.dart';

/// Service for managing Firebase Push Notifications and Local Notifications.
class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  final _logger = LoggerService('NotificationService');
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _notificationTapController =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Stream of notification data when a notification is tapped.
  Stream<Map<String, dynamic>> get onNotificationTap =>
      _notificationTapController.stream;

  /// Initializes the notification service.
  Future<void> initialize() async {
    _logger.info('Initializing NotificationService');

    // Request permissions
    await _requestPermissions();

    // Initialize Local Notifications for Foreground handling
    await _initLocalNotifications();

    // Set up message listeners
    _setupMessageListeners();

    // Subscribe to all_users topic
    await subscribeToTopic('all_users');

    // Handle initial token and refresh
    _initTokenHandling();

    // The listener will now be started via onUserLogin triggered by auth state changes
  }

  /// Called when a user logs in to start relevant listeners.
  void onUserLogin(String email) {
    _logger.info('User logged in: $email. Starting/Restarting listeners.');
    updateUserToken(email);
    _initFirestoreListener();
  }

  /// Called when a user logs out to stop listeners.
  void onUserLogout() {
    _logger.info('User logged out. Stopping listeners.');
    _firestoreSubscription?.cancel();
    _firestoreSubscription = null;
  }

  StreamSubscription<QuerySnapshot>? _firestoreSubscription;

  void _initFirestoreListener() {
    final userEmail = _auth.currentUser?.email;
    if (userEmail == null) {
      _logger.warning('Cannot start Firestore listener: No user email found');
      return;
    }

    _logger.info('Starting Firestore listener for user: $userEmail');

    // Use a slightly older start time to account for clock skew between client and server
    final startTime = DateTime.now().subtract(const Duration(minutes: 1));

    _firestoreSubscription?.cancel();
    _firestoreSubscription = _firestore
        .collection('notifications')
        .where('createdAt', isGreaterThan: startTime)
        .snapshots()
        .listen((snapshot) {
      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data();
          if (data == null) continue;
          final notification = NotificationModel.fromJson({
            ...data,
            'id': change.doc.id,
          });

          // Only trigger for notifications added AFTER the app started listening
          // and for this specific user (or broadcast)
          if (notification.userId == null || notification.userId == userEmail) {
            final diffInSeconds = DateTime.now()
                .difference(notification.createdAt)
                .inSeconds
                .toDouble();

            // If the notification is very old (e.g. from a previous session but caught by startTime), skip it
            if (diffInSeconds > 60) {
              _logger.info('Skipping old notification: ${notification.id}');
              continue;
            }

            _logger.info(
              'New notification detected in Firestore, triggering local alert',
            );
            _showStandaloneNotification(notification);
          }
        }
      }
    });
  }

  Future<void> _showStandaloneNotification(NotificationModel model) async {
    const androidDetails = AndroidNotificationDetails(
      'app_channel',
      'App Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    // Use the title/body based on current locale
    await _localNotifications.show(
      model.id.hashCode,
      model.title,
      model.body,
      notificationDetails,
      payload: jsonEncode(model.data),
    );
  }

  /// Sends a real FCM push notification using the Legacy API.
  ///
  /// IMPORTANT: This requires the FCM Server Key. For production,
  /// this should move to a Cloud Function.
  Future<void> sendFCMPushNotification({
    required String title,
    required String body,
    String? token,
    String? topic,
    Map<String, dynamic>? data,
  }) async {
    // In a real app, you would hit https://fcm.googleapis.com/fcm/send
    // with your Server Key.
    _logger.info('FCM Push Notification triggered for ${topic ?? token}');
    _logger.info('Title: $title, Body: $body');
  }

  void _initTokenHandling() {
    // Initial token save if user is already logged in
    final user = _auth.currentUser;
    if (user != null && user.email != null) {
      updateUserToken(user.email!);
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      final currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.email != null) {
        _logger.info('FCM Token refreshed, updating Firestore');
        _saveTokenToFirestore(currentUser.email!, newToken);
      }
    });
  }

  /// Updates the FCM token for the specified user in Firestore.
  Future<void> updateUserToken(String email) async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _saveTokenToFirestore(email, token);
      }
    } catch (e) {
      _logger.error('Error updating user token', e);
    }
  }

  Future<void> _saveTokenToFirestore(String email, String token) async {
    try {
      // Find the user document by email
      final query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.update({'fcmToken': token});
        _logger.info('FCM Token successfully saved for $email');

        // If user is admin, also subscribe to admin_notifications topic
        final isAdmin = query.docs.first.data()['isAdmin'] ?? false;
        if (isAdmin) {
          await subscribeToTopic('admin_notifications');
        } else {
          await unsubscribeFromTopic('admin_notifications');
        }
      }
    } catch (e) {
      _logger.error('Failed to save token to firestore', e);
    }
  }

  /// Subscribes to a specific topic.
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      _logger.info('Subscribed to topic: $topic');
    } catch (e) {
      _logger.error('Error subscribing to topic: $topic', e);
    }
  }

  /// Unsubscribes from a specific topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      _logger.info('Unsubscribed from topic: $topic');
    } catch (e) {
      _logger.error('Error unsubscribing from topic: $topic', e);
    }
  }

  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _logger.info('User granted notification permissions');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      _logger.info('User granted provisional notification permissions');
    } else {
      _logger.warning(
        'User declined or has not accepted notification permissions',
      );
    }
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          final data = jsonDecode(response.payload!) as Map<String, dynamic>;
          _notificationTapController.add(data);
        }
      },
    );

    // Create a high importance channel for Android
    const androidChannel = AndroidNotificationChannel(
      'app_channel',
      'App Notifications',
      description: 'General app notifications',
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  void _setupMessageListeners() {
    // 1. Foreground State
    FirebaseMessaging.onMessage.listen((message) {
      _logger
          .info('Received foreground message: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    // 2. Background State (Tapped)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info('App opened from background via notification');
      _notificationTapController.add(message.data);
    });

    // 3. Terminated State (Tapped)
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        _logger.info('App opened from terminated state via notification');
        _notificationTapController.add(message.data);
      }
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'app_channel',
      'App Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  /// Gets the current FCM token.
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      return token;
    } catch (e) {
      _logger.error('Error getting FCM token', e);
      return null;
    }
  }

  /// Sends a broadcast notification to all users and stores it in Firestore.
  Future<void> sendBroadcastNotification({
    required String title,
    required String body,
    String? titleAr,
    String? bodyAr,
    Map<String, dynamic>? data,
  }) async {
    try {
      final notification = NotificationModel(
        title: title,
        body: body,
        titleAr: titleAr,
        bodyAr: bodyAr,
        createdAt: DateTime.now(),
        data: data,
      );

      await _firestore.collection('notifications').add(notification.toMap());
      _logger.info('Broadcast notification stored successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to send broadcast notification', e, stackTrace);
    }
  }

  /// Sends a notification to a specific user and stores it in Firestore.
  Future<void> sendToUser({
    required String userId,
    required String title,
    required String body,
    String? titleAr,
    String? bodyAr,
    Map<String, dynamic>? data,
  }) async {
    try {
      final notification = NotificationModel(
        title: title,
        body: body,
        titleAr: titleAr,
        bodyAr: bodyAr,
        createdAt: DateTime.now(),
        data: data,
        userId: userId,
      );

      await _firestore.collection('notifications').add(notification.toMap());
      _logger.info('User notification stored successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to send user notification', e, stackTrace);
    }
  }

  /// Disposes resources.
  void dispose() {
    _notificationTapController.close();
  }
}
