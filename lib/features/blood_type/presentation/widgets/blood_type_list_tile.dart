import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_cubit.dart';

import '../../../../core/functions/custom_toast.dart';
import '../../../home/data/models/blood_type_model.dart';
import '../blood_types_cubit/blood_state.dart';
import 'blood_type_list_item.dart';
import 'empty_blood_types.dart';

// Improved comments for better clarity.
class BloodTypesListTile extends StatelessWidget {
  final List<BloodTypeModel> bloodTypes;

  const BloodTypesListTile({Key? key, required this.bloodTypes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodCubit, BloodState>(
      listener: (context, state) {},
      builder: (context, state) {
        // Handle loading states.
        if (state is GettingBloodTypesLoadingState ||
            state is GettingSpecificBloodTypesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Handle success states.
        if (state is GettingSpecificBloodTypesSuccessState ||
            state is GettingBloodTypesSuccessState) {
          if (bloodTypes.isEmpty) {
            return const EmptyBloodTypes();
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height * 0.5,
            width: 50,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final bloodType = bloodTypes[index];
                return BloodTypeListItem(bloodType: bloodType);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: bloodTypes.length,
            ),
          );
        }

        // Handle error states for GettingSpecificBloodTypesErrorState.
        if (state is GettingSpecificBloodTypesErrorState) {
          showToast(
              "An error occurred while fetching specific blood types. Please try again later.");
          if (kDebugMode) {
            print("Specific Blood Types Error: ${state.error}");
          }
          return const SizedBox();
        }

// Handle error states for GettingBloodTypesErrorState.
        if (state is GettingBloodTypesErrorState) {
          showToast(
              "An error occurred while fetching blood types. Please try again later.");
          if (kDebugMode) {
            print("Blood Types Error: ${state.error}");
          }
          return const SizedBox();
        }

        return const SizedBox();
      },
    );
  }
}
