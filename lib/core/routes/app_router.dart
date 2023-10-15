import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/auth/presentation/views/sign_in_view.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    path: '/onBoarding',
    builder: (context, state) => BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: OnBoardingView(),
    ),
  ),
  GoRoute(
    path: '/signUp',
    builder: (context, state) => BlocProvider(
      create: (context) => AuthCubit(),
      child: const Directionality(
          textDirection: TextDirection.rtl, child: SignUpView()),
    ),
  ),
  GoRoute(
    path: '/signIn',
    builder: (context, state) => BlocProvider(
      create: (context) => AuthCubit(),
      child: const Directionality(
          textDirection: TextDirection.rtl, child: SignInView()),
    ),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const Directionality(
        textDirection: TextDirection.rtl, child: HomeView()),
  ),
  GoRoute(
    path: '/forgotPassword',
    builder: (context, state) => BlocProvider(
      create: (context) => AuthCubit(),
      child: const Directionality(
          textDirection: TextDirection.rtl, child: ForgotPasswordView()),
    ),
  ),
]);
