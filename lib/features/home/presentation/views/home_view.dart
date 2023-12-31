import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/generated/l10n.dart';
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
        return state is GetUserDataLoadingState || state is GetSpecialitiesLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: AppColors.offWhite,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 28),
                      ),
                      const SliverToBoxAdapter(
                        child: HomeAppBarWidget(),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 20),
                      ),
                      SliverToBoxAdapter(
                          child: CustomHeaderText(
                              text: S.of(context).specialties)),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      ),
                      const SliverToBoxAdapter(
                        child: HomeCategoryWidget(),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 5),
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
