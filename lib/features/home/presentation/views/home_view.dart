import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';
import 'package:medical_center/features/home/presentation/widgets/custom_home_category_widget.dart';
import 'package:medical_center/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:medical_center/features/home/presentation/widgets/home_card_list_widget.dart';
import 'package:medical_center/generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().initHome();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is GetUserDataLoadingState ||
            current is GetUserDataSuccessState ||
            current is GetUserDataErrorState ||
            current is GetSpecialitiesLoadingState ||
            current is GetSpecialitiesSuccessState ||
            current is GetDoctorsSuccessState,
        builder: (context, state) {
          if (state is GetUserDataLoadingState ||
              state is GetSpecialitiesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: AppColors.offWhite,
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: HomeAppBarWidget(),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                    sliver: SliverToBoxAdapter(
                      child: HomeCategoryWidget(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10,),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        S.of(context).ourDoctors,
                        style: AppTextStyles.cairo400Style20.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBlue,
                        ),
                      ),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: HomeDoctorsCardList(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          );
        },
      );
}
