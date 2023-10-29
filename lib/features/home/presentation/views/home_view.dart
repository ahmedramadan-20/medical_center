import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/app/global_cubit/locale_cubit.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/generated/l10n.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_header_text.dart';
import '../widgets/home_app_bar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: HomeAppBarWidget(
                onPressed: () {
                  if (Localizations.localeOf(context).languageCode ==
                      AppStrings.englishCode) {
                    BlocProvider.of<LocaleCubit>(context).toArabic();
                  }else{
                    BlocProvider.of<LocaleCubit>(context).toEnglish();
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
                child: CustomHeaderText(text: S.of(context).today)),
            const SliverToBoxAdapter(
              child: HomeDoctorsCardList(),
            )
          ],
        ),
      ),
    ));
  }
}

class HomeDoctorsCardList extends StatelessWidget {
  const HomeDoctorsCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 7,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                height: 150,
                width: 250,
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
          itemCount: 3),
    );
  }
}
