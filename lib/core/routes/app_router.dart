import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_appointments_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_blood_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_dashboard_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_doctors_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_reviews_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_specialities_cubit.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_users_cubit.dart';
import 'package:medical_center/features/admin/presentation/views/add_edit_doctor_view.dart';
import 'package:medical_center/features/admin/presentation/views/admin_dashboard_view.dart';
import 'package:medical_center/features/admin/presentation/views/admin_send_notification_view.dart';

import 'package:medical_center/features/admin/presentation/views/manage_appointments_view.dart';
import 'package:medical_center/features/admin/presentation/views/manage_blood_records_view.dart';
import 'package:medical_center/features/admin/presentation/views/manage_doctors_view.dart';
import 'package:medical_center/features/admin/presentation/views/manage_reviews_view.dart';
import 'package:medical_center/features/admin/presentation/views/manage_specialities_view.dart';
import 'package:medical_center/features/admin/presentation/views/manage_users_view.dart';
import 'package:medical_center/features/analytics/presentation/views/analytics_view.dart';
import 'package:medical_center/features/appointments/presentation/views/book_appointment_view.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:medical_center/features/auth/presentation/views/forgot_password_view.dart';
import 'package:medical_center/features/auth/presentation/views/sign_in_view.dart';
import 'package:medical_center/features/auth/presentation/views/sign_up_view.dart';
import 'package:medical_center/features/favorites/presentation/views/favorites_view.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/home/presentation/views/doctor_view.dart';
import 'package:medical_center/features/home/presentation/widgets/home_nav_bar_widget.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:medical_center/features/notifications/presentation/views/notifications_view.dart';
import 'package:medical_center/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:medical_center/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:medical_center/features/profile/presentation/views/edit_profile_view.dart';
import 'package:medical_center/features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
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
        create: (context) => getIt<AuthCubit>(),
        child: const SignUpView(),
      ),
    ),
    GoRoute(
      path: '/signIn',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const SignInView(),
      ),
    ),
    GoRoute(
      path: '/homeNavBar',
      builder: (context, state) => const HomeNavBarWidget(),
    ),
    GoRoute(
      path: '/doctor',
      builder: (context, state) => DoctorView(
        model: state.extra! as DoctorsModel,
      ),
    ),
    GoRoute(
      path: '/forgotPassword',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const ForgotPasswordView(),
      ),
    ),
    GoRoute(
      path: '/adminDashboard',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminDashboardCubit()..loadDashboardData(),
        child: const AdminDashboardView(),
      ),
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsView(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesView(),
    ),
    GoRoute(
      path: '/manageDoctors',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminDoctorsCubit()..getAllDoctors(),
        child: const ManageDoctorsScreen(),
      ),
    ),
    GoRoute(
      path: '/addDoctor',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminDoctorsCubit()..getSpecialities(),
        child: const AddEditDoctorScreen(),
      ),
    ),
    GoRoute(
      path: '/editDoctor',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminDoctorsCubit()..getSpecialities(),
        child: AddEditDoctorScreen(
          doctor: state.extra as DoctorsModel?,
        ),
      ),
    ),
    GoRoute(
      path: '/manageAppointments',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminAppointmentsCubit()..getAllAppointments(),
        child: const ManageAppointmentsScreen(),
      ),
    ),
    GoRoute(
      path: '/manageUsers',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminUsersCubit()..getUsers(),
        child: const ManageUsersScreen(),
      ),
    ),
    GoRoute(
      path: '/manageReviews',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminReviewsCubit()..getReviews(),
        child: const ManageReviewsView(),
      ),
    ),
    GoRoute(
      path: '/manageBloodRecords',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminBloodCubit()..getBloodRecords(),
        child: const ManageBloodRecordsScreen(),
      ),
    ),
    GoRoute(
      path: '/manageSpecialities',
      builder: (context, state) => BlocProvider(
        create: (context) => AdminSpecialitiesCubit()..getSpecialities(),
        child: const ManageSpecialitiesScreen(),
      ),
    ),
    GoRoute(
      path: '/bookAppointment',
      builder: (context, state) => BookAppointmentView(
        doctor: state.extra! as DoctorsModel,
      ),
    ),
    GoRoute(
      path: '/editProfile',
      builder: (context, state) => const EditProfileView(),
    ),
    GoRoute(
      path: '/sendNotification',
      builder: (context, state) => const AdminSendNotificationView(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<NotificationsCubit>()
          ..getNotifications(FirebaseAuth.instance.currentUser!.email!),
        child: const NotificationsView(),
      ),
    ),
  ],
);
