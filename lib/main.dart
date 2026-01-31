import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/app/medical_center_app.dart';
import 'package:medical_center/core/functions/check_user_state.dart';
import 'package:medical_center/core/services/background_handler.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/notification_service.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'package:medical_center/firebase_options.dart';

/// Entry point of the Medical Center application.
///
/// Initializes Firebase, sets up dependency injection, logging, and starts the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging system
  LoggerService.initialize();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  // Initialize Notification Service
  await NotificationService().initialize();

  // Setup dependency injection
  await setupServiceLocator();

  // Check user authentication state
  checkUserState();

  // Run the app
  runApp(const MedicalCenter());
}
