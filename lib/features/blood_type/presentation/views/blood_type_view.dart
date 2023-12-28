import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_cubit.dart';

import '../../../../generated/l10n.dart';
import '../../../profile/presentation/widgets/custom_appbar_title_widget.dart';
import '../blood_types_cubit/blood_state.dart';
import '../widgets/blood_type_category.dart';
import '../widgets/blood_type_list_tile.dart';

class BloodTypeView extends StatelessWidget {
  const BloodTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodCubit, BloodState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.offWhite,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                SliverToBoxAdapter(
                  child: CustomAppBarTitle(
                    text: S.current.blood_types,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                const SliverToBoxAdapter(
                  child: BloodTypesCategory(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                SliverToBoxAdapter(
                  child: BloodTypesListTile(
                    bloodTypes: context.read<BloodCubit>().firebaseBloodTypes,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
