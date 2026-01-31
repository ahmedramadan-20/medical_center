import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/functions/custom_toast.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';
import 'package:medical_center/features/home/presentation/widgets/custom_doctor_card_widget.dart';
import 'package:medical_center/features/home/presentation/widgets/custom_shimmer_widget.dart';
import 'package:medical_center/generated/l10n.dart';

class HomeDoctorsCardList extends StatelessWidget {
  const HomeDoctorsCardList({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetDoctorsErrorState) {
            showToast(state.error);
          }
        },
        buildWhen: (previous, current) =>
            current is GetDoctorsLoadingState ||
            current is GetDoctorsSuccessState ||
            current is GetDoctorsErrorState ||
            current is ChangeCategoryState ||
            current is DoctorsFilteredState,
        builder: (context, state) {
          if (state is GetDoctorsLoadingState) {
            return const ShimmerWidget();
          }

          final doctors = context.watch<HomeCubit>().filteredDoctors;
          if (doctors.isEmpty) {
            return CustomEmptyWidget(
              title: S.of(context).noDoctorsFound,
              subtitle: S.of(context).noDoctorsInCategory,
            );
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.66,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => DoctorCard(
                model: doctors[index],
                onTap: () {
                  context.push('/doctor', extra: doctors[index]);
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: doctors.length,
            ),
          );
        },
      );
}
