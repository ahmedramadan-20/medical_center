import 'package:get_it/get_it.dart';
import 'package:medical_center/app/global_cubit/locale_cubit.dart';
import 'package:medical_center/app/repositories/lang_repository.dart';
import 'package:medical_center/app/usecases/change_lang.dart';
import 'package:medical_center/app/usecases/get_saved_lang.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:medical_center/features/auth/data/repositories/auth_repository.dart';
import 'package:medical_center/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:medical_center/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:medical_center/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/notifications/data/repositories/notifications_repository.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/features/splash/data/datasource/lang_local_data_source.dart';
import 'package:medical_center/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global service locator instance using GetIt.
///
/// This provides dependency injection throughout the application,
/// following clean architecture principles with proper layer separation.
final getIt = GetIt.instance;

/// Sets up all dependencies for dependency injection.
///
/// This function registers all required services, repositories, use cases,
/// and cubits/blocs in the correct order to ensure dependencies are available.
Future<void> setupServiceLocator() async {
  // ============ External Dependencies ============
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ============ Core Services ============
  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(sharedPreferences: sharedPreferences),
  );

  // ============ Data Sources ============
  // Language data source
  getIt.registerLazySingleton<LangLocaleDataSource>(
    () => LangLocaleDataSourceImpl(sharedPreferences: getIt()),
  );

  // Authentication data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl.new,
  );

  // ============ Repositories ============
  // Language repository
  getIt.registerLazySingleton<LangRepository>(
    () => LangRepositoryImpl(langLocaleDataSource: getIt()),
  );

  // Authentication repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  // Notifications repository
  getIt.registerLazySingleton<NotificationsRepository>(
    NotificationsRepository.new,
  );

  // ============ Use Cases ============
  // Language use cases
  getIt
    ..registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: getIt()),
    )
    ..registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: getIt()),
    )

    // Authentication use cases
    ..registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: getIt()),
    )
    ..registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: getIt()),
    )
    ..registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(repository: getIt()),
    )

    // ============ Cubits / Blocs ============
    // Locale cubit
    ..registerFactory<LocaleCubit>(
      () => LocaleCubit(
        getSavedLangUseCase: getIt(),
        changeLangUseCase: getIt(),
      ),
    )

    // Authentication cubit
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        signUpUseCase: getIt(),
        signInUseCase: getIt(),
        resetPasswordUseCase: getIt(),
      ),
    )

    // Home cubit
    ..registerFactory<HomeCubit>(HomeCubit.new)

    // Notifications cubit
    ..registerFactory<NotificationsCubit>(
      () => NotificationsCubit(getIt()),
    )

    // Profile cubit
    ..registerFactory<ProfileCubit>(ProfileCubit.new);
}
