import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/core/database/cashe/cache_helper.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'app/medical_center_app.dart';
import 'core/functions/check_user_state.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  checkUserState();
  runApp(const MedicalCenter());
}

