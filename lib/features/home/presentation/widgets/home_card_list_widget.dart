
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return DoctorCard(
                      model: context.read<HomeCubit>().filteredDoctors[index]);
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
                itemCount: context.read<HomeCubit>().filteredDoctors.length)
          // FutureBuilder<List<DoctorsModel>>(
          //   future: BlocProvider.of<HomeCubit>(context).getDoctorsData(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const ShimmerWidget(); // Loading indicator while data is being fetched
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       List<DoctorsModel>? doctors = snapshot.data;
          //
          //       return ListView.builder(
          //         physics: const BouncingScrollPhysics(),
          //         itemCount: doctors?.length,
          //         itemBuilder: (context, index) {
          //           return const SizedBox();
          //             //DoctorCard(model: doctors![index]);
          //         },
          //       );
          //     }
          //   },
          // ),
        );
      },
    );
  }
}