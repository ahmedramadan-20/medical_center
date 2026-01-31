import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medical_center/app/global_cubit/locale_cubit.dart';
import 'package:medical_center/app/global_cubit/theme_cubit.dart';
import 'package:medical_center/core/routes/app_router.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'package:medical_center/core/theme/app_theme.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/generated/l10n.dart';

/// Root widget of the Medical Center application.
///
/// This widget sets up the app's dependency injection, theming,
/// localization, and routing configuration.
class MedicalCenter extends StatelessWidget {
  const MedicalCenter({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<LocaleCubit>()..getSavedLang(),
          ),
          BlocProvider(
            create: (context) => getIt<ThemeCubit>()..getSavedTheme(),
          ),
          BlocProvider(
            create: (context) => getIt<HomeCubit>(),
          ),
          BlocProvider(
            create: (context) => FavoritesCubit(),
          ),
          BlocProvider(
            create: (context) => getIt<NotificationsCubit>()
              ..getNotifications(
                FirebaseAuth.instance.currentUser?.email ?? '',
              ),
          ),
          BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getUserData(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, localeState) =>
              BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeMode = themeState is ChangeThemeState
                  ? themeState.themeMode
                  : context.read<ThemeCubit>().themeMode;

              return MaterialApp.router(
                locale: localeState.locale,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                routerConfig: router,
              );
            },
          ),
        ),
      );
}
