
import 'package:flutter/material.dart';
import '../widgets/home_app_bar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
          child: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
          SliverToBoxAdapter(
            child: HomeAppBarWidget(),
          )
      ],
    ),
        ));
  }
}

