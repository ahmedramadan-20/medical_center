import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/appointments/presentation/views/appointment_view.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/views/home_view.dart';
import 'package:medical_center/features/profile/presentation/views/profile_view.dart';
import 'package:medical_center/features/search/presentation/views/search_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../core/utils/app_colors.dart';


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
      create: (context) => HomeCubit()..getAllDoctorsData(context),
      child: const HomeView(),
    ),
    const AppointmentView(),
    const SearchView(),
    const ProfileView()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.deepGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.checklist_rtl_outlined),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.deepGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search_outlined),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.deepGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_outline),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.deepGrey,
    ),
  ];
}
