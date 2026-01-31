import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/core/services/service_locator.dart';

void onBoardingVisited() {
  getIt<CacheHelper>().saveData(key: 'isOnBoardingVisited', value: true);
}
