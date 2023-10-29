import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'app/medical_center_app.dart';
import 'core/functions/check_user_state.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  await di.init();
  await getIt<CacheHelper>().init();
  checkUserState();
  runApp(const MedicalCenter());
}

