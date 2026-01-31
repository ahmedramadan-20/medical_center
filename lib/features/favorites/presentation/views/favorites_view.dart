import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_state.dart';
import 'package:medical_center/features/home/presentation/widgets/custom_doctor_card_widget.dart';
import 'package:medical_center/generated/l10n.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          title: Text(
            S.of(context).my_favorites,
            style: AppTextStyles.cairo400Style20,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavoritesError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.cairo300style16,
                ),
              );
            }

            if (state is FavoritesLoaded) {
              if (state.doctors.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color:
                                AppColors.primaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 80,
                            color:
                                AppColors.primaryColor.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          S.of(context).no_favorites,
                          style: AppTextStyles.cairo400Style20.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          S.of(context).start_adding_favorites,
                          style: AppTextStyles.cairo300style16.copyWith(
                            fontSize: 15,
                            color: AppColors.deepGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.search),
                          label: Text(S.of(context).browse_doctors),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<FavoritesCubit>().loadFavorites(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = state.doctors[index];
                    return DoctorCard(
                      model: doctor,
                      onTap: () {
                        context.push('/doctor', extra: doctor);
                      },
                    );
                  },
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      );
}
