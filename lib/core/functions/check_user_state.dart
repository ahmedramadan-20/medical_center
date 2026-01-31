import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:medical_center/core/services/notification_service.dart';

void checkUserState() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
      NotificationService().onUserLogout();
    } else {
      if (kDebugMode) {
        print('User is signed in!');
      }
      if (user.email != null) {
        NotificationService().onUserLogin(user.email!);
      }
    }
  });
}
