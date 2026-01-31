import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/appointments/presentation/views/my_appointments_view.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_cubit.dart';
import 'package:medical_center/features/blood_type/presentation/views/blood_type_view.dart';
import 'package:medical_center/features/home/presentation/views/home_view.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/features/profile/presentation/views/profile_view.dart';
import 'package:medical_center/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

PersistentTabController _controller = PersistentTabController();

class HomeNavBarWidget extends StatelessWidget {
  const HomeNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) => PersistentTabView(
        controller: _controller,
        tabs: _buildTabs(context),
        navBarBuilder: (navBarConfig) => Style12BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      );
}

List<PersistentTabConfig> _buildTabs(BuildContext context) => [
      PersistentTabConfig(
        screen: const HomeView(),
        item: ItemConfig(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          activeForegroundColor: AppColors.primaryColor,
          inactiveForegroundColor: AppColors.babyBlue,
          title: S.of(context).home,
        ),
      ),
      PersistentTabConfig(
        screen: const MyAppointmentsView(),
        item: ItemConfig(
          icon: const Icon(Icons.calendar_today),
          inactiveIcon: const Icon(Icons.calendar_today_outlined),
          activeForegroundColor: AppColors.primaryColor,
          inactiveForegroundColor: AppColors.babyBlue,
          title: S.of(context).appointments,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) => BloodCubit()..getAllBloodTypes(),
          child: const BloodTypeView(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.bloodtype),
          inactiveIcon: const Icon(Icons.bloodtype_outlined),
          activeForegroundColor: AppColors.primaryColor,
          inactiveForegroundColor: AppColors.babyBlue,
          title: S.of(context).blood_types,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) => ProfileCubit()..getUserData(),
          child: const ProfileView(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          activeForegroundColor: AppColors.primaryColor,
          inactiveForegroundColor: AppColors.babyBlue,
          title: S.of(context).profile,
        ),
      ),
    ];
