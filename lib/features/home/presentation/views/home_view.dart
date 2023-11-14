import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/generated/l10n.dart';
import '../../../../core/utils/app_functions.dart';
import '../../../../core/widgets/custom_header_text.dart';
import '../home_cubit/home_state.dart';
import '../widgets/custom_home_category_widget.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/home_card_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.offWhite,
            // bottomNavigationBar: HomeNavBarWidget(),
            // appBar: AppBar(
            //   actions: [
            //     IconButton(
            //       onPressed: () {
            //         FirebaseAuth.instance.signOut();
            //         navigateReplacement(context, '/signIn');
            //       },
            //       icon: const Icon(
            //         Icons.logout,
            //         color: AppColors.primaryColor,
            //       ),
            //     )
            //   ],
            //   elevation: 0,
            //   backgroundColor: AppColors.white,
            //   leading: Builder(builder: (context) {
            //     return IconButton(
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //         // navigateReplacement(context, '/signIn');
            //       },
            //       icon: const Icon(
            //         Icons.menu,
            //         color: AppColors.primaryColor,
            //       ),
            //     );
            //   }),
            //   title: SizedBox(
            //     width: double.infinity,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           S.of(context).hello,
            //           style: AppTextStyles.cairo300style16
            //               .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            //         ),
            //         Text(
            //           S.of(context).subtitle,
            //           style: AppTextStyles.cairo300style16
            //               .copyWith(fontSize: 12, color: AppColors.deepBlue),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // drawer: const Drawer(),
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 28),
              ),
              SliverToBoxAdapter(
                child: HomeAppBarWidget(
                  onPressed: () {
                    changeLanguage(context);
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverToBoxAdapter(
                  child: CustomHeaderText(text: S.of(context).specialties)),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              const SliverToBoxAdapter(
                child: HomeCategoryWidget(),
              ),
              const SliverToBoxAdapter(
                child: HomeDoctorsCardList(),
              ),

            ],
          ),
        ));
      },
    );
  }
}
