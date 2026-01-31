import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/custom_toast.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_cubit.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_state.dart';
import 'package:medical_center/features/blood_type/presentation/widgets/blood_type_list_item.dart';
import 'package:medical_center/features/blood_type/presentation/widgets/empty_blood_types.dart';
import 'package:medical_center/features/blood_type/data/models/blood_type_model.dart';
import 'package:medical_center/generated/l10n.dart';

class BloodTypesListTile extends StatelessWidget {
  const BloodTypesListTile({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BloodCubit, BloodState>(
        builder: (context, state) {
          if (state is GettingBloodTypesLoadingState ||
              state is GettingSpecificBloodTypesLoadingState) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          var bloodTypes = <BloodTypeModel>[];
          if (state is GettingBloodTypesSuccessState) {
            bloodTypes = state.bloodTypes;
          } else if (state is GettingSpecificBloodTypesSuccessState) {
            bloodTypes = state.bloodTypes;
          } else {
            // Fallback to cubit's list if state is just index change or initial
            bloodTypes = context.read<BloodCubit>().firebaseBloodTypes;
          }

          if (bloodTypes.isEmpty &&
              (state is GettingBloodTypesSuccessState ||
                  state is GettingSpecificBloodTypesSuccessState)) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyBloodTypes(),
            );
          }

          if (state is GettingSpecificBloodTypesErrorState ||
              state is GettingBloodTypesErrorState) {
            final error = (state is GettingSpecificBloodTypesErrorState)
                ? state.error
                : (state as GettingBloodTypesErrorState).error;

            showToast(context, S.of(context).error_occurred);
            if (kDebugMode) {
              print('Blood Types Error: $error');
            }
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: SizedBox(),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    BloodTypeListItem(bloodType: bloodTypes[index]),
                childCount: bloodTypes.length,
              ),
            ),
          );
        },
      );
}
