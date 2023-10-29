import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'app/global_cubit/locale_cubit.dart';
import 'app/repositories/lang_repository.dart';
import 'app/usecases/change_lang.dart';
import 'app/usecases/get_saved_lang.dart';
import 'features/splash/data/datasource/lang_local_data_source.dart';
import 'features/splash/data/repositories/lang_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs

  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));

  // Use cases

  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));

  // Repository

  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocaleDataSource: sl()));

  // Data Sources

  sl.registerLazySingleton<LangLocaleDataSource>(
      () => LangLocaleDataSourceImpl(sharedPreferences: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
