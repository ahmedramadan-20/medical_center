import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/blood_type/presentation/widgets/blood_type_category.dart';
import 'package:medical_center/features/blood_type/presentation/widgets/blood_type_list_tile.dart';
import 'package:medical_center/features/profile/presentation/widgets/custom_appbar_title_widget.dart';
import 'package:medical_center/generated/l10n.dart';

class BloodTypeView extends StatelessWidget {
  const BloodTypeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.offWhite,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
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
                child: SizedBox(height: 16),
              ),
              const BloodTypesListTile(), // Now it's a Sliver widget
            ],
          ),
        ),
      );
}
