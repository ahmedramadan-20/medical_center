import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/auth/presentation/views/sign_in_view.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/home/presentation/widgets/home_nav_bar_widget.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/doctor_view.dart';
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
      child: const SignUpView(),
    ),
  ),
  GoRoute(
    path: '/signIn',
    builder: (context, state) => BlocProvider(
      create: (context) => AuthCubit(),
      child: const SignInView(),
    ),
  ),
  GoRoute(
    path: '/homeNavBar',
    builder: (context, state) => const HomeNavBarWidget(),
  ),
  GoRoute(
    path: '/doctor',
    builder: (context, state) =>   DoctorView(
      model: state.extra! as DoctorsModel,
    ),
  ),

  GoRoute(
    path: '/forgotPassword',
    builder: (context, state) => BlocProvider(
      create: (context) => AuthCubit(),
      child: const ForgotPasswordView(),
    ),
  ),
]);
