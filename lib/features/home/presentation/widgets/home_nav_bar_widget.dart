import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/appointments/presentation/views/appointment_view.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/views/home_view.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/features/profile/presentation/views/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../blood_type/presentation/views/blood_type_view.dart';

PersistentTabController _controller = PersistentTabController();

class HomeNavBarWidget extends StatelessWidget {
  const HomeNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      controller: _controller,
      navBarStyle: NavBarStyle.style12,
      backgroundColor: AppColors.white,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData()
        ..getSpecialities()
      // ..getAllDoctorsData(context)
      ,
      child: const HomeView(),
    ),
    const AppointmentView(),
    BlocProvider(
      create: (context) => BloodCubit()..getAllBloodTypes(),
      child: const BloodTypeView(),
    ),
    BlocProvider(
      create: (context) => ProfileCubit()..getUserData(),
      child: const ProfileView(),
    )
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      inactiveIcon: const Icon(Icons.home_outlined),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.babyBlue,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.calendar_today),
      inactiveIcon: const Icon(Icons.calendar_today_outlined),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.babyBlue,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.bloodtype),
      inactiveIcon: const Icon(Icons.bloodtype_outlined),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.babyBlue,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      inactiveIcon: const Icon(Icons.person_outline),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.babyBlue,
    ),
  ];
}
