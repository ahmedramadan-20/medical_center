import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/navigator.dart';

import '../../../../core/functions/custom_toast.dart';
import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_state.dart';
import 'custom_doctor_card_widget.dart';
import 'custom_shimmer_widget.dart';

class HomeDoctorsCardList extends StatelessWidget {
  const HomeDoctorsCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetDoctorsErrorState) {
          showToast(state.error);
        }
      },
      builder: (context, state) {
        return state is GetDoctorsLoadingState
            ? const ShimmerWidget()
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.66,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                        model: context.read<HomeCubit>().filteredDoctors[index],
                        onTap: () {
                          customNavigate(context, "/doctor",
                              extra: context
                                  .read<HomeCubit>()
                                  .filteredDoctors[index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount:
                        context.read<HomeCubit>().filteredDoctors.length));
      },
    );
  }
}
