import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/routes/app_router.dart';
import '../core/utils/app_colors.dart';
import '../generated/l10n.dart';
import 'global_cubit/locale_cubit.dart';
import 'package:medical_center/injection_container.dart' as di;

class MedicalCenter extends StatelessWidget {
  const MedicalCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LocaleCubit>()..getSavedLang(),
        ),

      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) =>previous!=current,
        builder: (context, state) {
          return MaterialApp.router(
            locale: state.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
