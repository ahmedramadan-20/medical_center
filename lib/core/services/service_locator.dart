import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_center/app/global_cubit/locale_cubit.dart';
import 'package:medical_center/app/global_cubit/theme_cubit.dart';
import 'package:medical_center/app/repositories/lang_repository.dart';
import 'package:medical_center/app/repositories/theme_repository.dart';
import 'package:medical_center/app/usecases/change_lang.dart';
import 'package:medical_center/app/usecases/change_theme.dart';
import 'package:medical_center/app/usecases/get_saved_lang.dart';
import 'package:medical_center/app/usecases/get_saved_theme.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/core/database/cache/theme_local_data_source.dart';
import 'package:medical_center/core/network/network_info.dart';
import 'package:medical_center/core/repositories/theme_repository_impl.dart';
import 'package:medical_center/core/services/sync/sync_service.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_reviews_cubit.dart';
import 'package:medical_center/features/appointments/presentation/manager/appointment_cubit.dart';
import 'package:medical_center/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:medical_center/features/auth/data/repositories/auth_repository.dart';
import 'package:medical_center/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:medical_center/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:medical_center/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/notifications/data/repositories/notifications_repository.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/features/reviews/presentation/manager/review_cubit.dart';
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
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );

  getIt.registerLazySingleton<SyncService>(
    () => SyncService(
      cacheHelper: getIt(),
      connectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(sharedPreferences: sharedPreferences),
  );

  // ============ Data Sources ============
  // Language data source
  getIt.registerLazySingleton<LangLocaleDataSource>(
    () => LangLocaleDataSourceImpl(sharedPreferences: getIt()),
  );

  // Theme data source
  getIt.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(cacheHelper: getIt()),
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

  // Theme repository
  getIt.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(themeLocalDataSource: getIt()),
  );

  // Authentication repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
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

    // Theme use cases
    ..registerLazySingleton<GetSavedThemeUseCase>(
      () => GetSavedThemeUseCase(themeRepository: getIt()),
    )
    ..registerLazySingleton<ChangeThemeUseCase>(
      () => ChangeThemeUseCase(themeRepository: getIt()),
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

    // Theme cubit
    ..registerFactory<ThemeCubit>(
      () => ThemeCubit(
        getSavedThemeUseCase: getIt(),
        changeThemeUseCase: getIt(),
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

    // Appointment cubit
    ..registerFactory<AppointmentCubit>(
      () => AppointmentCubit(
        getIt(),
        getIt(),
      ),
    )

    // Home cubit
    ..registerFactory<HomeCubit>(HomeCubit.new)

    // Notifications cubit
    ..registerFactory<NotificationsCubit>(
      () => NotificationsCubit(getIt()),
    )

    // Admin Reviews cubit
    ..registerFactory<AdminReviewsCubit>(
      () => AdminReviewsCubit(getIt()),
    )

    // Review cubit
    ..registerFactory<ReviewCubit>(
      () => ReviewCubit(
        networkInfo: getIt(),
        syncService: getIt(),
      ),
    )

    // Favorites cubit
    ..registerFactory<FavoritesCubit>(
      () => FavoritesCubit(
        networkInfo: getIt(),
        syncService: getIt(),
      ),
    )

    // Profile cubit
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(
        networkInfo: getIt(),
        syncService: getIt(),
      ),
    );
}
